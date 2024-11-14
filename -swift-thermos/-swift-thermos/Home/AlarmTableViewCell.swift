//
//  AlarmTableViewCell.swift
//  -swift-thermos
//
//  Created by Jinyoung Leem on 11/14/24.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconImage.image = UIImage(named: "fullBattery")
        setupStatusLabel()
        funcDateLabel()
        // setupMainView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupMainView() {
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
    }
    
    private func setupStatusLabel() {
        statusLabel.text = "배터리 충전 완료"
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.sizeToFit()
    }
    
    private func funcDateLabel() {
        dateLabel.text = "24/10/24 10:30:22"
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .systemGray
        dateLabel.sizeToFit()
    }
    
}
