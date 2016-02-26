//
//  testSalesUITests.swift
//  testSalesUITests
//
//  Created by MCS on 11/16/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import XCTest

class testSalesUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testAddCupon()
    {
        let app = XCUIApplication()
        app.navigationBars["testSales.AccountView"].buttons["menu"].tap()
        app.tables.staticTexts["Shopping List"].tap()
        app.toolbars.buttons["Cupon"].tap()
        app.alerts["Cupon"].textFields[""].tap()
        app.alerts["Cupon"].textFields[""].typeText("1000")
        app.alerts["Cupon"].collectionViews.buttons["Cancel"].tap()
    }
    
    func testAddProduct()
    {
        
        let app = XCUIApplication()
        app.navigationBars["testSales.AccountView"].buttons["menu"].tap()
        app.tables.staticTexts["Shopping List"].tap()
        app.navigationBars["Shopping List"].buttons["Add"].tap()
        
        let textField = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.TextField).element
        textField.tap()
        textField.typeText("100")
        
        let scanButton = app.buttons["Scan"]
        scanButton.tap()
        app.buttons["Close"].tap()
        print("")
        
    }
}
