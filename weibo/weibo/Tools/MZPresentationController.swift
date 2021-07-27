//
//  MZPresentationController.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class MZPresentationController: UIPresentationController {
    
    var presentedFrame = CGRect.zero
    
    private lazy var coverView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = presentedFrame
        setupCoverView()
    }

}

// MARK: - 设置UI界面相关
extension MZPresentationController {
    private func setupCoverView() {
        containerView?.insertSubview(coverView, at: 0)
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}

// MARK: - 事件监听
extension MZPresentationController {
    @objc private func coverViewClick() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
}
