//
//  DBHospitalModel.swift
//  tech-test
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Foundation
import RealmSwift

class DBHospitalModel: Object {
    @objc dynamic var organisationID: String = ""
    @objc dynamic var organisationCode: String = ""
    @objc dynamic var organisationType: String = ""
    @objc dynamic var subType: String = ""
    @objc dynamic var sector: String = ""
    @objc dynamic var organisationStatus: String = ""
    @objc dynamic var isPimsManaged: String = ""
    @objc dynamic var organisationName: String = ""
    @objc dynamic var address1: String = ""
    @objc dynamic var address2: String = ""
    @objc dynamic var address3: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var county: String = ""
    @objc dynamic var postcode: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude:Double = 0.0
    @objc dynamic var parentODSCode: String = ""
    @objc dynamic var parentName: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var fax: String = ""

    func createHospitalModel() -> HospitalModel {
        let model = HospitalModel(organisationID: self.organisationID,
                                  organisationCode: self.organisationCode,
                                  organisationType: self.organisationType,
                                  subType: self.subType,
                                  sector: self.sector,
                                  organisationStatus: self.organisationStatus,
                                  isPimsManaged: self.isPimsManaged,
                                  organisationName: self.organisationName,
                                  address1: self.address1,
                                  address2: self.address2,
                                  address3: self.address3,
                                  city: self.city,
                                  county: self.county,
                                  postcode: self.postcode,
                                  latitude: self.latitude,
                                  longitude: self.longitude,
                                  parentODSCode: self.parentODSCode,
                                  parentName: self.parentName,
                                  phone: self.phone,
                                  email: self.email,
                                  website: self.website,
                                  fax: self.fax)

        return model
    }
}
