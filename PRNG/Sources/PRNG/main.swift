/**
 * Pseudo Random Number Generator
 * This is an expiremental implementation of the Linear Congruential Generator with the multiplier, increment,
 * and modulus values taken from Numerical Recipes.
 * Source: page 17 of http://www.cs.cmu.edu/~tcortina/15110m14/Unit09PtA.pdf
 */

import Darwin // for pow()
import ArgumentParser

// multiplier: a
let a = 1664525
// increment: c
let c = 1013904223
// modulus: m
let m = Int(pow(2.0, 32))

var customSeed = 6734

struct PRNG: ParsableCommand {
    static var configuration = CommandConfiguration(
            abstract: "An experimental PRNG utility.",
            version: "1.0.0")
    
    @Option(help: ArgumentHelp(
                "Seed for the pseudo-random number generator.",
                discussion: "Use this option to override the default seed of 6734."))
    var seed: Int?
    
    @Option(help: "Number of random numbers to print.")
    var size = 5
    
    @Flag(help: ArgumentHelp(
            "Print integers instead of a floating point number between 0 and 1.",
            discussion: "Currently, there is no support for specifying a range. It will be added later."))
    var integer = false
    
    func next() -> Int {
        customSeed = (a * customSeed + c) % m
        return customSeed
    }

    func floatNext() -> Double {
        return Double(next()) / Double(m)
    }
    
    mutating func run() throws {
        customSeed = seed ?? 6734
        
        if seed == nil {
            print("Run PRNG -h for the help menu\nNo value for seed was provided, setting it to the default value: 6734.")
        } else if seed! < 0 {
            print("Seed cannot be negative. Setting it to default value: 6734.")
            customSeed = 6734
        }
        
        for _ in 1...size {
            if integer {
                print(next())
            } else {
                print(floatNext())
            }

        }
    }
}

PRNG.main()

/*

// Generates a


if CommandLine.arguments.count < 2 {
    print("No value for seed was provided, setting default seed to 6734.")
} else if CommandLine.arguments[1] < 0 {
    print("Seed cannot be negative. Setting it to default value: 6734.")
} else {
    seed = CommandLine.arguments[1]
}

print("")
print(floatNext())
print(floatNext())
print(floatNext())
print(floatNext())
print(floatNext())
*/
