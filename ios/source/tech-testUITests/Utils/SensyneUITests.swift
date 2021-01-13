//
//  SensyneUITests.swift
//  tech-testUITests
//
//  Created by Matheus Milani on 1/11/21.
//  Copyright © 2021 com.ro8i.techtest. All rights reserved.
//

import Foundation
import XCTest

enum SwipeDirection {
    case up
    case down
    case left
    case right
}

protocol SensyneUITests: XCTestCase {
    // Global configuration
    var app: XCUIApplication { get }
    
    // Interaction helpers
    func checkButton(existsWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval?, from rootQuery: XCUIElement?, andIsEnabled isEnabled: Bool, andIsTappable isTappable: Bool, withButtonTitle buttonTitle: String?, file: StaticString, line: UInt) -> XCUIElement
    func checkLink(existsWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval?, from rootQuery: XCUIElement?, andIsTappable isTappable: Bool, file: StaticString, line: UInt)
    func tapButton(withIdentifier identifier: String, waitingFor timeToWait: TimeInterval?, from rootQuery: XCUIElement?, file: StaticString, line: UInt)
    func checkText(_ value: String?, existsWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval?, from rootQuery: XCUIElement?, isTextView: Bool, isTextField: Bool, isOtherElement: Bool, file: StaticString, line: UInt) -> XCUIElement
    func type(text: String, intoTextFieldWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval?, from rootQuery: XCUIElement?, isSecure: Bool, isSearchView: Bool, file: StaticString, line: UInt) -> XCUIElement
    func wait(_ timeToWait: UInt32, because reasonForWaiting: String)
    func swipe(toElement element: XCUIElement, maxScrolls: Int, inDirection direction: SwipeDirection, file: StaticString, line: UInt)
}

extension SensyneUITests {
    func checkButton(existsWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval? = nil, from rootQuery: XCUIElement? = nil, andIsEnabled isEnabled: Bool = true, andIsTappable isTappable: Bool = true, withButtonTitle buttonTitle: String? = nil, file: StaticString = #file, line: UInt = #line) -> XCUIElement {
        let root: XCUIElement = rootQuery ?? app
        let button = root.buttons[identifier].firstMatch
        if let timeout = timeToWait {
            guard button.waitForExistence(timeout: timeout) else {
                XCTFail("Button with identifier \(identifier) doesn't exist after timeout", file: file, line: line)
                return button
            }
        }
        
        guard button.exists else {
            XCTFail("Button with identifier \(identifier) doesn't exist", file: file, line: line)
            return button
        }
        
        if isEnabled, !button.isEnabled {
            XCTFail("Button with identifier \(identifier) isn't enabled", file: file, line: line)
            return button
        }
        
        if isTappable, !button.isHittable {
            XCTFail("Button with identifier \(identifier) is not tappable", file: file, line: line)
            return button
        }
        
        if let title = buttonTitle {
            guard title == button.label else {
                XCTFail("Button with identifier \(identifier) label \(button.label) does not match expected \(title)", file: file, line: line)
                return button
            }
        }
        
        return button
    }
    
    func checkLink(existsWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval? = nil, from rootQuery: XCUIElement? = nil, andIsTappable isTappable: Bool = true, file: StaticString = #file, line: UInt = #line) {
        let root: XCUIElement = rootQuery ?? app
        let link = root.links[identifier].firstMatch
        if let timeout = timeToWait {
            guard link.waitForExistence(timeout: timeout) else {
                XCTFail("Link with identifier \(identifier) doesn't exist after timeout", file: file, line: line)
                return
            }
        }
        
        guard link.exists else {
            XCTFail("Link with identifier \(identifier) doesn't exist", file: file, line: line)
            return
        }
        
        if isTappable, !link.isHittable {
            XCTFail("Link with identifier \(identifier) is not tappable", file: file, line: line)
            return
        }
    }
    
