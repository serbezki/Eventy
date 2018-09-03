//
//  ViewEventViewController.swift
//  Eventy
//
//  Created by Juli on 27.08.18.
//

import UIKit

class ViewEventViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    // This value is passed by `EventTableViewController` in `prepare(for:sender)`.
    var event: Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the views to show the event we're viewing.
        loadEvent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    //owningNavigationController.popViewController(animated: true) for cancel

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ViewPhotos" {
            if let destinationVC = segue.destination as? PhotoTableViewController {
                destinationVC.photos = event.photos
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func viewEventPhotos(_ sender: UIButton) {
        
    }

    //MARK: Private Methods
    private func loadEvent(){
        nameLabel.text = event.name
        mainImageView.image = event.mainPhoto
        dateLabel.text = event.date
        addressLabel.text = event.address
    }

}
