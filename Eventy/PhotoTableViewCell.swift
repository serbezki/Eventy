//
//  PhotoTableViewCell.swift
//  Eventy
//
//  Created by Juli on 2.09.18.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
