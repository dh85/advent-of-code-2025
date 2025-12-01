# Advent of Code

Swift solutions for [Advent of Code](https://adventofcode.com).

## Setup

Place your puzzle inputs in `Sources/Year20XX/Resources/` as `day-01.txt`, `day-02.txt`, etc.

## Running

```bash
swift run
```

## Structure

- `Sources/AoCCommon/` - Shared protocol and runner utilities
- `Sources/Year20XX/` - 20XX puzzle solutions and resources
- `Sources/App/` - Executable entry point

## Adding a New Day

1. Create `Sources/Year20XX/DayXX.swift`
2. Implement `DaySolver` protocol
3. Add input file to `Sources/Year20XX/Resources/day-XX.txt`
4. Update `Sources/App/main.swift` to run your day

## Adding a New Year

1. Create new target in `Package.swift` (e.g., `Year2024`)
2. Add `DaySolver+Bundle.swift` extension for that year
3. Create day solutions following the same pattern
