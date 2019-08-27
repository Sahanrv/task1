import UIKit
class Game {
    static let playerCount = 4
    static let itemCount = 4
    
    var players = [Player]()
    var items = [Item]()
    var slotItems = [Item]()
    
    var winner : Player?
    
    var human : Player? {
        return players.first(where: {$0.isHuman})
    }
    
    var bots : [Player] {
        return players.filter({ !$0.isHuman })
    }
    
    func add(Player player : Player) {
        self.players.append(player)
    }
    
    func initialize() {
        for _ in 0 ..< (Game.playerCount - self.players.count) {
            self.add(Player: Player.random())
        }
        items = Item.getList()
    }
    
    func selectItem(item : Item, player : Player) {
        player.selectedItem = item
        var availableItems = self.items.filter({$0.image != item.image}).shuffled()
        for bot in self.bots {
            bot.selectedItem = availableItems.popLast()
        }
    }
    
    func spin() {
        self.slotItems = [Item]()
        for _ in self.items {
            self.slotItems.append(self.items.shuffled()[0])
        }
        self.winner = getWinner()
    }
    
    private func getWinner() -> Player? {
        let sItems = self.slotItems.map({ $0.image })
        if Set(sItems).count != 1 {
            return nil
        }
        
        for player in self.players {
            if player.isWinner(item: self.slotItems[0]) {
                return player
            }
        }
        return nil
    }
    
    func reset() {
        self.slotItems = [Item]()
        self.players.forEach({
            $0.reset()
        })
    }
    
    
}
class Player {
    
    var point : Int!
    var name : String!
    var image : String!
    var selectedItem : Item? {
        didSet {
            guard let item = self.selectedItem else {
                return
            }
            self.point -= item.point
        }
    }
    var isHuman = false
    var isWinner = false
    
    init(withName name : String, image : String, point: Int = 1000, isHuman : Bool = false) {
        self.name = name
        self.image = image
        self.point = point
        self.isHuman = isHuman
    }
    
    func isWinner(item : Item) -> Bool {
        self.isWinner = selectedItem == nil ? false : selectedItem?.image == item.image
        return isWinner
    }
    
    func reset() {
        self.isWinner = false
        self.selectedItem = nil
    }
    
    static func random() -> Player {
        return Player.init(withName: "\(Int.random(in: 0...100)) Player", image: "playerImage")
    }
}
class Item {
    var image : String!
    var point : Int!
    
    init(image : String, point : Int) {
        self.image = image
        self.point = point
    }
    
    static func getList() -> [Item] {
        return [
            Item.init(image: "A", point: 10),
            Item.init(image: "B", point: 20),
            Item.init(image: "C", point: 40),
            Item.init(image: "D", point: 60)
        ]
    }
    
}
let game = Game()
let human = Player.init(withName: "Hasitha", image: "hasitha", isHuman: true)
game.add(Player: human)
game.initialize()
print(game.players)
game.selectItem(item: game.items.first!, player: game.human!)
print(game.human?.selectedItem?.image, game.human?.point)
print("---------")
game.bots.forEach({print($0.selectedItem?.image, $0.point)})
game.spin()
print("-------------------")
game.slotItems.forEach({print($0.image)})
print("++++++++")
game.slotItems = [Item]()
print(game.winner?.name)
print("---------")
game.reset()
