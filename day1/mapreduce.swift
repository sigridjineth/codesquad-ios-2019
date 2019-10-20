func complex(from array: [Int]) -> Int {
    array.filter({ $0 % 2 == 0 || $0 % 3 == 0})
    .map({$0 * 5})
    .reduce(Dictionary<Int, Int>(), { $0["result"] = $0["result"] + $1})