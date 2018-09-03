//
//  AddEventViewController.swift
//  Eventy
//
//  Created by Juli on 16.08.18.
//

import UIKit
import os.log

class AddEventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var privateSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    // This is the object that gets constructed to make the new event.
    var event: Event?
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view to be scrollable.
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.view.frame.size.height + 100)
        
        // Handle the text fields' user input through delegate callbacks.
        nameTextField.delegate = self
        addressTextField.delegate = self
        
        // Handle the date picker's input through datePickerChanged method.
        datePicker.addTarget(self, action: #selector(AddEventViewController.datePickerChanged(_:)), for: .valueChanged)
        
        // Enable the Save button only if the text fields have valid input.
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        if textField === nameTextField{
            navigationItem.title = textField.text
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user cancelled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Dismiss the view controller.
        dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let mainPhoto = photoImageView.image
        let address = addressTextField.text ?? ""
        let isPrivate = privateSwitch.isOn
        let photos = [UIImage]()
        
        // Set the event to be passed to EventTableViewController after the unwind segue.
        event = Event(name: name, mainPhoto: mainPhoto, date: date, address: address, isPrivate: isPrivate, photos: photos)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        
        // Parse input from date picker and set date to it.
        let newDate = dateFormatter.string(from: datePicker.date)
        date = newDate
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text fields are empty.
        let nameText = nameTextField.text ?? ""
        let addressText = addressTextField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !addressText.isEmpty
        if !nameText.isEmpty{
            os_log("Name is fine.", log: OSLog.default, type: .debug)
        }
        if !addressText.isEmpty{
            os_log("Address is fine.", log: OSLog.default, type: .debug)
        }
    }
    
}

