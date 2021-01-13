//
//  Constants.swift
//  tech-test
//
//  Created by Robert Majtan on 06/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import Foundation

struct Constants {
    static let csvURL = URL(string: "http://media.nhschoices.nhs.uk/data/foi/Hospital.csv")!
    static let tabDelimiter: Unicode.Scalar = "\t"
    static let unicodeDelimiter: Unicode.Scalar = "\u{FFFD}"
}
