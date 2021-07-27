//
//  DiscoverController.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class DiscoverController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        vistorView.setupVistorInfo(iconName: "visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }

}
