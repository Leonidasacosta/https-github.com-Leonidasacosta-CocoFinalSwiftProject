//
//  ChildTableViewCell.swift
//  Coco
//
//  Created by Leonidas Acosta on 12/1/21.
//

import UIKit

class ChildTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    var child: Children! {
        didSet {
            nameLabel.text = child.name
            ageLabel.text = "\(child.age)"
        }
    }
}
