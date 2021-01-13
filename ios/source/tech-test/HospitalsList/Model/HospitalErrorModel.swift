//
//  HospitalErrorModel.swift
//  tech-test
//
//  Created by Robert Majtan on 06/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Foundation

enum HospitalErrorModel: Error {
    case errorDownloadingCSV
    case errorUsingLocalCSV
    case errorUsingLocalDB
    case errorParsingCSV

    var localizedDescription: String {
        switch self {
        case .errorDownloadingCSV:
            return "Error: Unable to download CSV file"
        case .errorUsingLocalCSV:
            return "Error: Unable to load local CSV file"
        case .errorUsingLocalDB:
            return "Error: Unable to load local DB"
        case .errorParsingCSV:
            return "Error: Unable to parse CSV file"
        }
    }
}
