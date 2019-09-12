//
//  PokerView.swift
//  PokerCard
//
//  Created by Weslie Chen on 2019/9/11.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit

/// Abstract Class for a Poker Bulletin View
public class PokerView: UIView {
    
    lazy var topViewController: UIViewController? = {
        guard let rootViewController = currentWindow?.rootViewController else {
            return nil
        }
        
        var topViewController = rootViewController
        while let newTopViewController = topViewController.presentedViewController {
            topViewController = newTopViewController
        }
        return topViewController
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareInterface()
        
//        cancelButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        // swipe up to dismiss
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeUp.direction = .up
        self.addGestureRecognizer(swipeUp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Call this method to dismiss Poker View with animation 
    @objc
    public func dismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.y = -2 * self.frame.height
        }) { (_) in
            // remove present view from super view
            self.superview?.removeFromSuperview()
        }
    }
    
    fileprivate func prepareInterface() {
        layer.cornerRadius = 18
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 15
        
        var resolvedColor = UIColor(white: 0, alpha: 0.3)
        if #available(iOS 13.0, *) {
            let dynamicColor = UIColor { traitCollection -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(white: 0, alpha: 0.7)
                } else {
                    return UIColor(white: 0, alpha: 0.3)
                }
            }
            resolvedColor = dynamicColor.resolvedColor(with: self.traitCollection)
        }
        
        layer.shadowColor = resolvedColor.cgColor
    }
}