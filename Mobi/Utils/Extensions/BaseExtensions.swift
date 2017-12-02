//
//  BaseExtensions.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/27/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import Toast_Swift
//MARK:- UIWindow

public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
    
    public func setRootViewController(_ viewController: UIViewController, fromWindow window: UIWindow, withTransition transition: UIViewAnimationOptions, completionHandler completion: ((_ finished: Bool) -> Void)?){
        UIView.transition(with: window, duration: 0.5, options: transition, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: completion)
    }
}

//MARK:- UIColor

extension UIColor {
    
    static func colorWithHexString (_ hex:String) -> UIColor {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}

//MARK:- UIViewController

extension UIViewController {
    
    func appDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    public var rootViewController: UIViewController? {
        return self.appDelegate()?.window?.rootViewController
    }
    
    var firstPresentingViewController : UIViewController {
        get {
            
            var presentingController: UIViewController? = self
            while (presentingController?.presentingViewController != nil){
                presentingController = presentingController?.presentingViewController
            }
            
            return presentingController!
        }
    }
    
    // Convert TimeInterval to String
    func stringFromTimeInterval(_ interval:TimeInterval) -> String {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
    func millisecondsToTime(_ milliseconds: String) -> String {
        
        let date = Date(timeIntervalSince1970: Double(milliseconds)! / 1000)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "HH : mm"
        return formatter.string(from: date)
    }
    
    func secondsToTime(_ seconds: Double) -> String{
        let date = Date(timeIntervalSince1970: seconds)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "HH : mm"
        return formatter.string(from: date)
        
    }
    
    func createGradientWithColor(_ inView: UIView, _ gradient: CAGradientLayer, colorHex: String) {
        gradient.frame = inView.bounds
        gradient.colors = [UIColor.colorWithHexString(colorHex).cgColor, UIColor.black.cgColor]
        inView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func showAlertWithTitle(_ title: String = "Error", message mess: String,
                            okButton ok: String? = nil, okHandler: ((UIAlertAction) -> Void)? = nil,
                            closeButton close: String? = nil, closeHandler: ((UIAlertAction) -> Void)? = nil,
                            otherButton other: String? = nil, otherHandler: ((UIAlertAction) -> Void)? = nil,
                            completionHanlder completion: (()-> Void)? = nil) -> Void {
        let alertVC = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        
        if let ok = ok{
            let okAction = UIAlertAction(title: ok, style: .default, handler: okHandler)
            alertVC.addAction(okAction)
        }
        
        if let close = close{
            let closeAction = UIAlertAction(title: close, style: .default, handler: closeHandler)
            alertVC.addAction(closeAction)
        }
        
        if let other = other {
            let otherAction = UIAlertAction(title: other, style: .cancel, handler: otherHandler)
            alertVC.addAction(otherAction)
        }
        
        if close == nil && ok == nil && other == nil {
            let defaultAction = UIAlertAction(title: "Close", style: .cancel, handler: closeHandler)
            alertVC.addAction(defaultAction)
        }
        
        self.present(alertVC, animated: true, completion: completion)
    }
    
    func showToast(message: String, backgroundColor bgColor: UIColor, messageColor msColor: UIColor) {
        var style = ToastStyle()
        style.backgroundColor = bgColor
        style.messageColor = msColor
        UIApplication.shared.delegate?.window??.makeToast(message, duration: 2.0, position: .bottom, style: style)
    }
    
    func showToastSuccess(message: String) {
        self.view.endEditing(true)
        self.showToast(message: message, backgroundColor: UIColor.lightGray, messageColor: UIColor.white)
    }
    
    func showToastFailure(message: String) {
        self.view.endEditing(true)
        self.showToast(message: message, backgroundColor: UIColor.lightGray, messageColor: UIColor.red)
    }
}

//MARK:- UIView

extension UIView {
    
    func makeCornerAndShadowAndBorder(_ cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOpacity: Float, borderWidth: CGFloat) {
        self.layer.masksToBounds = false;
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.cornerRadius = cornerRadius
        
        self.layer.borderWidth   = borderWidth
        self.layer.borderColor   = UIColor.lightGray.cgColor
    }
    
    func makeCornerAndShadow(_ cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOpacity: Float) {
        self.layer.masksToBounds = false;
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.cornerRadius = cornerRadius
    }
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    // Convert image to String in UIView
    
    func imageToBase64String(_ image: UIImage) -> String{
        let imageData:Data = UIImagePNGRepresentation(image)!
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    func base64StringToImage(_ strBase64: String) -> UIImage? {
        if let dataDecoded = Data(base64Encoded: strBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters) {
            return UIImage(data: dataDecoded)!
        } else {
            return nil
        }
    }
    
    func base64StringToString(_ strBase64: String) -> String {
        let dataDecoded:Data = Data(base64Encoded: strBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        return NSString(data: dataDecoded, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    func stringFromTimeInterval(_ interval:TimeInterval) -> String {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
}

extension UIButton {
    func defaultButton(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        
        self.clipsToBounds = true
    }
}
