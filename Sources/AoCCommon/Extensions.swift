import Foundation

// MARK: - String Extensions
extension String {
    /// Returns all integers found in the string
    public var integers: [Int] {
        components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap { Int($0) }
    }
}

// MARK: - Collection Extensions
extension Collection {
    /// Returns all permutations of the collection
    public func permutations() -> [[Element]] {
        guard count > 1 else { return [Array(self)] }
        var result: [[Element]] = []
        var array = Array(self)

        func permute(_ n: Int) {
            if n == 1 {
                result.append(array)
                return
            }
            for i in 0..<n {
                permute(n - 1)
                if n % 2 == 0 {
                    array.swapAt(i, n - 1)
                } else {
                    array.swapAt(0, n - 1)
                }
            }
        }

        permute(array.count)
        return result
    }
}

// MARK: - Sequence Extensions
extension Sequence where Element: AdditiveArithmetic {
    /// Returns the sum of all elements
    public func sum() -> Element {
        reduce(.zero, +)
    }
}

extension Sequence where Element: Numeric {
    /// Returns the product of all elements
    public func product() -> Element {
        reduce(1, *)
    }
}

// MARK: - Grid Utilities
public struct Grid<T: Equatable>: Equatable {
    public var data: [[T]]
    public var rows: Int { data.count }
    public var cols: Int { data.first?.count ?? 0 }

    public init(rows: Int, cols: Int, initial: T) {
        data = Array(repeating: Array(repeating: initial, count: cols), count: rows)
    }

    public subscript(row: Int, col: Int) -> T {
        get { data[row][col] }
        set { data[row][col] = newValue }
    }

    public func neighbors(row: Int, col: Int, includeDiagonals: Bool = false) -> [(Int, Int)] {
        let deltas =
            includeDiagonals
            ? [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            : [(-1, 0), (0, -1), (0, 1), (1, 0)]

        return deltas.compactMap { dr, dc in
            let r = row + dr
            let c = col + dc
            return (0..<rows).contains(r) && (0..<cols).contains(c) ? (r, c) : nil
        }
    }
}

// MARK: - Math Utilities
public func gcd(_ a: Int, _ b: Int) -> Int {
    b == 0 ? abs(a) : gcd(b, a % b)
}

public func lcm(_ a: Int, _ b: Int) -> Int {
    a * b / gcd(a, b)
}
