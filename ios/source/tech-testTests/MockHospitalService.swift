//
//  MockHospitalService.swift
//  tech-testTests
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Foundation

class MockHospitalService: HospitalServiceType {

    var methodsCalled: [String] = []

    func downloadCSVFile(completion: @escaping (Result<[HospitalModel], Error>)->()) {
        methodsCalled.append(#function)
        completion(.success([]))
    }

    func loadDataFromRealmDB() -> Result<[HospitalModel], Error> {
        methodsCalled.append(#function)
        return .success([])
    }

    func loadLocalCSVFile() -> Result<[HospitalModel], Error> {
        methodsCalled.append(#function)
        return .success([])
    }

    func writeToDB(hospitals: [HospitalModel]) {
        methodsCalled.append(#function)
    }
}
