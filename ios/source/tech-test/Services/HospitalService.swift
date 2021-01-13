//
//  HospitalService.swift
//  tech-test
//
//  Created by Robert Majtan on 05/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Foundation
import RealmSwift

protocol HospitalServiceType {
    func downloadCSVFile(completion: @escaping (Result<[HospitalModel], Error>)->())
    func loadDataFromRealmDB() -> Result<[HospitalModel], Error>
    func loadLocalCSVFile() -> Result<[HospitalModel], Error>
    func writeToDB(hospitals: [HospitalModel])
}

class HospitalService: HospitalServiceType {

    var readerService: CSVParserServiceType = CSVParserService.shared

    func downloadCSVFile(completion: @escaping (Result<[HospitalModel], Error>)->()) {

        let task = URLSession.shared.downloadTask(with: Constants.csvURL) { localURL, urlResponse, error in
            guard let localURL = localURL else {
                completion(.failure(HospitalErrorModel.errorDownloadingCSV))
                return
            }

            do {
                let data = try self.readerService.getRecords(from: localURL)
                completion(.success(data))
            } catch {
                completion(.failure(HospitalErrorModel.errorParsingCSV))
            }
        }

        task.resume()
    }

    func loadDataFromRealmDB() -> Result<[HospitalModel], Error> {
       var data = [HospitalModel]()
        do {
            data = try readerService.getRecordsFromDB()
            if data.isEmpty {
                return .failure(HospitalErrorModel.errorUsingLocalDB)
            }
        } catch {
            return .failure(HospitalErrorModel.errorUsingLocalDB)
        }

        return .success(data)
    }

    func loadLocalCSVFile() -> Result<[HospitalModel], Error> {
        var data = [HospitalModel]()
        do {
            data = try readerService.getRecordsFromLocalCSV()
        } catch {
            return .failure(HospitalErrorModel.errorUsingLocalCSV)
        }

        return .success(data)
    }

    func writeToDB(hospitals: [HospitalModel]) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                for record in hospitals {
                    if let id = record.organisationID {
                        if let recordInDB = realm.objects(DBHospitalModel.self).filter("organisationID = '\(id)'").first {
                            try! realm.write {
                                realm.delete(recordInDB)
                                RealmRepository.shared.createDBRecord(for: record)
                            }
                        } else {
                            RealmRepository.shared.createDBRecord(for: record)
                        }
                    }
                }
            }
        }
    }
}
