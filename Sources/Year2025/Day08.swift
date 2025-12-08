import AoCCommon

public struct Day08: DaySolver {
    public struct Point3D: Hashable {
        let x, y, z: Int
        
        func distanceSquared(to other: Point3D) -> Int {
            let dx = x - other.x, dy = y - other.y, dz = z - other.z
            return dx * dx + dy * dy + dz * dz
        }
    }
    
    public typealias ParsedData = [Point3D]
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}
    public let day = 8
    public let testInput = """
        162,817,812
        57,618,57
        906,360,560
        592,479,940
        352,342,300
        466,668,158
        542,29,236
        431,825,988
        739,650,466
        52,470,668
        216,146,977
        819,987,18
        117,168,530
        805,96,715
        346,949,466
        970,615,88
        941,993,340
        862,61,35
        984,92,344
        425,690,689
        """

    public func parse(input: String) -> [Point3D]? {
        input.lines.map { Point3D(x: $0.integers[0], y: $0.integers[1], z: $0.integers[2]) }
    }

    public func solvePart1(data: [Point3D]) -> Int {
        let edges = sortedEdges(data)
        var parent = Array(0..<data.count)
        var size = Array(repeating: 1, count: data.count)
        
        func find(_ x: Int) -> Int {
            parent[x] != x ? { parent[x] = find(parent[x]); return parent[x] }() : x
        }
        
        func merge(_ x: Int, _ y: Int) {
            let px = find(x), py = find(y)
            guard px != py else { return }
            if size[px] < size[py] { parent[px] = py; size[py] += size[px] }
            else { parent[py] = px; size[px] += size[py] }
        }
        
        edges.prefix(data.count == 20 ? 10 : 1000).forEach { merge($0.1, $0.2) }
        
        var sizes: [Int: Int] = [:]
        (0..<data.count).forEach { sizes[find($0), default: 0] += 1 }
        return sizes.values.sorted(by: >).prefix(3).product()
    }

    public func solvePart2(data: [Point3D]) -> Int {
        let edges = sortedEdges(data)
        var parent = Array(0..<data.count)
        var components = data.count
        
        func find(_ x: Int) -> Int {
            parent[x] != x ? { parent[x] = find(parent[x]); return parent[x] }() : x
        }
        
        for (_, i, j) in edges {
            let pi = find(i), pj = find(j)
            guard pi != pj else { continue }
            parent[pi] = pj
            components -= 1
            if components == 1 { return data[i].x * data[j].x }
        }
        return 0
    }
    
    private func sortedEdges(_ data: [Point3D]) -> [(Int, Int, Int)] {
        var edges: [(Int, Int, Int)] = []
        for i in 0..<data.count {
            for j in (i + 1)..<data.count {
                edges.append((data[i].distanceSquared(to: data[j]), i, j))
            }
        }
        return edges.sorted { $0.0 < $1.0 }
    }
}
