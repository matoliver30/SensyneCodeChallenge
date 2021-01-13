//
//  Springboard.swift
//  tech-testUITests
//
//  Created by Matheus Milani on 1/11/21.
//  Copyright © 2021 com.ro8i.techtest. All rights reserved.
//

import XCTest

class Springboard {

    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    /**
     Terminate and delete the app via springboard
     */
    class func deleteMyApp(title: String) {
        XCUIApplication().terminate()

        // Force delete the app from the springboard
        let icon = springboard.icons[title]
        if icon.exists {
            let iconFrame = icon.frame
            let springboardFrame = springboard.frame
            
            if #available(iOS 14, *) {
                icon.press(forDuration: 1.3)
                
                let _ = springboard.buttons["Remove App"].waitForExistence(timeout: 5)
                if springboard.buttons["Remove App"].exists {
                    springboard.buttons["Remove App"].tap()
                }
                
                let _ = springboard.alerts.buttons["Delete App"].waitForExistence(timeout: 5)
                if springboard.alerts.buttons["Delete App"].exists {
                    springboard.alerts.buttons["Delete App"].tap()
                }
            } else {
                icon.press(forDuration: 3.0)
                
                // Tap the little "X" button at approximately where it is. The X is not exposed directly
                springboard.coordinate(withNormalizedOffset: CGVector(dx: (iconFrame.minX + 3) / springboardFrame.maxX, dy: (iconFrame.minY + 3) / springboardFrame.maxY)).tap()
            }

            let _ = springboard.alerts.buttons["Delete"].waitForExistence(timeout: 5)
            if springboard.alerts.buttons["Delete"].exists {
                springboard.alerts.buttons["Delete"].tap()
            }
        }
    }
    
    class func verifyAlertOnScreenAndDismiss() {
        let _ = springboard.alerts.buttons["Allow"].waitForExistence(timeout: 10)
        if springboard.alerts.buttons["Allow"].exists {
            springboard.alerts.buttons["Allow"].tap()
        } else if springboard.alerts.buttons["Don't Allow"].exists {
            springboard.alerts.buttons["Don't Allow"].tap()
        } else if springboard.alerts.buttons["Not Now"].exists {
            springboard.alerts.buttons["Not Now"].tap()
        } else if springboard.alerts.buttons["OK"].exists {
            springboard.alerts.buttons["OK"].tap()
        } else if springboard.alerts.buttons["Logout"].exists {
            springboard.alerts.buttons["Logout"].tap()
        } else if springboard.alerts.buttons["Continue"].exists {
            springboard.alerts.buttons["Continue"].tap()
        }
    }
 }
