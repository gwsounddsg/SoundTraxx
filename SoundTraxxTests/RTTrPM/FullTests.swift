//
//  FullTests.swift
//  SoundTraxxTests
//
//  Created by GW Rodriguez on 10/25/23.
//

import XCTest
import SoundTraxx


class FullTests: XCTestCase {}





extension FullTests {
    
    func testFullTests_onePacket() {
        do {
            let data = Data(rttData)
            _ = try RTTrP(data: data.bytes)
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
