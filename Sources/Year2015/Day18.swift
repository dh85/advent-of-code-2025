import AoCCommon

public struct Day18: DaySolver {
    public typealias ParsedData = Grid<Bool>
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 18
    public let testInput = """
        .#.#.#
        ...##.
        #....#
        ..#...
        #.#..#
        ####..
        """

    public func parse(input: String) -> Grid<Bool>? {
        let lines = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard !lines.isEmpty else { return nil }
        var grid = Grid(rows: lines.count, cols: lines[0].count, initial: false)
        for (r, line) in lines.enumerated() {
            for (c, char) in line.enumerated() {
                grid[r, c] = char == "#"
            }
        }
        return grid
    }

    public func solvePart1(data: Grid<Bool>) -> Int {
        simulate(data, steps: data.rows == 6 ? 4 : 100, stuckCorners: false)
    }

    public func solvePart2(data: Grid<Bool>) -> Int {
        simulate(data, steps: data.rows == 6 ? 5 : 100, stuckCorners: true)
    }

    private func simulate(_ grid: Grid<Bool>, steps: Int, stuckCorners: Bool) -> Int {
        var current = stuckCorners ? fixCorners(grid) : grid

        for _ in 0..<steps {
            current = step(current)
            if stuckCorners { current = fixCorners(current) }
        }

        return current.data.flatMap { $0 }.filter { $0 }.count
    }

    private func step(_ grid: Grid<Bool>) -> Grid<Bool> {
        var next = grid
        for r in 0..<grid.rows {
            for c in 0..<grid.cols {
                let neighbors = grid.neighbors(row: r, col: c, includeDiagonals: true)
                    .filter { grid[$0.0, $0.1] }.count
                next[r, c] = grid[r, c] ? (neighbors == 2 || neighbors == 3) : neighbors == 3
            }
        }
        return next
    }

    private func fixCorners(_ grid: Grid<Bool>) -> Grid<Bool> {
        var result = grid
        let last = grid.rows - 1
        result[0, 0] = true
        result[0, last] = true
        result[last, 0] = true
        result[last, last] = true
        return result
    }
}
