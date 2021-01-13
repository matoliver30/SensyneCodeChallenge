//
//  tech_testTests.swift
//  tech-testTests
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import XCTest
import CSV

@testable import tech_test

class tech_testTests: XCTestCase {

    let validData = """
                        OrganisationID,OrganisationCode,OrganisationType,SubType,Sector,OrganisationStatus,IsPimsManaged,OrganisationName,Address1,Address2,Address3,City,County,Postcode,Latitude,Longitude,ParentODSCode,ParentName,Phone,Email,Website,Fax
                        17981,NDA18,Hospital,Hospital,Independent Sector,Visible,True,Woking Community Hospital (Virgin Care),,Heathside Road,,Woking,Surrey,GU22 7HS,51.315132141113281,-0.55628949403762817,NDA,Virgin Care Services Ltd,01483 715911,,,
                        """

    // lat and long as string
    let invalidData = """
                        OrganisationID,OrganisationCode,OrganisationType,SubType,Sector,OrganisationStatus,IsPimsManaged,OrganisationName,Address1,Address2,Address3,City,County,Postcode,Latitude,Longitude,ParentODSCode,ParentName,Phone,Email,Website,Fax
                        17981,NDA18,Hospital,Hospital,Independent Sector,Visible,True,Woking Community Hospital (Virgin Care),,Heathside Road,,Woking,Surrey,GU22 7HS,aaaaaaa,bbbbbbbbb,NDA,Virgin Care Services Ltd,01483 715911,,,
        """

    override func setUp() {
    }

    override func tearDown() {
    }

    func test_valid_hospital_data() {
        do {
            let reader = try CSVReader(string: validData, hasHeaderRow: true)
            var records = [HospitalModel]()
            let decoder = CSVRowDecoder()
            while reader.next() != nil {
                let row = try! decoder.decode(HospitalModel.self, from: reader)
                records.append(row)
            }

            XCTAssertEqual(records[0].organisationID, "17981")
            XCTAssertEqual(records[0].organisationCode, "NDA18")
            XCTAssertEqual(records[0].organisationType, "Hospital")
            XCTAssertEqual(records[0].subType, "Hospital")
            XCTAssertEqual(records[0].sector, "Independent Sector")
            XCTAssertEqual(records[0].isPimsManaged, "True")
            XCTAssertEqual(records[0].organisationName, "Woking Community Hospital (Virgin Care)")
            XCTAssertEqual(records[0].address1, nil)
            XCTAssertEqual(records[0].address2, "Heathside Road")
            XCTAssertEqual(records[0].address3, nil)
            XCTAssertEqual(records[0].city, "Woking")
            XCTAssertEqual(records[0].county, "Surrey")
            XCTAssertEqual(records[0].postcode, "GU22 7HS")
            XCTAssertEqual(records[0].latitude, 51.315132141113281)
            XCTAssertEqual(records[0].longitude, -0.55628949403762817)
            XCTAssertEqual(records[0].parentODSCode, "NDA")
            XCTAssertEqual(records[0].parentName, "Virgin Care Services Ltd")
            XCTAssertEqual(records[0].email, nil)
            XCTAssertEqual(records[0].website, nil)
            XCTAssertEqual(records[0].fax, nil)
            XCTAssertEqual(records[0].phone, "01483 715911")
        } catch {
            XCTFail("Got parsing Error")
        }
    }

    func test_invalid_hospital_data() {
        do {
            let reader = try CSVReader(string: invalidData, hasHeaderRow: true)
            var records = [HospitalModel]()
            let decoder = CSVRowDecoder()
            while reader.next() != nil {
                let row = try decoder.decode(HospitalModel.self, from: reader)
                records.append(row)
            }

            XCTFail("Should not succeffuly map")
        } catch {
            XCTAssert(error.localizedDescription.count > 0, "Should fail")
        }
    }
}
