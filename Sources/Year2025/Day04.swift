import AoCCommon

public struct Day04: DaySolver {
    public typealias ParsedData = Grid<Bool>
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 4
    public let testInput = """
        ..@@.@@@@.
        @@@.@.@.@@
        @@@@@.@.@@
        @.@@@@..@.
        @@.@@@@.@@
        .@@@@@@@.@
        .@.@.@.@@@
        @.@@@.@@@@
        .@@@@@@@@.
        @.@.@@@.@.
        """

    public func parse(input: String) -> Grid<Bool>? {
        Grid(parsing: input) { $0 == "@" }
    }

    public func solvePart1(data: Grid<Bool>) -> Int {
        accessible(in: data).count
    }

    public func solvePart2(data: Grid<Bool>) -> Int {
        var grid = data
        var totalRemoved = 0

        while true {
            let toRemove = accessible(in: grid)
            if toRemove.isEmpty { break }
            toRemove.forEach { grid[$0] = false }
            totalRemoved += toRemove.count
        }

        return totalRemoved
    }

    private func accessible(in grid: Grid<Bool>) -> [Point] {
        grid.allPoints.filter { point in
            grid[point]
                && grid.neighbors(of: point, includeDiagonals: true).filter { grid[$0] }.count < 4
        }
    }
}
