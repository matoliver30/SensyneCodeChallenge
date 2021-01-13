//
//  RealmRepository.swift
//  tech-test
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Realm
import RealmSwift

class RealmRepository {

    static let shared = RealmRepository()

    func createDBRecord(for hospital: HospitalModel) {
        let dbHospitals = DBHospitalModel()
        dbHospitals.organisationName = hospital.organisationName ?? ""
        dbHospitals.organisationID = hospital.organisationID ?? ""
        dbHospitals.organisationCode = hospital.organisationCode ?? ""
        dbHospitals.organisationType = hospital.organisationType ?? ""
        dbHospitals.subType = hospital.subType ?? ""
        dbHospitals.sector = hospital.sector ?? ""
        dbHospitals.organisationStatus = hospital.organisationStatus ?? ""
        dbHospitals.isPimsManaged = hospital.isPimsManaged ?? ""
        dbHospitals.organisationName = hospital.organisationName ?? ""
        dbHospitals.address1 = hospital.address1 ?? ""
        dbHospitals.address2 = hospital.address2 ?? ""
        dbHospitals.address3 = hospital.address3 ?? ""
        dbHospitals.city = hospital.city ?? ""
        dbHospitals.county = hospital.county ?? ""
        dbHospitals.postcode = hospital.postcode ?? ""
        dbHospitals.latitude = hospital.latitude ?? 0.0
        dbHospitals.longitude = hospital.longitude ?? 0.0
        dbHospitals.parentODSCode = hospital.parentODSCode ?? ""
        dbHospitals.parentName = hospital.parentName ?? ""
        dbHospitals.phone = hospital.phone ?? ""
        dbHospitals.email = hospital.email ?? ""
        dbHospitals.website = hospital.website ?? ""
        dbHospitals.fax = hospital.fax ?? ""

        write(object: dbHospitals)
    }

    func write(object: Object) {
        let realm = try! Realm()

        if realm.isInWriteTransaction {
            realm.add(object)
        } else {
            try! realm.write {
                realm.add(object)
            }
        }
    }
}
