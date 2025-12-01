import AoCCommon
import Crypto
import Foundation

/// Recommended running this in release mode
/// `swift run -c release`
public struct Day04: DaySolver {
    public typealias ParsedData = String
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 4
    public let testInput = "abcdef"

    public func parse(input: String) -> String? { input }

    private func hasLeadingZeros(_ hash: [UInt8], count: Int) -> Bool {
        for i in 0..<count / 2 where hash[i] != 0 { return false }
        return count % 2 == 0 || hash[count / 2] < 16
    }

    private func findHash(key: String, zeros: Int) -> Int {
        let keyData = Data(key.utf8)
        var num = 1

        while true {
            var input = keyData
            input.append(contentsOf: String(num).utf8)
            let hash = Array(Insecure.MD5.hash(data: input))

            if hasLeadingZeros(hash, count: zeros) { return num }
            num += 1
        }
    }

    public func solvePart1(data: String) -> Int {
        findHash(key: data, zeros: 5)
    }

    public func solvePart2(data: String) -> Int {
        findHash(key: data, zeros: 6)
    }
}
