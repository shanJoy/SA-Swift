//
//  GTNormalTableViewCell.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/13.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

protocol GTNormalTableViewCellDelegate {
    func clickDeleteButton(cell : UITableViewCell, btn : UIButton)
}

class GTNormalTableViewCell: UITableViewCell {
    
    private var titleLabel : UILabel
    private var sourceLabel : UILabel
    private var commentLabel : UILabel
    private var timeLabel : UILabel
    private var rightImageView : UIImageView
    private var deleteButton : UIButton
    public var delegate : GTNormalTableViewCellDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.titleLabel = UILabel.init(frame: UIRect(x: 20, y: 15, width: 300, height: 50))
        self.sourceLabel = UILabel.init(frame: UIRect(x: 20, y: 80, width: 50, height: 20))
        self.commentLabel = UILabel.init(frame: UIRect(x: 100, y: 80, width: 50, height: 20))
        self.timeLabel = UILabel.init(frame: UIRect(x: 150, y: 80, width: 50, height: 20))
        self.rightImageView = UIImageView.init(frame: UIRect(x: 330, y: 15, width: 70, height: 70))
        self.deleteButton = UIButton.init(frame: UIRect(x: 290, y: 80, width: 30, height: 20))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.textColor = UIColor.black;
        self.sourceLabel.font = UIFont.systemFont(ofSize: 12)
        self.sourceLabel.textColor = UIColor.gray
        self.commentLabel.font = UIFont.systemFont(ofSize: 12)
        self.commentLabel.textColor = UIColor.gray
        self.timeLabel.font = UIFont.systemFont(ofSize: 12)
        self.timeLabel.textColor = UIColor.black
        self.rightImageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.deleteButton.setTitle("X", for: .normal)
        self.deleteButton.setTitle("Y", for: .highlighted)
        self.deleteButton.addTarget(self, action: #selector(deleteButtonClick), for: .touchUpInside)
        self.deleteButton.layer.cornerRadius = 10
        self.deleteButton.layer.masksToBounds = true
        self.deleteButton.layer.borderColor = UIColor.lightGray.cgColor
        self.deleteButton.backgroundColor = UIColor.orange
        self.deleteButton.layer.borderWidth = 2
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.sourceLabel)
        self.contentView.addSubview(self.commentLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.rightImageView)
        self.contentView.addSubview(self.deleteButton)
    }
    
    public func layoutTableViewCellWithItem(item : GTListItem) {
        self.timeLabel.textColor = UIColor.black
        self.titleLabel.text = item.title
        self.sourceLabel.text = item.author_name
        self.sourceLabel.sizeToFit()
        self.commentLabel.text = item.category
        self.commentLabel.sizeToFit()
        self.commentLabel.frame = CGRect(x: self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + UI(value: 15), y: self.commentLabel.frame.origin.y, width: self.commentLabel.frame.size.width, height: self.commentLabel.frame.size.height)
        self.timeLabel.text = item.date
        self.timeLabel.sizeToFit()
        self.timeLabel.frame = CGRect(x: self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + UI(value: 15), y: self.timeLabel.frame.origin.y, width: self.timeLabel.frame.size.width, height: self.timeLabel.frame.size.height)
        self.rightImageView.sd_setImage(with: URL.init(string: item.thumbnail_pic_s), completed: nil)
        
    }
    
    @objc func deleteButtonClick() {
        delegate?.clickDeleteButton(cell: self, btn: self.deleteButton)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
