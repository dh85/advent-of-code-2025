import Foundation

public protocol DaySolver {
    associatedtype ParsedData: Equatable
    associatedtype Result1: Equatable
    associatedtype Result2: Equatable

    init()

    var day: Int { get }
    var testInput: String { get }
    var bundle: Bundle { get }

    func parse(input: String) -> ParsedData?
    func solvePart1(data: ParsedData) -> Result1
    func solvePart2(data: ParsedData) -> Result2
}
