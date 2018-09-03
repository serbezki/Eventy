//
//  EventTableViewController.swift
//  Eventy
//
//  Created by Juli on 16.08.18.
//

import UIKit
import os.log

class EventTableViewController: UITableViewController {
    
    //MARK: Properties
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved events, otherwise load sample data.
        if let savedEvents = loadEvents(){
            events += savedEvents
        }
        else{
            // Load the sample data.
            loadSampleEvents()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else{
            fatalError("The dequeued cell is not an instance of EventTableViewCell")
        }
        
        // Fetches the appropriate event for the data source layout.
        let event = events[indexPath.row]

        cell.nameLabel.text = event.name
        cell.photoImageView.image = event.mainPhoto
        cell.dateLabel.text = event.date
        cell.addressLabel.text = event.address

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            events.remove(at: indexPath.row)
            saveEvents()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? ""){
        case "AddEvent":
            os_log("Adding a new event.", log: OSLog.default, type: .debug)
        case "ViewEvent":
            guard let eventDetailViewController = segue.destination as? ViewEventViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedEventCell = sender as? EventTableViewCell else{
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedEventCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedEvent = events[indexPath.row]
            eventDetailViewController.event = selectedEvent
        default:
            fatalError("Unexpected segue identifier: \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToEventList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddEventViewController, let event = sourceViewController.event {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // Update an existing event.
                events[selectedIndexPath.row] = event
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                // Add a new event.
                let newIndexPath = IndexPath(row: events.count, section: 0)
                
                events.append(event)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the events.
            saveEvents()
        }
    }
    
    //MARK: Private Methods
    private func loadSampleEvents(){
        let mainPhoto1 = UIImage(named: "event1")
        let mainPhoto2 = UIImage(named: "event2")
        let mainPhoto3 = UIImage(named: "event3")
        let photos = [UIImage?]()
        
        guard let event1 = Event(name: "Ed Sheeran Concert", mainPhoto: mainPhoto1, date: "15th of June, 2019", address: "Royal Albert Hall, London, UK", isPrivate: false, photos: photos) else {
            fatalError("Unable to instantiate event1")
        }
        
        guard let event2 = Event(name: "New Year's Eve Party", mainPhoto: mainPhoto2, date: "31st of December, 2018", address: "PM Club, Sofia, Bulgaria", isPrivate: false, photos: photos) else {
            fatalError("Unable to instantiate event2")
        }
        
        guard let event3 = Event(name: "Stand-up Comedy Night", mainPhoto: mainPhoto3, date: "31st of August, 2018", address: "Morgan's bar, Sofia, Bulgaria", isPrivate: false, photos: photos) else {
            fatalError("Unable to instantiate event3")
        }
        
        events += [event1, event2, event3]
    }

    private func saveEvents(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path)
        
        if isSuccessfulSave{
            os_log("Events successfully saved", log: OSLog.default, type: .debug)
        }
        else{
            os_log("Failed to save events", log: OSLog.default, type: .error)
        }
    }
    
    private func loadEvents() -> [Event]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event]
    }
    
}
