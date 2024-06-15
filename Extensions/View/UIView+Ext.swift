//
//  UIView+Ext.swift
//  Sample
//
//  Created by Arvind on 16/06/24.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: Double {
        get { return Double(self.layer.cornerRadius) }
        set { self.layer.cornerRadius = CGFloat(newValue) }
    }
    
    @IBInspectable var borderWidth: Double {
        get { return Double(self.layer.borderWidth) }
        set { self.layer.borderWidth = CGFloat(newValue) }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(cgColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get { return UIColor(cgColor: self.layer.shadowColor!) }
        set { self.layer.shadowColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { return self.layer.shadowOpacity }
        set { self.layer.shadowOpacity = newValue }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set { self.layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowRadius: Double {
        get { return Double(self.layer.shadowRadius) }
        set { self.layer.shadowRadius = CGFloat(newValue) }
    }
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    class func loadFromNib(name:String, index:Int) -> UIView {
        let viewArray:[UIView] = Bundle.main.loadNibNamed(name, owner: nil, options: nil) as! [UIView]
        return viewArray[index]
    }
    
    func shakeLight() {
        let basicAnimation = CABasicAnimation(keyPath: "position")
        basicAnimation.duration = 0.07
        basicAnimation.repeatCount = 4.0
        basicAnimation.autoreverses = true
        basicAnimation.fromValue = CGPoint(x: self.center.x - 5, y: self.center.y)
        basicAnimation.toValue = CGPoint(x: self.center.x + 5, y: self.center.y)
        self.layer.add(basicAnimation, forKey: "position")
    }
    
    func shakeHeavy() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func roundCorner(_ corners: UIRectCorner, _ radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        var masked = CACornerMask()
        if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
        if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
        if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
        if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
        self.layer.maskedCorners = masked
    }
}

extension UIView {
    
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()

        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.lineWidth = 3
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
    @discardableResult
    func setGradientBackground(top: UIColor = .red,
                               bottom: UIColor = .green) -> CAGradientLayer {                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [top.cgColor, bottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.2)
        gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}
