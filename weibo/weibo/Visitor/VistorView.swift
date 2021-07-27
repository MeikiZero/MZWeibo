//
//  VistorView.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class VistorView: UIView {
    /// 快速创建xib的类方法
    class func vistorView() -> VistorView {
        return Bundle.main.loadNibNamed("VistorView", owner: nil, options: nil)?.first as! VistorView
    }
    
    /// 控件属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    /// 自定义函数
    func setupVistorInfo(iconName: String, title: String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }
    
    func addRotationAnimate() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.repeatCount = MAXFLOAT
        rotationAnimation.duration = 5
        rotationAnimation.isRemovedOnCompletion = false
        rotationView.layer.add(rotationAnimation, forKey: nil)
    }
    
}
