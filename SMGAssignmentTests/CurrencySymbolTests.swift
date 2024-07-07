//
//  RealestateListViewObservedTests.swift
//  SMGAssignmentTests
//
//  Created by Lữ on 7/7/24.
//

import XCTest
@testable import SMGAssignment

final class CurrencySymbolTests: XCTestCase {
    override func setUpWithError() throws { }
    
    /// - When the load method is instantiated
    /// - Then the Observed default state is idle
    /// Test data rereived from: https://www.newbridgefx.com/currency-codes-symbols/
    func testCurrencySymbols() {
        XCTAssertEqual("VND".currencySymbol, "₫")
        XCTAssertEqual("CHF".currencySymbol, "CHF")
        
        XCTAssertEqual("GBP".currencySymbol, "£")
        
        XCTAssertEqual("XCD".currencySymbol, "$")
        XCTAssertEqual("USD".currencySymbol, "$")
        XCTAssertEqual("UYU".currencySymbol, "$")
        
        XCTAssertEqual("EUR".currencySymbol, "€")
        
        XCTAssertEqual("EGP".currencySymbol, "ج.م.‏")
        XCTAssertEqual("AFN".currencySymbol, "؋")
        XCTAssertEqual("DZD".currencySymbol, "DA")
        XCTAssertEqual("GHS".currencySymbol, "GH₵")
    }
    
}
