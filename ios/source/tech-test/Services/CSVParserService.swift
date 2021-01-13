//
//  CSVParserService.swift
//  tech-test
//
//  Created by Robert Majtan on 06/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import CSV
import RealmSwift

protocol CSVParserServiceType {
    func getRecords(from url: URL) throws -> [HospitalModel]
    func getRecordsFromDB() throws -> [HospitalModel]
    func getRecordsFromLocalCSV() throws -> [HospitalModel]
}

class CSVParserService: CSVParserServiceType {

    static let shared = CSVParserService()

    func getRecords(from url: URL) throws -> [HospitalModel] {
        let csvString = try self.convertToCSVString(url)
        let csvReader = try CSVReader(string: csvString,
                                   hasHeaderRow: true,
                                   delimiter: Constants.tabDelimiter)
        return try self.parseRecords(csvReader)
    }

    func getRecordsFromDB() throws -> [HospitalModel] {
        let realm = try! Realm()
        let realmObjects = realm.objects(DBHospitalModel.self)

        var dbData: [HospitalModel] = []
        for object in realmObjects {
            dbData.append(object.createHospitalModel())
        }

        return dbData
    }

    func getRecordsFromLocalCSV() throws -> [HospitalModel] {
        let path = Bundle.main.path(forResource: "Hospital", ofType: "csv")!
        let stream = InputStream(fileAtPath: path)!
        let reader = try CSVReader(stream: stream,
                                   hasHeaderRow: true,
                                   delimiter: Constants.tabDelimiter)
        let records = try parseRecords(reader)
        return records
    }

    func parseRecords(_ reader: CSVReader) throws -> [HospitalModel] {
         var records = [HospitalModel]()
         let decoder = CSVRowDecoder()
         while reader.next() != nil {
             if let row = try? decoder.decode(HospitalModel.self, from: reader) {
                 records.append(row)
             }
         }
         return records
     }

    func convertToCSVString(_ localURL: URL) throws -> String {
         let contents = try Data(contentsOf: localURL)
         let source = String(decoding: contents, as: UTF8.self)
         return source.unicodeScalars.map {
             return ($0.isASCII || $0 != Constants.unicodeDelimiter)
                 ? String($0)
                 : String(Constants.tabDelimiter)
         }.joined()
     }
}
