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
    var photo: UIImage?
    var date: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let date = "date"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, date: String){
        // The name must not be empty.
        guard !name.isEmpty else {
            return nil
        }
        
        // The date must not be empty.
        guard !date.isEmpty else{
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.date = date
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for an event object", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Photos are conditional properties of events, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        
        // The date is required. If we cannot decode a date string, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else{
            os_log("Unable to decode the date for an event object", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, date: date)
    }
}
