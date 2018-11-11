//
//  DPUIViewControllerExtension.swift
//  DPSwiftExtension
//
//  Created by Xueqiang Ma on 11/11/18.
//

import Foundation

extension UIViewController {
    public func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc open func keyboardWillShow(notification:NSNotification) {
        // scrollViewWhileKeyboardShowing(notification: notification, scrollView: scrollView)
    }
    
    @objc open func keyboardWillHide(notification:NSNotification) {
        // scrollViewWhileKeyboardHiding(notification: notification, scrollView: scrollView)
    }
    
    open func scrollViewWhileKeyboardShowing(notification:NSNotification, scrollView: UIScrollView) {
        //        // Pull a bunch of info out of the notification
        //        if let userInfo = notification.userInfo, let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
        //
        //            // Transform the keyboard's frame into our view's coordinate system
        //            let keyboardFrame: CGRect = endValue.cgRectValue
        //            let endRect = view.convert(keyboardFrame, from: view.window)
        //
        //            // Find out how much the keyboard overlaps the scroll view
        //            // We can do this because our scroll view's frame is already in our view's coordinate system
        //            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
        //
        //            // Set the scroll view's content inset to avoid the keyboard
        //            // Don't forget the scroll indicator too!
        //            scrollView.contentInset.bottom = keyboardOverlap
        //            scrollView.scrollIndicatorInsets.bottom = keyboardOverlap
        //
        //            let duration = durationValue.doubleValue
        //            let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
        //            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
        //                self.view.layoutIfNeeded()
        //            }, completion: nil)
        //        }
        

        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    open func scrollViewWhileKeyboardHiding(notification:NSNotification, scrollView: UIScrollView) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        //        scrollView.scrollIndicatorInsets = contentInset
    }
}
