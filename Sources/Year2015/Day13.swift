import AoCCommon

public struct Day13: DaySolver {
    public struct Seating: Equatable {
        let happiness: [String: [String: Int]]
        let people: Set<String>
    }

    public typealias ParsedData = Seating
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 13
    public let testInput = """
        Alice would gain 54 happiness units by sitting next to Bob.
        Alice would lose 79 happiness units by sitting next to Carol.
        Alice would lose 2 happiness units by sitting next to David.
        Bob would gain 83 happiness units by sitting next to Alice.
        Bob would lose 7 happiness units by sitting next to Carol.
        Bob would lose 63 happiness units by sitting next to David.
        Carol would lose 62 happiness units by sitting next to Alice.
        Carol would gain 60 happiness units by sitting next to Bob.
        Carol would gain 55 happiness units by sitting next to David.
        David would gain 46 happiness units by sitting next to Alice.
        David would lose 7 happiness units by sitting next to Bob.
        David would gain 41 happiness units by sitting next to Carol.
        """

    public func parse(input: String) -> Seating? {
        var happiness: [String: [String: Int]] = [:]
        var people: Set<String> = []

        for line in input.components(separatedBy: .newlines).filter({ !$0.isEmpty }) {
            let parts = line.split(separator: " ")
            let (person, neighbor) = (String(parts[0]), String(parts[10].dropLast()))
            let value = Int(parts[3])! * (parts[2] == "gain" ? 1 : -1)

            people.insert(person)
            happiness[person, default: [:]][neighbor] = value
        }

        return Seating(happiness: happiness, people: people)
    }

    private func calculateHappiness(_ arrangement: [String], _ seating: Seating) -> Int {
        arrangement.indices.map { i in
            let person = arrangement[i]
            let neighbors = [
                arrangement[(i - 1 + arrangement.count) % arrangement.count],
                arrangement[(i + 1) % arrangement.count],
            ]
            return neighbors.map { seating.happiness[person]?[$0] ?? 0 }.sum()
        }.sum()
    }

    private func optimalHappiness(_ seating: Seating) -> Int {
        Array(seating.people).permutations().map { calculateHappiness($0, seating) }.max()!
    }

    public func solvePart1(data: Seating) -> Int {
        optimalHappiness(data)
    }

    public func solvePart2(data: Seating) -> Int {
        var happiness = data.happiness
        var people = data.people
        people.insert("Me")

        for person in data.people {
            happiness["Me", default: [:]][person] = 0
            happiness[person]!["Me"] = 0
        }

        return optimalHappiness(Seating(happiness: happiness, people: people))
    }
}
