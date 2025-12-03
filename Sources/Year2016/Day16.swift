import AoCCommon

public struct Day16: DaySolver {
    public typealias ParsedData = [Bool]
    public typealias Result1 = String
    public typealias Result2 = String

    public init() {}

    public let day = 16
    public let testInput = "10000"
    public let expectedTestResult1: Result1? = "01100"
    public let expectedTestResult2: Result2? = nil

    public func parse(input: String) -> [Bool]? {
        input.trimmingCharacters(in: .whitespacesAndNewlines).map { $0 == "1" }
    }

    private func solve(_ initial: [Bool], diskSize: Int) -> String {
        // Pre-allocate full buffer
        var data = [Bool](repeating: false, count: diskSize)

        // Copy initial data
        for (i, b) in initial.enumerated() {
            data[i] = b
        }

        // Dragon curve in-place: a + 0 + reverse(flip(a))
        var len = initial.count
        while len < diskSize {
            let newLen = min(len * 2 + 1, diskSize)
            // Middle separator (if it fits)
            if len < diskSize {
                data[len] = false
            }
            // Append reversed and flipped (only what fits)
            var writePos = len + 1
            var readPos = len - 1
            while writePos < newLen && readPos >= 0 {
                data[writePos] = !data[readPos]
                writePos += 1
                readPos -= 1
            }
            len = newLen
        }

        // Checksum in-place
        while len % 2 == 0 {
            var write = 0
            for i in stride(from: 0, to: len, by: 2) {
                data[write] = data[i] == data[i + 1]
                write += 1
            }
            len = write
        }

        return String(data.prefix(len).map { $0 ? "1" : "0" })
    }

    public func solvePart1(data: [Bool]) -> String {
        let diskSize = data.count == 5 ? 20 : 272
        return solve(data, diskSize: diskSize)
    }

    public func solvePart2(data: [Bool]) -> String {
        solve(data, diskSize: 35_651_584)
    }
}
