func fizzbuzz(lines: Int) -> Array<String> {
    var result = [String]()
    for index in 1...lines{
        switch(index %3, index %5) {
            case (0,0): //15
                result.append("fizzbuzz")
            case(0,_): //3
                result.append("fizz")
            case(_,0): //5
                result.append("buzz")
            default:
                result.append("\(index)")
        }
    }
}

print(fizzbuzz(lines: 15))