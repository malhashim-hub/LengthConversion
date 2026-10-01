//
//  LengthConversionTests.swift
//  LengthConversionTests
//
//  Created by Mohammed Alhashim on 22/09/2026.
//

import Testing
@testable import LengthConversion

struct LengthConversionTests {

    @Test func metersToKilometers() async throws {
        let result = convert(1000, from: .meters, to: .kilometers)
        #expect(result.value == 1)
    }

    @Test func metersToMiles() async throws {
        let result = convert(1609.344, from: .meters, to: .miles)
        #expect(abs(result.value - 1) < 0.0001)
    }

    @Test func sameUnitIsIdentity() async throws {
        let result = convert(42, from: .feet, to: .feet)
        #expect(result.value == 42)
    }

    @Test func zeroConverts() async throws {
        let result = convert(0, from: .kilometers, to: .miles)
        #expect(result.value == 0)
    }
}
