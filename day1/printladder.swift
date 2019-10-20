func makeLadder(row: Int, col: Int) -> Array<<Bool>> {
    var ladders = Array<Bool>() //초기화
    for y in 0..<row{
        var rowLadder = Array<Bool>()
        for x in 0..<col {
            rowLadder.append(false)
        }
        ladders.append(rowLadder)
    }
    return ladders
}

func printLadder(_ ladders: Array<Array<Bool>>){ //매개변수 생략:_
    for row in ladders {
        for col in row {
            print(col? "-": " ")
        }
        print("")
    }
}