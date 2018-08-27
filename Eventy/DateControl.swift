//
//  DateControl.swift
//  Eventy
//
//  Created by Juli on 16.08.18.
//

import UIKit

@IBDesignable class DateControl: UIStackView {
    
    //MARK: Properties
    private var dateLabel = UILabel()
    var date = "No date set."{
        didSet{
            updateLabel()
        }
    }
    @IBInspectable var labelSize: CGSize = CGSize(width: 240.0, height: 40.0){
        didSet{
            setupLabel()
        }
    }

    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }

    //MARK: Private Methods
    private func setupLabel() {
        // Clear the existing label.
        removeArrangedSubview(dateLabel)
        dateLabel.removeFromSuperview()
        
        // Create new label.
        let label = UILabel()
        
        // Add constraints.
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        label.widthAnchor.constraint(equalToConstant: labelSize.width).isActive = true
        
        // Add the label to the stack.
        addArrangedSubview(label)
        
        // Set this to be the label for this instance.
        dateLabel = label
        
        updateLabel()
    }
    
    private func updateLabel() {
        // Label should always contain the newest date.
        dateLabel.text = date
    }
    
}
