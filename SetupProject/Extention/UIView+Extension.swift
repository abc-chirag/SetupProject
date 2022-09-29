//
//  UIView+Extension.swift
//  Trichordal
//
//  Created by Sunil Zalavadiya on 16/01/19.
//  Copyright © 2019 Sunil Zalavadiya. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

enum Border {
    case top
    case bottom
    case left
    case right
}

extension UIView {
    
    public func showToastAtBottom(message: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.backgroundColor = .black
        self.makeToast(message, duration: 3.0, position: .bottom, style: style)
    }
    
    public func showToastAtTop(message: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.backgroundColor = .black
        self.makeToast(message, duration: 3.0, position: .top, style: style)
    }
    
    public func showToastAtCenter(message: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.backgroundColor = .black
        self.makeToast(message, duration: 3.0, position: .center, style: style)
    }
    
    public func addCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    public func applyBorder(_ width: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = borderColor.cgColor
    }
    
    public func applyBorderWithRadius(_ width: CGFloat, borderColor: UIColor, _ radius: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radius
    }
    
    public func addBottomCorner(view: UIView, radius: CGFloat){
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    public func addTopCornerRadius(view: UIView, radius: CGFloat){
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    public func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    public func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    public func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }
    
    public func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    public func addShadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    public func applyViewGradient(colors : [UIColor]) {
        let image = UIImage.gradientImageWith(size: CGSize(width: self.bounds.width, height: self.bounds.height), colors: colors)
        self.backgroundColor = UIColor.init(patternImage: image!)
    }
    
    public func addShadowToSpecificCorner(top: Bool, left: Bool, bottom: Bool, right: Bool, shadowRadius: CGFloat = 2.0) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1.0
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if !top {
            y+=(shadowRadius+1)
        }
        if !bottom {
            viewHeight-=(shadowRadius+1)
        }
        if !left {
            x+=(shadowRadius+1)
        }
        if !right {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        
        path.close()
        self.layer.shadowPath = path.cgPath
    }
    
    public func addShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
    }
    
    func addSubViewWithAutolayout(subView: UIView) {
        self.addSubview(subView)
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        subView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        subView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        /*if #available(iOS 11.0, *) {
         let guide = self.safeAreaLayoutGuide
         subView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
         subView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
         subView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
         subView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
         } else {
         subView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
         subView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
         subView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         subView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
         }*/
        
        subView.layoutIfNeeded()
        self.layoutIfNeeded()
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    class func fromNib<T: UIView>() -> T {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! T
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], startPoint: CGPoint, endPoint: CGPoint, cornerRadius: CGFloat, shadowColor: UIColor) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        //        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.cornerRadius = cornerRadius
        //gradient.shadowColor = shadowColor.cgColor
        //gradient.shadowRadius = 4
        //gradient.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func applyGradient(size : CGSize, colors : [UIColor]) -> UIImage? {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient (size.height)
        context.drawLinearGradient(gradient, start: CGPoint(x: size.width, y: 0.0), end: CGPoint(x: 0.0, y: 0.0), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    public func rotateTransform(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(rotationAngle: toValue)
        }, completion: { (finished) in
            
        })
    }
    
    func addDashedBorder(color: UIColor) {
        let color = color.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4, 4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 11).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addDashedBordercircle(color: UIColor) {
        let color = color.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4, 4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: shapeLayer.frame.height / 2.0).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addLinearDashedBorder(color: UIColor) {
        let color = color.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = nil//UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 3]
        shapeLayer.path = cgPath//UIBezierPath(rect: shapeRect).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
}
extension UIView {
    private struct OnClickHolder {
        static var _closure:()->() = {}
    }
    
    private var onClickClosure: () -> () {
        get { return OnClickHolder._closure }
        set { OnClickHolder._closure = newValue }
    }
    
    
    func onTap(target: Any, _ selector: Selector) {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(tap)
    }
    
    func onTap(closure: @escaping ()->()) {
        self.onClickClosure = closure
        
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickAction))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        addGestureRecognizer(tap)
    }
    
    @objc private func onClickAction() {
        onClickClosure()
    }
    
    func setButtionAttributedTitle(_ title: String, font: UIFont, color: UIColor, underline: CGFloat)  -> NSMutableAttributedString {
        let attrs = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : color,
            NSAttributedString.Key.underlineStyle : underline] as [NSAttributedString.Key : Any]
        
        let attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:title, attributes:attrs)
        attributedString.append(buttonTitleStr)
        return attributedString
        //yourButton.setAttributedTitle(setButtionAttributedTitle, for: .normal)
        
    }
}

extension UIViewController {
    func setButtionAttributedTitle(_ title: String, font: UIFont, color: UIColor, underline: CGFloat)  -> NSMutableAttributedString {
        let attrs = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : color,
            NSAttributedString.Key.underlineStyle : underline] as [NSAttributedString.Key : Any]
        
        let attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:title, attributes:attrs)
        attributedString.append(buttonTitleStr)
        return attributedString
    }
    
    func removeButtionAttributedTitle(_ title: String)  -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
        return attributedString
        
    }
    
    
}
