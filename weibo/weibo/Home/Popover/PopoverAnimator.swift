//
//  PopoverAnimator.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class PopoverAnimator: NSObject {
    var isPresented = false
    var presentFrame = CGRect.zero
    var callBack: (Bool) -> ()
    
    
    
    /// 自定义构造函数
    init(callBack: @escaping (Bool) -> ()) {
        self.callBack = callBack
    }
    

}

// MARK: - 自定义转场
extension PopoverAnimator: UIViewControllerTransitioningDelegate {
    /// 改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = MZPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentFrame
        return presentation
    }
    
    /// 自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack(isPresented)
        return self
    }
    
    /// 自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack(isPresented)
        return self
    }
}

// MARK: - 弹出和消失动画
extension PopoverAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresented(transitionContext: transitionContext) : animationForDismissed(transitionContext: transitionContext)
    }
    
    // 获取弹出的View
    private func animationForPresented(transitionContext: UIViewControllerContextTransitioning) {
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        transitionContext.containerView.addSubview(presentView)
        presentView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        presentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            presentView.transform = CGAffineTransform.identity
        } completion: { completed in
            transitionContext.completeTransition(completed)
        }

    }
    
    // 获取消失的View
    private func animationForDismissed(transitionContext: UIViewControllerContextTransitioning) {
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        } completion: { completed in
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(completed)
        }

        
    }

}

