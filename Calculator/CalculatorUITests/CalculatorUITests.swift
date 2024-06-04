//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Kenny on 1/06/24.
//

import XCTest

final class CalculatorUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    func testInitialLoad() throws {
        XCTAssertTrue(app.staticTexts["Cambia tus dólares y soles al instante"].exists)
        XCTAssertTrue(app.staticTexts["Sell"].exists)
        XCTAssertTrue(app.staticTexts["Buy"].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testEnterOriginAmount() throws {
        let originAmountTextField = app.textFields["Ingresa la cantidad"]
        XCTAssertTrue(originAmountTextField.exists)
        
        originAmountTextField.tap()
        originAmountTextField.typeText("100")
        
        app.buttons["swapButton"].tap()
        
        let destinationAmountTextField = app.textFields["Cantidad convertida"]
        XCTAssertTrue(destinationAmountTextField.exists)
        
        
    }
    func testSwapCurrencies() throws {
        
        let swapButton = app.buttons["swapButton"]
        XCTAssertTrue(swapButton.exists)
        
        swapButton.tap()
        
        let sourceCurrencyLabel = app.staticTexts["lblSource"]
        let destinationCurrencyLabel = app.staticTexts["lblDestionation"]
        
        
        XCTAssertNotEqual(sourceCurrencyLabel.label, destinationCurrencyLabel.label)
    }
    
    
}

