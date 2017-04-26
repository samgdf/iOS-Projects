//
//  ArticleCell.swift
//  TenFour
//
//  Created by Sam Goldfield on 4/4/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var Title: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
