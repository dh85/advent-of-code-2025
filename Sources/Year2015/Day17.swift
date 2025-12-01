import AoCCommon

public struct Day17: DaySolver {
    public typealias ParsedData = [Int]
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 17
    public let testInput = """
        20
        15
        10
        5
        5
        """

    public func parse(input: String) -> [Int]? {
        input.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .compactMap { Int($0) }
    }

    public func solvePart1(data: [Int]) -> Int {
        validCombinations(data).count
    }

    public func solvePart2(data: [Int]) -> Int {
        let combinations = validCombinations(data)
        let minCount = combinations.min()!
        return combinations.filter { $0 == minCount }.count
    }

    private func validCombinations(_ data: [Int]) -> [Int] {
        let target = data.count == 5 ? 25 : 150
        var result: [Int] = []
        
        for mask in 0..<(1 << data.count) {
            var sum = 0
            var count = 0
            for i in 0..<data.count {
                if mask & (1 << i) != 0 {
                    sum += data[i]
                    count += 1
                }
            }
            if sum == target {
                result.append(count)
            }
        }
        
        return result
    }
}
