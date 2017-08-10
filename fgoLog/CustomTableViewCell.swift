//
//  CustomTableViewCell.swift
//  fgoLog
//
//  Created by 斧田洋人 on 2017/08/10.
//  Copyright © 2017年 斧田洋人. All rights reserved.
//

import UIKit

protocol CellDelegate: class {
    func plus(_ cell: CustomTableViewCell)
    func minus(_ cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {

    weak var delegate: CellDelegate?
    @IBOutlet weak var sozaiLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func plusButton(sender: AnyObject){
        delegate?.plus(self)
    }
    
    @IBAction func minusButton(sender: AnyObject){
        delegate?.minus(self)
    }
}
