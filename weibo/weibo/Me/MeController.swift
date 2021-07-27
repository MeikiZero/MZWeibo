//
//  MeController.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class MeController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        vistorView.setupVistorInfo(iconName: "visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")

    }

}
