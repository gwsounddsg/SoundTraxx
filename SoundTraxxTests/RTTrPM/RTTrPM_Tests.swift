//
//  RTTrPM_Tests.swift
//  SoundTraxxTests
//
//  Created by GW Rodriguez on 10/25/23.
//

import XCTest
import SoundTraxx





class RTTrPM_Tests: XCTestCase {

}





extension RTTrPM_Tests {
    
    func testRTTrPM_trackable() {
        var data: [UInt8] = [UInt8(RTTCode.trackable.rawValue)]
        assert(try RTTrPM(&data), throws: RTTError.byteCountTooSmallToInit(.trackable))
    }
    
    
    func testRTTrPM_trackableWithTimestamp() {
        var data: [UInt8] = [UInt8(RTTCode.trackableWithTimestamp.rawValue)]
        assert(try RTTrPM(&data), throws: RTTError.byteCountTooSmallToInit(.trackable))
    }
    
    
    func testRTTrPM_badModuleType() {
        var data: [UInt8] = [255]
        assert(try RTTrPM(&data), throws: RTTError.badModuleType(.unknown))
    }
}
