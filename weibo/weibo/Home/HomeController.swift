//
//  HomeController.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class HomeController: BaseViewController {
    
    private lazy var titleBtn = TitleButton()
    
    private lazy var popoverAnimator = PopoverAnimator { presented in
        self.titleBtn.isSelected = presented
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vistorView.addRotationAnimate()
        if !isLogin {
            return
        }
        setNavigationBar()
        
    }

}

// MARK: - 设置UI界面
extension HomeController {
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("MZ", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
    
}

// MARK: - 事件监听
extension HomeController {
    @objc private func titleBtnClick() {
        let popoverVc = PopoverViewController()
        popoverVc.modalPresentationStyle = .custom
        popoverVc.transitioningDelegate = popoverAnimator
        popoverAnimator.presentFrame = CGRect(x: 100, y: 100, width: 180, height: 250)
        present(popoverVc, animated: true, completion: nil)
       
    }
}
