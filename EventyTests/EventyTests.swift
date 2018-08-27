//
//  EventyTests.swift
//  EventyTests
//
//  Created by Juli on 16.08.18.
//

import XCTest
@testable import Eventy

class EventyTests: XCTestCase {
    
    //MARK: Event class tests
    
    // Confirm that the Event initializer returns an Event object when passed valid parameters.
    func testEventInitializationSucceeds() {
        // All valid arguments.
        let validEvent = Event.init(name: "Valid", photo: nil, date: "1st of March, 2000")
        XCTAssertNotNil(validEvent)
    }
    
    // Confirm that the Event initializer returns nil when passed an empty name or an empty date.
    func testEventInitializationFails() {
        // No date.
        let noDateEvent = Event.init(name: "NoDate", photo: nil, date: "")
        XCTAssertNil(noDateEvent)
        
        // No name.
        let noNameEvent = Event.init(name: "", photo: nil, date: "22nd of July, 1995")
        XCTAssertNil(noNameEvent)
    }
    
}
