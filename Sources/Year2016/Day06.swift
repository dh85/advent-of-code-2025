import AoCCommon
import Foundation

public struct Day06: DaySolver {
    public typealias ParsedData = [[Character]]
    public typealias Result1 = String
    public typealias Result2 = String

    public init() {}

    public let day = 6
    public let testInput = """
        eedadn
        drvtee
        eandsr
        raavrd
        atevrs
        tsrnev
        sdttsa
        rasrtv
        nssdts
        ntnada
        svetve
        tesnvt
        vntsnd
        vrdear
        dvrsen
        enarar
        """

    public func parse(input: String) -> [[Character]]? {
        let lines = input.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
        guard !lines.isEmpty else { return nil }
        return lines.map { Array($0) }
    }

    private func decodeMessage(
        from data: [[Character]], using selector: ([Character: Int]) -> Character?
    ) -> String {
        (0..<data[0].count).compactMap { col in
            let frequency = data.reduce(into: [Character: Int]()) { counts, row in
                counts[row[col], default: 0] += 1
            }
            return selector(frequency)
        }.map(String.init).joined()
    }

    public func solvePart1(data: [[Character]]) -> String {
        decodeMessage(from: data) { $0.max(by: { $0.value < $1.value })?.key }
    }

    public func solvePart2(data: [[Character]]) -> String {
        decodeMessage(from: data) { $0.min(by: { $0.value < $1.value })?.key }
    }
}
