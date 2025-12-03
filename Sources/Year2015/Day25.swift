import AoCCommon
import Foundation

public struct Day25: DaySolver {
    public typealias ParsedData = (row: Int, col: Int)
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 25
    public let testInput =
        "To continue, please consult the code grid in the manual.  Enter the code at row 4, column 2."
    public let expectedTestResult1: Result1? = 32_451_966
    public let expectedTestResult2: Result2? = 0

    public func parse(input: String) -> ParsedData? {
        let numbers = input.integers
        guard numbers.count >= 2 else { return nil }
        return (row: numbers[0], col: numbers[1])
    }

    public func solvePart1(data: ParsedData) -> Int {
        let d = data.row + data.col - 1
        let index = d * (d - 1) / 2 + data.col
        var code = 20_151_125

        for _ in 1..<index {
            code = (code * 252533) % 33_554_393
        }

        return code
    }

    public func solvePart2(data: ParsedData) -> Int {
        // Part 2 is automatically completed when all other puzzles are solved
        0
    }
}
