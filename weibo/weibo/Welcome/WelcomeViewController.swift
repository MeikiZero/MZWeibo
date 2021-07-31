//
//  WelcomeViewController.swift
//  weibo
//
//  Created by wangfa on 2021/7/31.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    var iconURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headImageURLString = UserAccountViewModel.shareInstance.account?.avatar_large
        let url = URL(string: headImageURLString ?? "")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 300.0
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: []) {
            self.view.layoutIfNeeded()
        } completion: { isCompletion in
            if isCompletion == true {
                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            }
        }



    }


}
