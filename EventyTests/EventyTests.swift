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
        // Zero rating.
        let zeroRatingEvent = Event.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingEvent)
        
        // Highest positive rating.
        let positiveRatingEvent = Event.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingEvent)
    }
    
    // Confirm that the Event initializer returns nil when passed a negative rating or an empty name.
    func testEventInitializationFails() {
        // Negative rating.
        let negativeRatingEvent = Event.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingEvent)
        
        // Rating exceeds maximum.
        let largeRatingEvent = Event.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingEvent)
        
        // Empty string.
        let emptyStringEvent = Event.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringEvent)
    }
    
}
