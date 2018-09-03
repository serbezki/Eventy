//
//  Event.swift
//  Eventy
//
//  Created by Juli on 16.08.18.
//

import UIKit
import os.log

class Event: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var mainPhoto: UIImage?
    var date: String
    var address: String
    var isPrivate: Bool
    var photos = [UIImage?]()
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let mainPhoto = "mainPhoto"
        static let date = "date"
        static let address = "address"
        static let isPrivate = "isPrivate"
        static let photos = "photos"
    }
    
    //MARK: Initialization
    init?(name: String, mainPhoto: UIImage?, date: String, address: String, isPrivate: Bool, photos: [UIImage?]){
        // The name must not be empty.
        guard !name.isEmpty else {
            return nil
        }
        
        // The date must not be empty.
        guard !date.isEmpty else{
            return nil
        }
        
        // The address must not be empty.
        guard !address.isEmpty else{
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.mainPhoto = mainPhoto
        self.date = date
        self.address = address
        self.isPrivate = isPrivate
        self.photos = photos
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(mainPhoto, forKey: PropertyKey.mainPhoto)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(address, forKey: PropertyKey.address)
        aCoder.encode(isPrivate, forKey: PropertyKey.isPrivate)
        aCoder.encode(photos, forKey: PropertyKey.photos)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for an event object", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Photos are conditional properties of events, just use conditional cast.
        let mainPhoto = aDecoder.decodeObject(forKey: PropertyKey.mainPhoto) as? UIImage
        let photos = aDecoder.decodeObject(forKey: PropertyKey.photos) as? [UIImage]
        
        // The date is required. If we cannot decode a date string, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else{
            os_log("Unable to decode the date for an event object", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The address is required. If we cannot decode an address string, the initializer should fail.
        guard let address = aDecoder.decodeObject(forKey: PropertyKey.address) as? String else{
            os_log("Unable to decode the address for an event object", log: OSLog.default, type: .debug)
            return nil
        }
        
        // An event should be either private or public. If we cannot decode that information, the initializer should fail.
        guard let isPrivate = aDecoder.decodeObject(forKey: PropertyKey.isPrivate) as? Bool else{
            os_log("Unable to decode whether an event object is public or private", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, mainPhoto: mainPhoto, date: date, address: address, isPrivate: isPrivate, photos: photos!)
    }
}
