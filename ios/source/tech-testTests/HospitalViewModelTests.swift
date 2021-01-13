//
//  HospitalViewModelTests.swift
//  tech-testTests
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import XCTest

class HospitalViewModelTests: XCTestCase {

    var hospitalService: MockHospitalService!
    var hospitalViewModel: HospitalViewModel!

    override func setUp() {
        hospitalService = MockHospitalService()
        hospitalViewModel = HospitalViewModel()
        hospitalViewModel.service = hospitalService
    }

    override func tearDown() {
        hospitalService = nil
        hospitalViewModel = nil
    }

    func test_get_hospitals() {
        let expect = expectation(description: "OK")
        hospitalViewModel.getHospitals { res in
            switch res {
            case .success(let hospitals):
                XCTAssert(hospitals.isEmpty)
                XCTAssert(self.hospitalService.methodsCalled.contains("downloadCSVFile(completion:)"))
                expect.fulfill()
            case .failure(_):
                XCTFail("Should not fail")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
