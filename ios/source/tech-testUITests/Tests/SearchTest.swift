//
//  SearchTest.swift
//  tech-testUITests
//
//  Created by Matheus Milani on 1/10/21.
//  Copyright © 2021 com.ro8i.techtest. All rights reserved.
//

import XCTest

class SearchTest: XCTestCase, SensyneUITests {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        XCUIDevice.shared.orientation = .portrait
        
        app.launch()
    }
    
    override func tearDown() {
        Springboard.deleteMyApp(title: app.label)
        
        super.tearDown()
    }
    
    func test_main_screen_check_UI() {
        // Wait for the list to contain something what'd indicate the app is ready and loaded fine
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            XCTAssert(app.otherElements[TestData.SEARCH_BAR].exists, "The search bar wasn't present after the app finished loading.")
            
            XCTAssert(app.cells.firstMatch.staticTexts[TestData.HOSPITAL_NAME].exists, "The hospital name wasn't present in the item after the app finished loading.")
            XCTAssert(app.cells.firstMatch.staticTexts[TestData.HOSPITAL_TYPE].exists, "The hospital type wasn't present in the item after the app finished loading.")
            XCTAssert(app.cells.firstMatch.staticTexts[TestData.HOSPITAL_ID].exists, "The hospital ID wasn't present in the item after the app finished loading.")
            XCTAssert(app.cells.firstMatch.staticTexts[TestData.HOSPITAL_PHONE].exists, "The hospital phone wasn't present in the item after the app finished loading.")
            XCTAssert(app.cells.firstMatch.staticTexts[TestData.HOSPITAL_EMAIL].exists, "The hospital email wasn't present in the item after the app finished loading.")
            XCTAssert(app.cells.firstMatch.staticTexts[TestData.HOSPITAL_ADDRESS].exists, "The hospital address wasn't present in the item after the app finished loading.")
            
            let navBarTitle = app.navigationBars[TestData.MAIN_SCREEN_TITLE].staticTexts.firstMatch
            XCTAssert(navBarTitle.exists && navBarTitle.label == TestData.MAIN_SCREEN_TITLE, "The navbar title wasn't present and/or the text didn't match the expected. Expected: \(TestData.MAIN_SCREEN_TITLE), Found: \(navBarTitle.label) ")
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_search_organisation_by_first_name() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            // Type the search string
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let cellsCount = app.cells.count
            XCTAssert(cellsCount == TestData.DEFAULT_SEARCH_COUNT, "The number of results for the search string '\(TestData.DEFAULT_SEARCH_STRING)' wasn't the expected. Expected: \(TestData.DEFAULT_SEARCH_COUNT), Found: \(cellsCount)")
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_can_display_last_element() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            // Total number of cells on the list
            let cellsCount = app.cells.count
            // The element corresponding to the last cell
            let lastCell = app.cells.element(boundBy: cellsCount-1)
            
            // Swipe to the last element
            swipe(toElement: lastCell.staticTexts[TestData.HOSPITAL_ADDRESS], maxScrolls: 10)
            
            // isHittable also checks if the element is visible on the screen
            XCTAssert(lastCell.isEnabled && lastCell.isHittable)
            XCTAssert(lastCell.staticTexts[TestData.HOSPITAL_NAME].isEnabled && lastCell.staticTexts[TestData.HOSPITAL_NAME].isHittable)
            XCTAssert(lastCell.staticTexts[TestData.HOSPITAL_TYPE].isEnabled && lastCell.staticTexts[TestData.HOSPITAL_TYPE].isHittable)
            XCTAssert(lastCell.staticTexts[TestData.HOSPITAL_ID].isEnabled && lastCell.staticTexts[TestData.HOSPITAL_ID].isHittable)
            XCTAssert(lastCell.staticTexts[TestData.HOSPITAL_PHONE].isEnabled && lastCell.staticTexts[TestData.HOSPITAL_PHONE].isHittable)
            XCTAssert(lastCell.staticTexts[TestData.HOSPITAL_EMAIL].isEnabled && lastCell.staticTexts[TestData.HOSPITAL_EMAIL].isHittable)
            XCTAssert(lastCell.staticTexts[TestData.HOSPITAL_ADDRESS].isEnabled && lastCell.staticTexts[TestData.HOSPITAL_ADDRESS].isHittable)
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_can_retain_search_after_opening_details() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            // First check on the search bar to make sure it typed something
            let _ = checkText(TestData.DEFAULT_SEARCH_STRING, existsWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT/2, isOtherElement: true)
            let firstCell = app.cells.firstMatch
            
            // Check the first result
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
            
            // Tap first cell
            firstCell.tap()
            
            // Tap back button
            app.navigationBars[TestData.DETAILS_SCREEN_TITLE].buttons.firstMatch.tap()
            
            // Checking the search bar still has the search string
            let _ = checkText(TestData.DEFAULT_SEARCH_STRING, existsWithIdentifier: TestData.SEARCH_BAR, isOtherElement: true)
            
            // Check if the first result is still there and it's the same
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME)
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_clean_search_on_clear_button_click() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let _ = checkText(TestData.DEFAULT_SEARCH_STRING, existsWithIdentifier: TestData.SEARCH_BAR, isOtherElement: true)

            // Tap the clear button
            app.otherElements[TestData.SEARCH_BAR].tapWithOffset(x: 375.0, y: 22.0)
            
            // Checks if the search bar was cleaned
            let _ = checkText("", existsWithIdentifier: TestData.SEARCH_BAR, isOtherElement: true)
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_results_changes_when_typing() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: "B", intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let firstCell = app.cells.firstMatch
            
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_SEARCH_B, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
            
            // Tap the clear button
            app.otherElements[TestData.SEARCH_BAR].tapWithOffset(x: 375.0, y: 22.0)
            
            let _ = type(text: "BM", intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    
    func test_lower_case_and_uppercase_searches_returns_same_result() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let firstCell = app.cells.firstMatch
            
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
            
            // Tap the clear button
            app.otherElements[TestData.SEARCH_BAR].tapWithOffset(x: 375.0, y: 22.0)
            
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING.lowercased(), intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_detail_screen_check_UI() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let firstCell = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT, from: app.cells.firstMatch)
            firstCell.tap()
            
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2)
            let _ = checkText("ODS Code: \(TestData.FIRST_HOSPITAL_ODS_CODE_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_ODS_CODE)
            let _ = checkText("ID: \(TestData.FIRST_HOSPITAL_ID_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_ID)
            let _ = checkText("Code: \(TestData.FIRST_HOSPITAL_CODE_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_CODE)
            let _ = checkText("Sector: \(TestData.FIRST_HOSPITAL_SECTOR_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_SECTOR)
            let _ = checkText("Type: \(TestData.FIRST_HOSPITAL_TYPE_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_TYPE)
            let _ = checkText("SubType: \(TestData.FIRST_HOSPITAL_SUBTYPE_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_SUBTYPE)
            let _ = checkText("Status: \(TestData.FIRST_HOSPITAL_STATUS_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_STATUS)
            let _ = checkText("PIM: \(TestData.FIRST_HOSPITAL_PIM_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_PIM)
            let _ = checkText("Fax: \(TestData.FIRST_HOSPITAL_FAX_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_FAX)
            let _ = checkText("Address: \(TestData.FIRST_HOSPITAL_ADDRESS_FROM_SEARCH)", existsWithIdentifier: TestData.HOSPITAL_ADDRESS)
            let _ = checkButton(existsWithIdentifier: TestData.HOSPITAL_EMAIL, withButtonTitle: "✉️ \(TestData.FIRST_HOSPITAL_EMAIL_FROM_SEARCH)")
            let _ = checkButton(existsWithIdentifier: TestData.HOSPITAL_PHONE, withButtonTitle: "☎️ \(TestData.FIRST_HOSPITAL_PHONE_FROM_SEARCH)")
            let _ = checkButton(existsWithIdentifier: TestData.HOSPITAL_WEBSITE, withButtonTitle: "🌐 \(TestData.FIRST_HOSPITAL_WEBSITE_FROM_SEARCH)")
            
            XCTAssert(app.otherElements[TestData.HOSPITAL_MAP].exists, "The hospital map wasn't present on the details page.")
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_opening_the_organisation_website() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let firstCell = app.cells.firstMatch
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
            firstCell.tap()
            
            // Instantiate Safari as an application
            let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
            
            let _ = tapButton(withIdentifier: TestData.HOSPITAL_WEBSITE, waitingFor: TestData.DEFAULT_TIMEOUT/2)
            
            // Waits for Safari to open
            let _ = safari.wait(for: .runningForeground, timeout: TestData.DEFAULT_TIMEOUT)
            // Makes it active so we can perform actions with it
            safari.activate()
            
            // Tap the URL bar so it shows the full URL
            let _ = tapButton(withIdentifier: "URL", from: safari)
            
            // Checks the URL matches
            let _ = checkText(TestData.FIRST_HOSPITAL_WEBSITE_FROM_SEARCH, existsWithIdentifier: "URL", waitingFor: TestData.DEFAULT_TIMEOUT, from: safari, isTextField: true)
            
            app.activate()
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_calling_the_organisation_number() throws {
        guard UIApplication.shared.canOpenURL(URL(string: "tel://0123456789")!) else {
            throw XCTSkip("The device doesn't have the telephone app installed.")
        }
        
            
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let firstCell = app.cells.firstMatch
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
            firstCell.tap()
            
            // Instantiate the iOS UI as an app
            let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
            
            // Tap the phone number
            let _ = tapButton(withIdentifier: TestData.HOSPITAL_PHONE, waitingFor: TestData.DEFAULT_TIMEOUT/2)
            
            // Validates if the number that appeared in the option matches
            let _ = checkText(existsWithIdentifier: "Call \(TestData.FIRST_HOSPITAL_PHONE_FROM_SEARCH)", waitingFor: TestData.DEFAULT_TIMEOUT/2, from: springboard)
            
            // Beyond this point is on Apples hands so it's pointless to test, just cancel the operation
            let _ = tapButton(withIdentifier: "Cancel", from: springboard)
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_emailing_the_organisation() throws {
        guard UIApplication.shared.canOpenURL(URL(string: "mailTo://email@email.com")!) else {
            throw XCTSkip("The device doesn't have the mail app installed.")
        }
        
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let firstCell = app.cells.firstMatch
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
            firstCell.tap()
            
            let _ = tapButton(withIdentifier: TestData.HOSPITAL_EMAIL, waitingFor: TestData.DEFAULT_TIMEOUT/2)
            
            // Confirms that we want to send the email on the alert
            let _ = tapButton(withIdentifier: "Yes", from: app.alerts.firstMatch)
            
            // Byond here is on Apple's control again so pointless to test further, just cancel the operation
            let _ = tapButton(withIdentifier: "Mail.cancelSendButton", waitingFor: TestData.DEFAULT_TIMEOUT/2)
            
            let _ = tapButton(withIdentifier: "Delete Draft")
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
    
    func test_opening_the_organisation_map() {
        if app.cells.firstMatch.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT) {
            let _ = type(text: TestData.DEFAULT_SEARCH_STRING, intoTextFieldWithIdentifier: TestData.SEARCH_BAR, waitingFor: TestData.DEFAULT_TIMEOUT, isSearchView: true)
            
            let firstCell = app.cells.firstMatch
            let _ = checkText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH, existsWithIdentifier: TestData.HOSPITAL_NAME, waitingFor: TestData.DEFAULT_TIMEOUT/2, from: firstCell)
            firstCell.tap()
            
            let map = app.otherElements[TestData.HOSPITAL_MAP]
                
            if map.waitForExistence(timeout: TestData.DEFAULT_TIMEOUT/2) {
                // Taps in the middle of the screen as the location pinpoint is centralized on the map
                map.tapWithOffset(x: 197.0, y: 125.0)
                
                // Instantiate Maps as an app
                let maps = XCUIApplication(bundleIdentifier: "com.apple.Maps")
                
                // Waits for it to open
                let _ = maps.wait(for: .runningForeground, timeout: TestData.DEFAULT_TIMEOUT)
                
                // Goes back to our app
                app.activate()
            } else {
                XCTFail("The hospital map wasn't present on the details page after \(TestData.DEFAULT_TIMEOUT) seconds.")
            }
        } else {
            XCTFail("No item was loaded in the list after \(TestData.DEFAULT_TIMEOUT) seconds.")
        }
    }
}
