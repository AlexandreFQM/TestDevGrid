//
//  GistCommentTableViewCell.swift
//  TestGists
//
//  Created by Alexandre Furquim on 08/04/21.
//

import Foundation
import UIKit

class GistCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!            
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        separatorInset.left = titleLabel.convert(titleLabel.bounds.origin, to: self).x
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(item: GistsCommentModelResponse) {
                
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:item.createdAt)!
                
        dateFormatter.dateFormat = "yy/MM/dd HH:mm:ss"
        let dateCustom = dateFormatter.string(from: date)
        
        self.titleLabel.text = "\(item.user.login) / commented \(dateCustom)"
        self.descriptionLabel.text = item.body
                                
        self.iconImageView.image = nil
        iconImageView.kf.setImage(with: URL(string: item.user.avatarURL)!)
        iconImageView.layer.masksToBounds = false
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
        iconImageView.clipsToBounds = true
        
        lineView.alpha = 0.1
        
    }
        
}
