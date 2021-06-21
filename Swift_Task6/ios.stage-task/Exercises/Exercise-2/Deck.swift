import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

//    Задание: написать функцию по созданию колоды карт. При создании все карты должны находиться в порядке возрастания и в следующей очередности:
//    1) clubs
//    2) spades
//    3) hearts
//    4) diamonds
    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var cardsDeck = [Card]()
        
        for suit in suits {
            for value in values {
                cardsDeck.append(Card(suit: suit, value: value))
            }
            
        }
        return cardsDeck
    }

    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func defineTrump() {
        if !cards.isEmpty {
            trump = cards[0].suit
            setTrumpCards(for: trump!)
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        
        if !cards.isEmpty {
            var cardsArr = [Card]()
            for player in players {
                for j in 0...5 {
                    cardsArr.append(cards.first!)
                    cards.removeFirst()
                    player.hand = cardsArr
                }
            }
        } else {
            for player in players {
                player.hand = nil
            }
        }

        
    }

    public mutating func setTrumpCards(for suit:Suit) {
        for i in 0..<cards.count {
            if cards[i].suit == trump {
                cards[i].isTrump = true
            }
        }
    }
}

