import AoCCommon

public struct Day15: DaySolver {
    public struct Ingredient: Equatable {
        let name: String
        let capacity: Int
        let durability: Int
        let flavor: Int
        let texture: Int
        let calories: Int
    }

    public typealias ParsedData = [Ingredient]
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 15
    public let testInput = """
        Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
        Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
        """

    public func parse(input: String) -> [Ingredient]? {
        input.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { line in
                let p = line.replacingOccurrences(of: ",", with: "").split(separator: " ")
                return Ingredient(
                    name: String(p[0].dropLast()),
                    capacity: Int(p[2])!,
                    durability: Int(p[4])!,
                    flavor: Int(p[6])!,
                    texture: Int(p[8])!,
                    calories: Int(p[10])!
                )
            }
    }

    private func property(
        _ amounts: [Int], _ ingredients: [Ingredient], _ keyPath: KeyPath<Ingredient, Int>
    ) -> Int {
        ingredients.indices.reduce(0) { $0 + amounts[$1] * ingredients[$1][keyPath: keyPath] }
    }

    private func score(_ amounts: [Int], _ ingredients: [Ingredient]) -> Int {
        [\Ingredient.capacity, \.durability, \.flavor, \.texture]
            .map { max(0, property(amounts, ingredients, $0)) }
            .product()
    }

    private func combinations(_ total: Int, _ count: Int) -> [[Int]] {
        guard count > 1 else { return [[total]] }
        return (0...total).flatMap { i in
            combinations(total - i, count - 1).map { [i] + $0 }
        }
    }

    public func solvePart1(data: [Ingredient]) -> Int {
        combinations(100, data.count).map { score($0, data) }.max()!
    }

    public func solvePart2(data: [Ingredient]) -> Int {
        combinations(100, data.count)
            .filter { property($0, data, \.calories) == 500 }
            .map { score($0, data) }
            .max()!
    }
}
