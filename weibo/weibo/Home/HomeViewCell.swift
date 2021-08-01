//
//  HomeViewCell.swift
//  weibo
//
//  Created by wangfa on 2021/8/1.
//

import UIKit
import SDWebImage

class HomeViewCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var textView: UILabel!
    
    /// 计算属性 使用didSet属性监听器用来更新cell
    var viewModel: StatusViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            //设置头像
            iconView.sd_setImage(with: viewModel.profileURL as URL?, placeholderImage: UIImage(named: "avatar_default_small"))
            //设置vip
            vipView.image = viewModel.vipImage
            //设置昵称
            nameLabel.text = viewModel.status?.user?.screen_name
            //设置认证头像
            verifiedView.image = viewModel.verifiedImage
            //设置创建时间
            timeLabel.text = viewModel.createAtText
            //设置来源
            sourceLabel.text = viewModel.sourceText
            //设置正文
            textView.text = viewModel.status?.text
            //设置昵称的颜色
            nameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
