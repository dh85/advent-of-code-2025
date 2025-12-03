import AoCCommon
import Foundation

public struct Day02: DaySolver {
    public typealias ParsedData = [(start: Int, end: Int)]
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 2
    public let testInput = """
        11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
        """

    public func parse(input: String) -> ParsedData? {
        let line = input.trimmingCharacters(in: .whitespacesAndNewlines)
        let rangeStrings = line.components(separatedBy: ",").filter { !$0.isEmpty }

        return rangeStrings.compactMap { rangeStr in
            let parts = rangeStr.components(separatedBy: "-")
            guard parts.count == 2,
                let start = Int(parts[0]),
                let end = Int(parts[1])
            else {
                return nil
            }
            return (start: start, end: end)
        }
    }

    private func hasRepeatedPattern(_ number: Int, exactlyTwice: Bool) -> Bool {
        let str = String(number)
        let len = str.count

        guard len >= 2 else { return false }

        let maxPatternLen = exactlyTwice ? len / 2 : len / 2

        for patternLen in 1...maxPatternLen {
            guard len % patternLen == 0 else { continue }

            let pattern = str.prefix(patternLen)
            guard !pattern.hasPrefix("0") else { continue }

            let repeatCount = len / patternLen
            if exactlyTwice && repeatCount != 2 { continue }
            if !exactlyTwice && repeatCount < 2 { continue }

            let reconstructed = String(repeating: String(pattern), count: repeatCount)
            if reconstructed == str {
                return true
            }
        }

        return false
    }

    public func solvePart1(data: ParsedData) -> Int {
        data.flatMap { $0.start...$0.end }
            .filter { hasRepeatedPattern($0, exactlyTwice: true) }
            .sum()
    }

    public func solvePart2(data: ParsedData) -> Int {
        data.flatMap { $0.start...$0.end }
            .filter { hasRepeatedPattern($0, exactlyTwice: false) }
            .sum()
    }
}
