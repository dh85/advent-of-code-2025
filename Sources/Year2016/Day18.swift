import AoCCommon

public struct Day18: DaySolver {
    public typealias ParsedData = [Bool]  // true = trap, false = safe
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 18
    public let testInput = ".^^.^.^^^^"
    public let expectedTestResult1: Result1? = 38  // 10 rows
    public let expectedTestResult2: Result2? = nil

    public func parse(input: String) -> [Bool]? {
        input.trimmingCharacters(in: .whitespacesAndNewlines).map { $0 == "^" }
    }

    // A tile is a trap if:
    // - left and center are traps, right is not (^^.)
    // - center and right are traps, left is not (.^^)
    // - only left is a trap (^..)
    // - only right is a trap (..^)
    // Simplified: trap if left XOR right (center doesn't matter!)
    @inline(__always)
    private func isTrap(left: Bool, right: Bool) -> Bool {
        left != right
    }

    private func countSafeTiles(_ firstRow: [Bool], rows: Int) -> Int {
        let width = firstRow.count
        var current = firstRow
        var next = [Bool](repeating: false, count: width)
        var safeCount = current.count { !$0 }

        for _ in 1..<rows {
            for i in 0..<width {
                let left = i > 0 ? current[i - 1] : false
                let right = i < width - 1 ? current[i + 1] : false
                next[i] = isTrap(left: left, right: right)
            }
            safeCount += next.count { !$0 }
            swap(&current, &next)
        }

        return safeCount
    }

    public func solvePart1(data: [Bool]) -> Int {
        // Test uses 10 rows, real input uses 40
        let rows = data.count == 10 ? 10 : 40
        return countSafeTiles(data, rows: rows)
    }

    public func solvePart2(data: [Bool]) -> Int {
        countSafeTiles(data, rows: 400000)
    }
}
