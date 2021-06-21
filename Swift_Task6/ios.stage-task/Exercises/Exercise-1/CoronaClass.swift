import Foundation

class CoronaClass {
 
    var seats = [Int]()
    var freeSeats = [Int]()
    var seatsCount = Int()
    
    init(n: Int) {
        for i in 0...n-1 {
            freeSeats.append(i)
        }
        seatsCount = n
     }
     
    func seat() -> Int {
        if freeSeats.count == seatsCount {
            seats.append(freeSeats[0])
            let seat = freeSeats[0]
            freeSeats.removeFirst()
            return seat
        }
        if freeSeats.count == seatsCount-1 {
            seats.append(freeSeats.last!)
            let seat = freeSeats.last!
            freeSeats.removeLast()
            return seat
        } else {
            var differences = [[Int]]()
            seats.sort(){$0>$1}
            var diff = 0
            for i in -2..<seats.count-1 {
                if freeSeats.last == seatsCount-1 && i == -1 {
                    differences.append([freeSeats.last!-seats[i+1],freeSeats.last!,seats[i+1]])
                    diff = (freeSeats.last!-seats[i+1])
                }
                if freeSeats.first == 0 && i == -2 {
                    differences.append([seats[i+2]-freeSeats.first!,seats[i+2],freeSeats.first!])
                    diff = (seats[i+2]-freeSeats.first!)
                }
                if i > -1 && seats[i]-seats[i+1] >= diff {
                    if (seats[i]-seats[i+1])%2 != 0 {
                        differences.append([seats[i]-seats[i+1],seats[i],seats[i+1]])
                        diff = (seats[i]-seats[i+1]-1)
                    } else {
                        differences.append([seats[i]-seats[i+1],seats[i],seats[i+1]])
                        diff = (seats[i]-seats[i+1])
                    }

                }
            }
            var middles = [Int]()
            for i in 0..<differences.count {
                let middle = differences[i][0]/2
                middles.append(Int(middle)+differences[i][2])
            }
            middles.sort(){$0<$1}
            if freeSeats.last == seatsCount-1 {
                seats.append(freeSeats.last!)
                let seat = middles.last!
                freeSeats.removeLast()
                seats.sort(){$0<$1}
                return seat
            }
            if freeSeats.first == 0 {
                seats.append(freeSeats.first!)
                let seat = middles.last!
                freeSeats.removeFirst()
                seats.sort(){$0<$1}
                return seat
            }
            else {
                seats.append(middles[0])
                let seat = middles[0]
                freeSeats.remove(at: freeSeats.firstIndex(of: middles[0])!)
                seats.sort(){$0<$1}
                return seat
            }
  
        }

     }
     
    func leave(_ p: Int) {
        if !(seats[seats.firstIndex(of: p)!] < 0) {
            freeSeats.append(p)
            seats.remove(at: seats.firstIndex(of: p)!)
        }
     }
}
