import Foundation

public func runDay<S: DaySolver>(_ solver: S) {
    let dayString = String(format: "%02d", solver.day)
    print("--- Day \(dayString) ---")

    print("[Test Input]")
    if let testParsedData = solver.parse(input: solver.testInput) {
        let testResult1 = solver.solvePart1(data: testParsedData)
        print("  Part 1: \(testResult1)")  // Relies on CustomStringConvertible

        let testResult2 = solver.solvePart2(data: testParsedData)
        print("  Part 2: \(testResult2)")
    } else {
        print("  Failed to parse test input.")
    }

    print("--------------------")

    print("[Main Input]")
    let fileName = "day-\(dayString)"
    guard let fileInput = readResource(named: fileName, resourceBundler: solver.bundle) else {
        // Error message already printed by readResource
        print("====================")
        return
    }

    if let fileParsedData = solver.parse(input: fileInput) {
        let fileResult1 = solver.solvePart1(data: fileParsedData)
        print("  Part 1: \(fileResult1)")

        let fileResult2 = solver.solvePart2(data: fileParsedData)
        print("  Part 2: \(fileResult2)")
    } else {
        print(" Failed to parse main input file: \(fileInput).txt")
    }
    print("====================")
}

private func readResource(
    named resourceName: String, resourceBundler: Bundle, extension ext: String = "txt"
) -> String? {
    guard let url = resourceBundler.url(forResource: resourceName, withExtension: ext) else {
        print(
            "Error: Resource file '\(resourceName).\(ext)' not found in Swift Package bundle.")
        return nil
    }
    do {
        return try String(contentsOf: url, encoding: .utf8)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    } catch {
        print("Error reading resource file '\(url.path)': \(error)")
        return nil
    }
}
