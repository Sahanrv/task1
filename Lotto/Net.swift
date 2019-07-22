//  Net.swift
//  Application
//
//  Created by Hasitha Mapalagama on 11/8/18.
//  Copyright © 2018 Treinetic PVT LTD. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import XCGLogger

struct NetStatus {
    static let success = 200
    static let badRequest = 400
    static let authorized = 401
    static let notFound = 404
    static let internalError = 500
    static let serviceUnavailable = 503
}

enum TMethod {
    case get
    case post
    case delete
    case put
    case upload
    case download
}

enum TExpectType {
    case json
    case data
}

class Endpoint {
    
    private var _url : String!
    
    private var _vars = Dictionary<String, String>()
    
    var url : String! {
        get {
            return _url
        }
    }
    
    var urlWithQuery : String! {
        get {
            var urlComp = URLComponents(string: _url)
            urlComp?.queryItems = _vars.map({ (key, val) -> URLQueryItem in
                URLQueryItem(name: key, value: val)
            })
            return urlComp!.url!.absoluteString
        }
    }
    
    init(url : String, vars : Dictionary<String, String>?) {
        self._url = url
        if let v = vars {
            _vars = v
            for (k, v) in _vars {
                self._url = self._url.replacingOccurrences(of: "{\(k)}", with: v)
            }
        }
    }
    
    init(url : String) {
        self._url = url
    }
}

class NetError : Error {
    var code : Int?
    var message : String?
    var type : String?
    var request : Net?
    
    init(code : Int, json : JSON?, net : Net) {
        self.code = code
        self.request = net
        self.message = json?["message"].string ?? "NO MESSAGE FROM REPONSE"
        self.type = json?["message_id"].string ?? "NO MESSAGE ID FROM REPONSE"
    }
    
    init(code : Int, net : Net, message : String? = "NO MESSAGE FROM REPONSE") {
        self.code = code
        self.request = net
        self.message = message
        self.type =  "NO MESSAGE ID FROM REPONSE"
    }
    
    init(message : String) {
        self.code = 6969
        self.message = message
        self.type = "UNDEFINED"
    }
    
    func getMessage() -> String {
        return message ?? "Something went wrong"
    }
}

protocol RequestBuilder {
    func build(net : Net, method : HTTPMethod, alamofire : Alamofire.SessionManager) -> DataRequest
}

class AlamofireRequestBuilder : RequestBuilder {
    func build(net: Net, method: HTTPMethod, alamofire: SessionManager) -> DataRequest {
        return alamofire.request(net.url.url,
                                 method: method,
                                 parameters: net.parameters,
                                 encoding: net.encoding,
                                 headers: net.headers)
    }
}

class HttpBodyRequestBuilder : RequestBuilder {
    func build(net: Net, method: HTTPMethod, alamofire: SessionManager) -> DataRequest {
        var urlRequest = URLRequest(url: URL(string: net.url.url)!)
        urlRequest.httpBody = net.body
        urlRequest.allHTTPHeaderFields = net.headers
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return alamofire.request(urlRequest)
        
    }
}

class NetFile {
    var url : URL?
    var data : Data?
    var name : String!
    var fileName : String?
    var mimeType : String!
    
