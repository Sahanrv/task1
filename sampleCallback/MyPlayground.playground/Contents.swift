import UIKit

class A {
    
    let b = B()
    
    
    func callThis(){
    b.closeAlert = {
        print("Called")
    }
        
    }
    
    self.callThis()
    

}

class B {
    
    var closeAlert : (() -> ())?
    
    func CallCallBackFunction(){
        
        closeAlert!()
    }
    
}
