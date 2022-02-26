//
//  cityTableViewCell.swift
//  weatherPractice
//
//  Created by 郑子炯 on 2022/2/26.
//

import UIKit

class cityTableViewCell: UITableViewCell {

    @IBOutlet weak var citytext: UILabel!
    @IBOutlet weak var checkWeather: UIButton!
    @IBOutlet weak var imge: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
