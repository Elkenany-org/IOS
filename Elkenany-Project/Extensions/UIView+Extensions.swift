//
//  UIView+Extensions.swift
//  Banoon
//
//  Created by bishoy on 26/11/2020.
//

import UIKit

extension UIView{
    
    func setGradientBackground(firstColor:UIColor,secondColor:UIColor) {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.colors = [ secondColor.cgColor,firstColor.cgColor]
        self.layer.addSublayer(layer)
    }
    
    func addDashedBorder() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func applyShadowLayer(cornerRadius: CGFloat = 8,shadowOpacity:Float = 0.3){
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = .zero
        layer.shadowRadius = 4.0
    }
    
    func pinEdgesToSuperView(){
        guard let superView = superview else{return}
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
        
}

public class GradientLayer: UIView {
    
    @IBInspectable var startColor: UIColor! = UIColor(red: 103/255, green: 94/255, blue: 243/255, alpha: 1)
    @IBInspectable var endColor: UIColor! = UIColor(red: 57/255, green: 53/255, blue: 136/255, alpha: 1)

    public override class var layerClass : AnyClass {
        return CAGradientLayer.self
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        let colors = [ startColor.cgColor, endColor.cgColor ]
        if let gradient = self.layer as? CAGradientLayer {
            gradient.colors = colors
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        }
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
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
}


extension UIView{
    
    func addSpringAnimation(){
        
        // make the square not visible and scale it to 0.5x
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        // Finally the animation!
        UIView.animate(
            withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
            }, completion: nil)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
              self.alpha = 1
      }, completion: completion)
     }
    
}


extension UIButton{
    func addBounceAnimation(view:UIView){
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.bounds = CGRect(x: view.bounds.origin.x - 20, y: view.bounds.origin.y, width: view.bounds.size.width + 60, height: view.bounds.size.height)
        }) { (success:Bool) in
            if success {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.bounds = view.bounds
                })
                
            }
        }
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
    
}
