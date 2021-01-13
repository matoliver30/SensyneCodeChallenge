//
//  XCUIElement+tapWithOffset.swift
//  tech-testUITests
//
//  Created by Matheus Milani on 1/11/21.
//  Copyright © 2021 com.ro8i.techtest. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElement {
  func tapWithOffset(x: CGFloat, y: CGFloat) {
    let normalizedCoordinate = XCUIApplication().coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
    let frameCenterCoordinate = normalizedCoordinate.withOffset(CGVector(dx: self.frame.minX + x, dy: self.frame.minY + y))
    frameCenterCoordinate.tap()
  }
}
