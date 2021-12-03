import Foundation

do {
    let data = try Data(contentsOfFile: "input")

    let input =
    // 1. The whole input as a string
    String(data: data, encoding: .utf8)?
    // 2. Split the input into lines
        .split(separator: "\n")
    // 3. Split each line into individual chars
        .map { line in
    // 4. Convert those chars into 1's and 0's
            line.compactMap { Int("\($0)", radix: 2) }
        }

    guard let input = input else {
        print("no input")
        exit(EXIT_FAILURE)
    }

    // 5. Input validation to ensure binary nums have equal width
    let width = input.first?.count ?? 0
    assert(input.allSatisfy { $0.count == width })

    // 6. Start with the gamma rate
    let gammaRateBinaryString = input.reduce(
        into: Array(repeating: 0, count: width)
    ) { partialResult, next in
    // 7. Reduce into result array where we start with all 0's
    //    For each position:
    //      - Increment the result if we find a 1
    //      - Decrement the result if we find a 0
        for i in partialResult.indices {
            partialResult[i] += (next[i] == 1) ? 1 : -1
        }
    }
    // 8. If negative, there were more 0's, so result is 0
    //    If positive, there were more 1's, so result is 1
    //    If zero, undefined (this implementation will bias towards 1)
        .map {
            $0 < 0 ? 0 : 1
        }
    // 9. Convert back into a string
        .reduce(into: "", { $0 += "\($1)" })
    // 10. And back into an integer

    guard let gammaRate = Int(gammaRateBinaryString, radix: 2) else {
        exit(EXIT_FAILURE)
    }

    // 11. Flip the bits of gamma rate to get epsilon rate
    //      a. Create bitmask the width of the input binary
    let bitmask = (1 << width) - 1
    //      B. Flip the bits of gammaRate and mask to original width
    let epsilonRate = ~gammaRate & bitmask

    // 12. Multiply them to get the power consumption
    let powerConsumption = gammaRate * epsilonRate
} catch {
    print(error)
}