    func tapButton(withIdentifier identifier: String, waitingFor timeToWait: TimeInterval? = nil, from rootQuery: XCUIElement? = nil, file: StaticString = #file, line: UInt = #line) {
        let root: XCUIElement = rootQuery ?? app
        let button = root.buttons[identifier].firstMatch
        if let timeout = timeToWait {
            guard button.waitForExistence(timeout: timeout) else {
                XCTFail("Button with identifier \(identifier) doesn't exist after timeout", file: file, line: line)
                return
            }
        }
        
        guard button.exists else {
            XCTFail("Button with identifier \(identifier) doesn't exist", file: file, line: line)
            return
        }
        
        guard button.isHittable else {
            XCTFail("Button with identifier \(identifier) is not tappable", file: file, line: line)
            return
        }
        
        button.tap()
    }
    
    func checkText(_ value: String? = nil, existsWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval? = nil, from rootQuery: XCUIElement? = nil, isTextView: Bool = false, isTextField: Bool = false, isOtherElement: Bool = false, file: StaticString = #file, line: UInt = #line) -> XCUIElement {
        let root: XCUIElement = rootQuery ?? app
        
        let text = isTextView ? root.textViews[identifier].firstMatch : isTextField ? root.textFields[identifier].firstMatch : isOtherElement ? root.otherElements[identifier].firstMatch : root.staticTexts[identifier].firstMatch
        if let timeout = timeToWait {
            guard text.waitForExistence(timeout: timeout) else {
                XCTFail("Text with identifier \(identifier) doesn't exist after timeout", file: file, line: line)
                return text
            }
        }
        
        guard text.exists else {
            XCTFail("Text with identifier \(identifier) doesn't exist", file: file, line: line)
            return text
        }
        
        
        if let valueToCheck = value {
            if let textValue = text.value as? String, !textValue.isEmpty {
                XCTAssertEqual(valueToCheck, textValue)
                guard valueToCheck == textValue else {
                    XCTFail("Text with identifier \(identifier) text \(textValue) does not match expected \(valueToCheck)", file: file, line: line)
                    return text
                }
            } else {
                guard valueToCheck == text.label else {
                    XCTFail("Text with identifier \(identifier) text \(text.label) does not match expected \(valueToCheck)", file: file, line: line)
                    return text
                }
            }
        }
        
        return text
    }
    
    func type(text: String, intoTextFieldWithIdentifier identifier: String, waitingFor timeToWait: TimeInterval? = nil, from rootQuery: XCUIElement? = nil, isSecure: Bool = false, isSearchView: Bool = false, file: StaticString = #file, line: UInt = #line) -> XCUIElement {
        let root: XCUIElement = rootQuery ?? app
        let textField = isSecure ? root.secureTextFields[identifier].firstMatch : isSearchView ? root.otherElements[identifier].firstMatch : root.textFields[identifier].firstMatch
        if let timeout = timeToWait {
            guard textField.waitForExistence(timeout: timeout) else {
                XCTFail("Textfield with identifier \(identifier) doesn't exist after timeout", file: file, line: line)
                return textField
            }
        }
        
        guard textField.exists else {
            XCTFail("Textfield with identifier \(identifier) doesn't exist", file: file, line: line)
            return textField
        }
        
        if !textField.isFocused {
            textField.tap()
            wait(1, because: "Element doesn't have focus yet")
        }
        
        // I do it using the clipboard as I had problems in the past with typing
        UIPasteboard.general.string = text
        textField.press(forDuration: 1.1)
        wait(1, because: "Paste menu needs to appear...")
        app.menuItems["Paste"].tap()
        
        return textField
    }
    
    func wait(_ timeToWait: UInt32, because reasonForWaiting: String) {
        sleep(timeToWait)
    }
    
    func swipe(toElement element: XCUIElement, maxScrolls: Int = 10, inDirection direction: SwipeDirection = .up, file: StaticString = #file, line: UInt = #line) {
        for _ in 0 ..< maxScrolls {
            if element.exists, element.isHittable {
                return
            }
            
            switch direction {
            case .up:
                app.swipeUp()
                break
            case .down:
                app.swipeDown()
                break
            case .left:
                app.swipeLeft()
                break
            case .right:
                app.swipeRight()
                break
            }
        }
        
        XCTFail("Unable to swipe to element with identifier \(element.identifier)", file: file, line: line)
    }
}
