import AoCCommon
import Foundation

public struct Day01: DaySolver {
    public struct Instruction: Equatable {
        public let direction: Character
        public let distance: Int
    }

    public typealias ParsedData = [Instruction]
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 1
    public let testInput = """
        L68
        L30
        R48
        L5
        R60
        L55
        L1
        L99
        R14
        L82
        """

    public func parse(input: String) -> [Instruction]? {
        input.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Instruction(direction: $0.first!, distance: Int(String($0.dropFirst()))!) }
    }

    private func move(_ position: Int, direction: Character, steps: Int) -> Int {
        direction == "L"
            ? (position - steps + 100) % 100
            : (position + steps) % 100
    }

    public func solvePart1(data: [Instruction]) -> Int {
        var position = 50
        var zeroCount = 0

        for instruction in data {
            position = move(
                position, direction: instruction.direction, steps: instruction.distance % 100)
            if position == 0 { zeroCount += 1 }
        }

        return zeroCount
    }

    public func solvePart2(data: [Instruction]) -> Int {
        var position = 50
        var zeroCount = 0

        for instruction in data {
            for _ in 0..<instruction.distance {
                position = move(position, direction: instruction.direction, steps: 1)
                if position == 0 { zeroCount += 1 }
            }
        }

        return zeroCount
    }
}
