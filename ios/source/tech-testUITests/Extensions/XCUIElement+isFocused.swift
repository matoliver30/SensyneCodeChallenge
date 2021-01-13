//
//  XCUIElement+isFocused.swift
//  tech-testUITests
//
//  Created by Matheus Milani on 1/11/21.
//  Copyright © 2021 com.ro8i.techtest. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElement {
    var isFocused: Bool {
        let isFocused = (self.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        return isFocused
    }
}
