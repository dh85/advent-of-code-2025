import AoCCommon

public struct Day09: DaySolver {
    public struct Graph: Equatable {
        let distances: [String: [String: Int]]
        let cities: Set<String>
    }

    public typealias ParsedData = Graph
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 9
    public let testInput = """
        London to Dublin = 464
        London to Belfast = 518
        Dublin to Belfast = 141
        """

    public func parse(input: String) -> Graph? {
        var distances: [String: [String: Int]] = [:]
        var cities: Set<String> = []

        for line in input.components(separatedBy: .newlines).filter({ !$0.isEmpty }) {
            let parts = line.split(separator: " ")
            let (from, to, dist) = (String(parts[0]), String(parts[2]), Int(parts[4])!)

            cities.formUnion([from, to])
            distances[from, default: [:]][to] = dist
            distances[to, default: [:]][from] = dist
        }

        return Graph(distances: distances, cities: cities)
    }

    private func routeDistance(_ route: [String], _ graph: Graph) -> Int {
        zip(route, route.dropFirst()).map { graph.distances[$0]![$1]! }.sum()
    }

    public func solvePart1(data: Graph) -> Int {
        Array(data.cities).permutations().map { routeDistance($0, data) }.min()!
    }

    public func solvePart2(data: Graph) -> Int {
        Array(data.cities).permutations().map { routeDistance($0, data) }.max()!
    }
}
