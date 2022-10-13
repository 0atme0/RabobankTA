//
//  RabobankTAUITests.swift
//  RabobankTAUITests
//
//  Created by atme on 10/10/2022.
//

import XCTest

final class RabobankTAUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testFileSelectionView() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssert(app.staticTexts["RABOBANK TECH ASSIGNMENT"].exists)
        XCTAssert(app.staticTexts["Choose a CSV file to open"].exists)
    }
    func testFilesList() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssert(app.scrollViews.otherElements.containing(.staticText, identifier:"1.csv").element.exists)
    }
    
    func testFileOpening() {
        let app = XCUIApplication()
        app.launch()
        app.scrollViews.otherElements.containing(.staticText, identifier:"1.csv").element.tap()
        
        XCTAssert(app.staticTexts["Ford"].exists)
    }
    
    func testNavigation() {
        let app = XCUIApplication()
        app.launch()
        app.scrollViews.otherElements.containing(.staticText, identifier:"1.csv").element.tap()
        app.navigationBars/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".otherElements[\"Done\"].buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.scrollViews.otherElements.containing(.staticText, identifier:"1.csv").element.exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
