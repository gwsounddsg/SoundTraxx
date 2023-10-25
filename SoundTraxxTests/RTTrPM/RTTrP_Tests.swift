//
//  RTTrP_Tests.swift
//  SoundTraxxTests
//
//  Created by GW Rodriguez on 10/25/23.
//

import XCTest
import SoundTraxx





class RTTrP_Tests: XCTestCase {

    var rttrp: RTTrP?

    
    override func setUp() {
        do {
            let data = rttrpData
            rttrp = try RTTrP(data: data)
        }
        catch {
            // error handled in first test
        }
    }
}





extension RTTrP_Tests {
    
    func testRTTrP() {
        do {
            let data = rttrpData
            _ = try RTTrP(data: data)
        }
        catch {
            XCTAssert(false, "\(error)")
        }
    }
    
    
    func testRTTrP_blackTraxData() {
        do {
            let data = fromBlackTrax
            _ = try RTTrP(data: data)
        }
        catch {
            XCTAssert(false, "\(error)")
        }
    }
    
    
    func testRTTrP_intSig() {
        XCTAssertEqual(rttrp?.intSig, .bigEndian)
    }
    
    
    func testRTTrP_fltSig() {
        XCTAssertEqual(rttrp?.fltSig, RTTCode.fltSig.motionLittleEndian)
    }
    
    
    func testRTTrP_version() {
        XCTAssertEqual(rttrp?.version, 2)
    }
    
    
    func testRTTrP_packetID() {
        XCTAssertEqual(rttrp?.packetID, 1)
    }
    
    
    func testRTTrP_packetFormat() {
        XCTAssertEqual(rttrp?.packetFormat, .raw)
    }
    
    
    func testRTTrP_size() {
        XCTAssertEqual(rttrp?.size, 231)
    }
    
    
    func testRTTrP_context() {
        XCTAssertEqual(rttrp?.context, UInt32.max)
    }
    
    
    func testRTTrP_modCount() {
        XCTAssertEqual(rttrp?.modCount, 1)
    }
}
