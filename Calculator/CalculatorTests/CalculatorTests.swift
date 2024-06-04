//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Kenny on 1/06/24.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    
    var presenter: ExchangeRatePresenter!
    var interactor: MockExchangeRateInteractor!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //Given
        presenter = ExchangeRatePresenter()
        interactor = MockExchangeRateInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadExchangeRates() {
        // When
        presenter.loadExchangeRates()
        // Assert
        XCTAssertEqual(interactor.getRatesCallCount, 2)
    }
    
    func testSwapCurrencies() {
        // Given
        presenter.sourceCurrency = "USD"
        presenter.destinationCurrency = "PEN"
        // When
        presenter.swapCurrencies()
        // Assert
        XCTAssertEqual(presenter.sourceCurrency, "PEN")
        XCTAssertEqual(presenter.destinationCurrency, "USD")
    }
    
    func testCalculateDestinationAmount() {
        // Given
        presenter.originAmount = "100"
        presenter.sourceCurrency = "USD"
        presenter.penAmount = 5.5
        // When
        presenter.calculateDestinationAmount()
        // Assert
        XCTAssertNotNil(presenter.destinationAmount)
    }
    
    
    
    func testDidFailToGetRates() {
        // When
        presenter.didFailToGetRates(NSError(domain: "", code: 0, userInfo: nil))
        // Assert
        XCTAssertTrue(presenter.showAlert)
    }
    
    func testShowAlertOnServiceSuccess() {
        XCTAssertFalse(presenter.showAlert)
    }
    
}
