//
//  AlphabetCell.swift
//  Alpha Draw
//
//  Created by Siam on 4/24/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

protocol LetterCellDelegate {
    func drawClicked(letter:String)
}

class AlphabetCell: UICollectionViewCell {

    @IBOutlet var letterName: UILabel!
    
    var letterDelegate:LetterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
