//
//  TrackedPointAccVelTests.swift
//  SoundTraxxTests
//
//  Created by GW Rodriguez on 10/25/23.
//

import XCTest
import SoundTraxx





class TrackedPointAccVelTest: XCTestCase {

    var module: TrackedPointAccVel!
    
    
    override func setUp() {
        do {
            var data = trackedPointAccVelData
            data.removeFirst() // type
            module = try TrackedPointAccVel(&data)
        }
        catch {
            // checked in first test
        }
    }
}





extension TrackedPointAccVelTest {
    
    func testTrackedPointAccVel() {
        var data = trackedPointAccVelData
        data.removeFirst()
        
        do {
            _ = try TrackedPointAccVel(&data)
            XCTAssertTrue(data.isEmpty)
        }
        catch {
            XCTAssert(false, "\(error)")
        }
    }

    
    func testTrackedPointAccVel_size() {
        XCTAssertEqual(module.size, 52)
    }


    func testTrackedPointAccVel_x() {
        XCTAssertEqual(module.position.x, 9.7888, accuracy: 0.001)
    }


    func testTrackedPointAccVel_y() {
        XCTAssertEqual(module.position.y, 0.0)
    }


    func testTrackedPointAccVel_z() {
        XCTAssertEqual(module.position.z, 2.064, accuracy: 0.001)
    }


    func testTrackedPointAccVel_accx() {
        XCTAssertEqual(module.acceleration.x, -109.643, accuracy: 0.001)
    }


    func testTrackedPointAccVel_accy() {
        XCTAssertEqual(module.acceleration.y, 0.0)
    }


    func testTrackedPointAccVel_accz() {
        XCTAssertEqual(module.acceleration.z, -53.164, accuracy: 0.001)
    }


    func testTrackedPointAccVel_velx() {
        XCTAssertEqual(module.velocity.x, 7.649, accuracy: 0.001)
    }


    func testTrackedPointAccVel_vely() {
        XCTAssertEqual(module.velocity.y, 0.0)
    }


    func testTrackedPointAccVel_velz() {
        XCTAssertEqual(module.velocity.z, -35.083, accuracy: 0.001)
    }
    
    
    func testTrackedPointAccVel_index() {
        XCTAssertEqual(module.index, 1)
    }
}
