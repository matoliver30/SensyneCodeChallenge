//
//  HospitalModel.swift
//  tech-test
//
//  Created by Robert Majtan on 05/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Foundation

struct HospitalModel: Decodable {
    let organisationID: String?
    let organisationCode: String?
    let organisationType: String?
    let subType: String?
    let sector: String?
    let organisationStatus: String?
    let isPimsManaged: String?
    let organisationName: String?
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String?
    let county: String?
    let postcode: String?
    let latitude: Double?
    let longitude: Double?
    let parentODSCode: String?
    let parentName: String?
    let phone: String?
    let email: String?
    let website: String?
    let fax: String?
    
    private enum CodingKeys : String, CodingKey {
        case organisationID         = "OrganisationID"
        case organisationCode       = "OrganisationCode"
        case organisationType       = "OrganisationType"
        case subType                = "SubType"
        case sector                 = "Sector"
        case organisationStatus     = "OrganisationStatus"
        case isPimsManaged          = "IsPimsManaged"
        case organisationName       = "OrganisationName"
        case address1               = "Address1"
        case address2               = "Address2"
        case address3               = "Address3"
        case city                   = "City"
        case county                 = "County"
        case postcode               = "Postcode"
        case latitude               = "Latitude"
        case longitude              = "Longitude"
        case parentODSCode          = "ParentODSCode"
        case parentName             = "ParentName"
        case phone                  = "Phone"
        case email                  = "Email"
        case website                = "Website"
        case fax                    = "Fax"
    }

    func getFullAddress() -> String {
        var address: [String] = []

        if let address1 = self.address1 {
            address.append("\(address1)")
        }

        if let city = self.city {
            address.append("\(city)")
        }

        if let postCode = self.postcode {
            address.append("\(postCode)")
        }

        if let county = self.county {
            address.append("\(county)")
        }

        return "Address: " + address.joined(separator: ", ")
    }
}
