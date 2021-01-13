//
//  HospitalServiceTests.swift
//  tech-testTests
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import XCTest

class HospitalServiceTests: XCTestCase {

    let hospitalService = HospitalService()
    var readerService: MockCSVParserService!

    override func setUp() {
        readerService = MockCSVParserService()
        hospitalService.readerService = readerService
    }

    override func tearDown() {}

    func test_sucessful_load_of_local_csv_data() {
        let res = hospitalService.loadLocalCSVFile()
        switch res {
        case .success(let hospitals):
            XCTAssert(hospitals.count == 0)
            XCTAssert(self.readerService.methodsCalled.contains("getRecordsFromLocalCSV()"))
        case .failure(_):
            XCTFail("Should not fail")
        }
    }
}

