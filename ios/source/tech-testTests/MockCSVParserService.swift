//
//  MockCSVParserService.swift
//  tech-testTests
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Foundation

class MockCSVParserService: CSVParserServiceType {

    var methodsCalled: [String] = []

    func getRecords(from url: URL) throws -> [HospitalModel] {
        methodsCalled.append(#function)
        return []
    }

    func getRecordsFromDB() throws -> [HospitalModel] {
        methodsCalled.append(#function)
        return []
    }

    func getRecordsFromLocalCSV() throws -> [HospitalModel] {
        methodsCalled.append(#function)
        return []
    }
}