    init(fileUrl : URL, name : String, fileName : String, mimeType : String) {
        self.url = fileUrl
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
    
    init(fileData : Data, name : String, fileName : String, mimeType : String) {
        self.data = fileData
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
    
    var description : String {
        return "name - \(name!)"
    }
}


class Net {
    static var token : String?
    static var isOffline = false
    
    var url : Endpoint!
    var parameters : Parameters?
    var body : Data?
    var files : [NetFile]?
    var method = TMethod.get
    var encoding : ParameterEncoding = JSONEncoding.default
    var tokenHeader = "Authorization"
    var headers : HTTPHeaders {
        get {
            var header = HTTPHeaders()
            if let t = Net.token {
                header[tokenHeader] = t
            }
            return header
        }
    }
    /// Current request that has been made
    var request : DataRequest?
    /// Unique id for log reference
    var uuid = UUID().uuidString.split(separator: "-")[1]
    /// Expected response type. If reponse cannot parse to this type onError will be called
    var expected = TExpectType.json
    /// Force dispatch error to onError if status code in this array
    var forceDispatchErrorCodes = [Int]()
    /// ignore all types of errors
    var ignoreErrors = false
    /// Ignore response headers. Authorization token will not be saved
    var ignoreResponseHeaders = false
    /// Callback handler for success event
    var onCompletion : ((_ json : Data) -> ())?
    /// Callback handler for error event
    var onError : ((_ error : NetError) -> ())?
    /// Callback handler for progress event
    var onProgress : ((_ fractionCompleted : Double) -> ())?
    /// Response data for current request
    private var responseData : Data?
    /// Network error for current request if any
    private var responseError : NetError?
    
    var isFinish = false
    var isSuccess = false
    
    private var alamofire : Alamofire.SessionManager! {
        get {
            return Alamofire.SessionManager.default
        }
    }
    
    private var builder : RequestBuilder!
    
    init(url : Endpoint, method : TMethod, param : Parameters? = nil) {
        self.url = url
        self.method = method
        self.parameters = param
        self.builder = AlamofireRequestBuilder()
    }
    
    init(url : Endpoint, method : TMethod, body : Data) {
        self.url = url
        self.method = method
        self.body = body
        self.builder = HttpBodyRequestBuilder()
    }
    
    init(url : Endpoint, files : [NetFile]) {
        self.url = url
        self.method = .upload
        self.files = files
    }
    
    func perform() {
        switch self.method {
        case .delete:
            self._delete()
            break
        case .post:
            self._post()
            break
        case .get:
            self._get()
            break
        case .put:
            self._put()
            break
        case .upload:
            self._upload()
            return
        case .download:
            self._download()
        }
        self.process()
    }
    
    private func process() {
        var _param : String = ""
        if let b = self.body {
            _param = " body \(String.init(data: b, encoding: String.Encoding.utf8))"
        }else if let p = self.parameters {
            _param = " param \(p)"
        }else if let f = self.files {
            _param = " files \(f.map({$0.name!}))"
        }
        
        log.debug(toStr("http request \(self.uuid) [\(self.method)]" ,
            " url - ", self.url.url,
            " headers - ", self.headers, _param))
        
        if self.onProgress != nil {
            self.request?.downloadProgress(closure: { progress in
                self.onProgress?(progress.fractionCompleted)
            })
        }
        
        self.request!.responseData(completionHandler: { (response) in
            log.debug(toStr("http request \(self.uuid) complete  [\(self.method)]" ,
                " url - ", self.url.url,
                " params - ", self.parameters as Any,
                " status - ", response.response?.statusCode ?? -1))
            self.isFinish = true
            switch response.result {
            case .success(_) :
                if response.response!.statusCode >= NetStatus.success && response.response!.statusCode < 300 {
                    self.processHeaders(headers: response.response?.allHeaderFields)
                    if self.expected == .json && !self.isJSON(data: response.data){
                        self.error(NetError(code: NetStatus.internalError, net: self, message: "Body cannot parse to json"))
                        return
                    }
                    self.responseData = response.data!
                    self.success(response.data!)
                }else{
                    if let error = self.handleError(response: response, error: nil) {
                        self.responseError = error
                        self.error(error)
                    }
                }
            case .failure(let error) :
                if let error = self.handleError(response: response, error: error) {
                    self.responseError = error
                    self.error(error)
                }
            }
            
        })
    }
    
    func success(_ data : Data) {
        isSuccess = true
        self.onCompletion?(data)
    }
    
    func error(_ error : NetError) {
        isSuccess = false
        self.onError?(error)
    }
    
    func handleError( response : DataResponse<Data>, error : Error?) -> NetError? {
        var netError : NetError? = nil
        
        if error != nil {
            netError = NetError(code: error!._code, net: self, message: error?.localizedDescription)
        }else if let data = response.data {
            netError = NetError(code: response.response?.statusCode ?? NetStatus.internalError, json: try? JSON(data : data) , net: self)
        }else{
            netError = NetError(code: response.response?.statusCode ?? NetStatus.internalError, net: self, message: nil)
        }
        
        if self.ignoreErrors {
            return netError
        }
        
        for _status in self.forceDispatchErrorCodes {
            if netError?.code == _status {
                return netError
            }
        }
        
        if let err = netError {
            return err
        }
        return nil
    }
    
    private func _get() {
        request = builder.build(net: self, method: .get, alamofire: alamofire)
    }
    
    private func _post() {
        request = builder.build(net: self, method: .post, alamofire: alamofire)
        
    }
    
    private func _delete() {
        request = builder.build(net: self, method: .delete, alamofire: alamofire)
    }
    
    private func _put() {
        request = builder.build(net: self, method: .put, alamofire: alamofire)
    }
    
    private func _upload() {
        Alamofire.upload(multipartFormData: { multipart in
            for f in self.files! {
                if let data = f.data{
                    multipart.append(data, withName: f.name, fileName: f.fileName ?? "noname", mimeType: f.mimeType)
                }
                if let url = f.url {
                    multipart.append(url, withName: f.name, fileName: f.fileName ?? "noname", mimeType: f.mimeType)
                }
            }
        }, usingThreshold: UInt64.init(),to: self.url.url, method: .post, headers: headers) { result in
            switch result {
            case .success(let request, _,  _):
                self.request = request
                self.process()
            case .failure(let error) :
                self.error(NetError.init(message: error.localizedDescription))
                log.error(toStr("http upload encoding error", error.localizedDescription))
            }
        }
    }
    
    private func _download() {
        request =  Alamofire.request(self.url.url,
                                     method: .get,
                                     parameters: nil,
                                     encoding: URLEncoding.default,
                                     headers: headers)
    }
    
    private func isJSON(data : Data?) -> Bool {
        if let d = data, let _ =  try? JSON(data : d) {
            return true
        }else{
            return false
        }
    }
    
    
    private func processHeaders(headers : [AnyHashable : Any]?) {
        if self.ignoreResponseHeaders {
            return
        }
        
        if let h = headers {
            if let auth = h[tokenHeader] as? String {
                Net.token = auth
            }
        }
    }
    
    func cancel() {
        self.request?.cancel()
    }
}

let log : XCGLogger = {
    let log = XCGLogger(identifier: "mdgunasena", includeDefaultDestinations: true)
    log.setup(level: .debug,
              showLogIdentifier: false,
              showFunctionName: false,
              showThreadName: false,
              showLevel: true,
              showFileNames: true,
              showLineNumbers: true,
              showDate: false,
              writeToFile: nil,
              fileLevel: nil)
    return log
}()

func toStr(_ args : Any...) -> String {
    let arr = args.map({String(describing: $0)})
    return arr.joined(separator: " ")
}
