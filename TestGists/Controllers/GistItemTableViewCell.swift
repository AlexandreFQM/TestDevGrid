//
//  GistItemTableViewCell.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import UIKit
import Kingfisher

class GistItemTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var fileLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
        
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

    func configureCell(item: GistsModelResponse) {
                
        self.titleLabel.text = "\(item.owner.login) / \(item.getFirstFileName())"
        self.descriptionLabel.text = item.description
        
        if let itemDescription = item.description {
            self.descriptionLabel.isHidden = itemDescription.isEmpty
            self.descriptionLabel.text = itemDescription
        }
                
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:item.createdAt)!
                
        dateFormatter.dateFormat = "yy/MM/dd HH:mm:ss"
        let dateCustom = dateFormatter.string(from: date)

        self.createdAtLabel.text = dateCustom
        
        commentsLabel.text = "\(item.comments) comments"
        
        self.iconImageView.image = nil
        iconImageView.kf.setImage(with: URL(string: item.owner.avatarURL)!)
        iconImageView.layer.masksToBounds = false
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
        iconImageView.clipsToBounds = true
        
        lineView.alpha = 0.1
        
    }
}
