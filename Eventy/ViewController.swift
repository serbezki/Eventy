//
//  ViewController.swift
//  Eventy
//
//  Created by Juli on 14.08.18.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var userProfilePhoto: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var secondaryPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: Actions
    @IBAction func seePhotos(_ sender: UIButton) {
    }
    
    
}

