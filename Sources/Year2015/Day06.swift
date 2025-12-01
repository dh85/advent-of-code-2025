import AoCCommon
import Foundation

public struct Day06: DaySolver {
    public enum Action: Equatable {
        case turnOn, turnOff, toggle
    }

    public struct Instruction: Equatable {
        let action: Action
        let x1, y1, x2, y2: Int
    }

    public typealias ParsedData = [Instruction]
    public typealias Result1 = Int
    public typealias Result2 = Int

    public init() {}

    public let day = 6
    public let testInput = """
        turn on 0,0 through 999,999
        toggle 0,0 through 999,0
        turn off 499,499 through 500,500
        """

    public func parse(input: String) -> [Instruction]? {
        input.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { line in
                let pattern = /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/
                let match = line.firstMatch(of: pattern)!
                let action: Action =
                    switch match.1 {
                    case "turn on": .turnOn
                    case "turn off": .turnOff
                    default: .toggle
                    }
                return Instruction(
                    action: action,
                    x1: Int(match.2)!, y1: Int(match.3)!,
                    x2: Int(match.4)!, y2: Int(match.5)!
                )
            }
    }

    private func processGrid<T: Equatable>(
        data: [Instruction],
        initial: T,
        apply: (Action, inout T) -> Void,
        result: ([T]) -> Int
    ) -> Int {
        var grid = Grid(rows: 1000, cols: 1000, initial: initial)
        for inst in data {
            for x in inst.x1...inst.x2 {
                for y in inst.y1...inst.y2 {
                    apply(inst.action, &grid[x, y])
                }
            }
        }
        return result(grid.data.flatMap { $0 })
    }

    public func solvePart1(data: [Instruction]) -> Int {
        processGrid(
            data: data, initial: false,
            apply: { action, light in
                switch action {
                case .turnOn: light = true
                case .turnOff: light = false
                case .toggle: light.toggle()
                }
            }, result: { $0.filter { $0 }.count })
    }

    public func solvePart2(data: [Instruction]) -> Int {
        processGrid(
            data: data, initial: 0,
            apply: { action, brightness in
                switch action {
                case .turnOn: brightness += 1
                case .turnOff: brightness = max(0, brightness - 1)
                case .toggle: brightness += 2
                }
            }, result: { $0.sum() })
    }
}
