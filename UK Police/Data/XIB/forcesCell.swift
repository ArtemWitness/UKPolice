//
//  forcesCell.swift
//  UK Police
//
//  Created by Artem Trembach on 02.02.2020.
//  Copyright © 2020 Artem Trembach. All rights reserved.
//

import UIKit

class forcesCell: UITableViewCell {
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var forceName: UILabel!
    @IBOutlet weak var forceLogo: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
