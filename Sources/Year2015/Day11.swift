import AoCCommon

public struct Day11: DaySolver {
    public typealias ParsedData = String
    public typealias Result1 = String
    public typealias Result2 = String

    public init() {}

    public let day = 11
    public let testInput = "abcdefgh"

    public func parse(input: String) -> String? { input }

    private func increment(_ password: String) -> String {
        var chars = Array(password)
        var i = chars.count - 1

        while i >= 0 {
            if chars[i] == "z" {
                chars[i] = "a"
                i -= 1
            } else {
                chars[i] = Character(UnicodeScalar(chars[i].asciiValue! + 1))
                break
            }
        }

        return String(chars)
    }

    private func isValid(_ password: String) -> Bool {
        let chars = Array(password)

        guard !chars.contains(where: { "iol".contains($0) }) else { return false }

        let hasStraight = (0..<chars.count - 2).contains { i in
            chars[i].asciiValue! + 1 == chars[i + 1].asciiValue!
                && chars[i + 1].asciiValue! + 1 == chars[i + 2].asciiValue!
        }
        guard hasStraight else { return false }

        var pairs: Set<Character> = []
        var i = 0
        while i < chars.count - 1 {
            if chars[i] == chars[i + 1] {
                pairs.insert(chars[i])
                i += 2
            } else {
                i += 1
            }
        }

        return pairs.count >= 2
    }

    private func nextValid(after password: String) -> String {
        var current = increment(password)
        while !isValid(current) {
            current = increment(current)
        }
        return current
    }

    public func solvePart1(data: String) -> String {
        nextValid(after: data)
    }

    public func solvePart2(data: String) -> String {
        nextValid(after: solvePart1(data: data))
    }
}
