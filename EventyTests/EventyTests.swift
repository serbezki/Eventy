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
        let emptyPhotos = [UIImage]()
        // All valid arguments.
        let validEvent = Event.init(name: "Valid", mainPhoto: nil, date: "1st of March, 2000", address: "Address", isPrivate: false, photos: emptyPhotos)
        XCTAssertNotNil(validEvent)
    }
    
    // Confirm that the Event initializer returns nil when passed an empty name or an empty date.
    func testEventInitializationFails() {
        let emptyPhotos = [UIImage]()
        // No date.
        let noDateEvent = Event.init(name: "NoDate", mainPhoto: nil, date: "", address: "Address", isPrivate: false, photos: emptyPhotos)
        XCTAssertNil(noDateEvent)
        
        // No name.
        let noNameEvent = Event.init(name: "", mainPhoto: nil, date: "22nd of July, 1995", address: "Address", isPrivate: false, photos: emptyPhotos)
        XCTAssertNil(noNameEvent)
    }
    
}
