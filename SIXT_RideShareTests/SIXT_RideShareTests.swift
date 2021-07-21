//
//  SIXT_RideShareTests.swift
//  SIXT_RideShareTests
//
//  Created by Mohammad Gharari on 7/16/21.
//

import XCTest
@testable import SIXT_RideShare
class SIXT_RideShareTests: XCTestCase {

    var viewModel:extractAnnotations!
    var rideData:Data!
    let ressourceURL = Bundle.main.url(forResource: "Rides", withExtension: ".json")
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel = extractAnnotations.sharedInstance
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try super.tearDownWithError()
    }

    func testConvertJsonToModel() {
        // given
        rideData = try! Data(contentsOf: ressourceURL!)
        
        // when
        let ridesModel = RideAPI.sharedInstance.buildRideModel(data: rideData)
        
        // then
        XCTAssertNotNil(ridesModel,"TestFailed!")
    }

    
    func testExtractModelToAnnotation() {
        // given
        rideData = try! Data(contentsOf: ressourceURL!)
        let ridesModel = RideAPI.sharedInstance.buildRideModel(data: rideData)
        
        // when
        let annotation = viewModel.configAnnotations(rides: ridesModel)
        
        // then
        XCTAssertNotNil(annotation, "Test Failed!")
        
    }
    func testPerformanceExample() throws {
        // given
        rideData = try! Data(contentsOf: ressourceURL!)
        
        // This is an example of a performance test case.
        
            measure(metrics: [
            XCTClockMetric(), /// To measures elapsed time
            XCTCPUMetric(),     /// To keeps track of CPU activity
            XCTStorageMetric(), /// data the tested code writes to storage.
            XCTMemoryMetric() /// tracks the amount of used physical memory
            ])
            {
                let ridesModel = RideAPI.sharedInstance.buildRideModel(data: rideData)
                _ = viewModel.configAnnotations(rides: ridesModel)
            }
    }

}
