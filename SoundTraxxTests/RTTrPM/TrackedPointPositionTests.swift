//
//  TrackedPointPositionTests.swift
//  SoundTraxxTests
//
//  Created by GW Rodriguez on 10/25/23.
//

import XCTest
import SoundTraxx





class TrackedPointPositionTests: XCTestCase {

    var trackedPoint: TrackedPointPosition?
    

    override func setUp() {
        var data = trackedPointData
        data.removeFirst()
        
        do {
            trackedPoint = try TrackedPointPosition(&data)
        }
        catch {
            // errors are handled in first test
        }
    }
}





extension TrackedPointPositionTests {
    
    func testTrackedPointPosition() {
        var data = trackedPointData
        data.removeFirst()
        
        do {
            _ = try TrackedPointPosition(&data)
            XCTAssertTrue(data.isEmpty)
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    
    func testTrackedPointPosition_size() {
        if trackedPoint == nil {XCTAssert(false); return}
        XCTAssertEqual(Int(trackedPoint!.size), PacketSize.trackedPointPosition.rawValue + 1)
    }
    
    
    func testTrackedPointPosition_latency() {
        XCTAssertEqual(trackedPoint?.latency, 1)
    }
    
    
    func testTrackedPointPosition_x() {
        if trackedPoint == nil {XCTAssert(false); return}
        XCTAssertEqual(trackedPoint!.position.x, 9.7888, accuracy: 0.0001)
    }
    
    
    func testTrackedPointPosition_y() {
        if trackedPoint == nil {XCTAssert(false); return}
        XCTAssertEqual(trackedPoint!.position.y, 0)
    }
    
    
    func testTrackedPointPosition_z() {
        if trackedPoint == nil {XCTAssert(false); return}
        XCTAssertEqual(trackedPoint!.position.z, 2.0647, accuracy: 0.0001)
    }
}
