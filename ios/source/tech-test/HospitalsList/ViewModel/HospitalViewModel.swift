//
//  HospitalViewModel.swift
//  tech-test
//
//  Created by Robert Majtan on 05/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class HospitalViewModel: NSObject {

    var service: HospitalServiceType = HospitalService()
    var data: [HospitalModel] = []
    var filteredData: [HospitalModel] = []
    var isFiltering = false

    func getHospitals(completion: @escaping (Result<[HospitalModel], Error>)->()) {
        service.downloadCSVFile() { res in
            switch res {
            case .success(let hospitals):
                self.data = hospitals
                self.service.writeToDB(hospitals: hospitals)
                completion(.success(hospitals))
            case .failure:
                print(HospitalErrorModel.errorDownloadingCSV)
                self.getRecordsFromDB(completion)
            }
        }
    }

    func getRecordsFromDB(_ completion: @escaping (Result<[HospitalModel], Error>)->()) {
        let result = self.service.loadDataFromRealmDB()
        switch result {
        case .success(let hospitals):
            self.data = hospitals
            completion(.success(hospitals))
        case .failure:
            print(HospitalErrorModel.errorUsingLocalCSV)
            self.loadLocalCSVFile(completion)
        }
    }

    func loadLocalCSVFile(_ completion: @escaping (Result<[HospitalModel], Error>)->()) {
        let result = self.service.loadLocalCSVFile()
        switch result {
        case .success(let hospitals):
            self.data = hospitals
            completion(.success(hospitals))
        case .failure:
            print(HospitalErrorModel.errorUsingLocalCSV)
        }
    }
}

extension HospitalViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredData.count : data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: HospitalListCustomCell.identifier, for: indexPath) as! HospitalListCustomCell
        let record = isFiltering ? filteredData[indexPath.row] : data[indexPath.row]
        cell.configure(model: record)
        return cell
    }
}

extension HospitalViewModel {
    func prepareDetailViewController(indexPath: IndexPath) -> HospitalDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HospitalDetailViewController") as! HospitalDetailViewController
        let record = isFiltering ? filteredData[indexPath.row] : data[indexPath.row]
        vc.data = record
        return vc
    }
}

extension HospitalViewModel {
    func filter(text: String) {
        if text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            filteredData = data
            return
        }

        filteredData = data.filter {
            $0.organisationName?.contains(text) ?? false
        }
    }
}
