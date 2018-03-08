//
//  UIViewExtension.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func setCornorRadius(radius : CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setBorder(width: CGFloat ,color: UIColor){
        self.clipsToBounds      = true
        self.layer.borderWidth  = width
        self.layer.borderColor  = color.cgColor
    }
    
    func setShadow(radius: CGFloat, color: UIColor, offSet: CGSize, opacity: Float) {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
    }
    
    
    func setVisibleAnimate(visible: Bool, delay: Double) {
        
        let startAlphaValue : CGFloat   = visible ? 0.0 : 1.0
        let endAlphaValue : CGFloat     = visible ? 1.0 : 0.0
        
        // transition view
       
        self.alpha = startAlphaValue
            UIView.animate(withDuration: delay, delay: 0, options: .transitionCrossDissolve, animations: {
                self.alpha = endAlphaValue
                }, completion:nil)
            return
   
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func stopRotate() {
        self.layer.removeAllAnimations()
    }
    
 
    
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


