import AoCCommon

public struct Day10: DaySolver {
    public typealias ParsedData = String
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 10
    public let testInput = "1"

    public func parse(input: String) -> String? { input }

    private func lookAndSay(_ s: String) -> String {
        var result = ""
        var i = s.startIndex

        while i < s.endIndex {
            let char = s[i]
            var j = s.index(after: i)

            while j < s.endIndex && s[j] == char {
                j = s.index(after: j)
            }

            result += "\(s.distance(from: i, to: j))\(char)"
            i = j
        }

        return result
    }

    private func apply(_ data: String, times: Int) -> Int {
        (0..<times).reduce(data) { result, _ in lookAndSay(result) }.count
    }

    public func solvePart1(data: String) -> Int {
        apply(data, times: 40)
    }

    public func solvePart2(data: String) -> Int {
        apply(data, times: 50)
    }
}
