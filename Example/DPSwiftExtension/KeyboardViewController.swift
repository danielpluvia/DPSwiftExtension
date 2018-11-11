//
//  KeyboardViewController.swift
//  DPSwiftExtension_Example
//
//  Created by Xueqiang Ma on 11/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import DPSwiftExtension

class KeyboardViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .red
        return sv
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    let customInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupInputView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.delegate = self
        if #available(iOS 11.0, *) {
            scrollView.enableEdgesAnchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
            containerView.enableEdgesAnchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
            NSLayoutConstraint.activate([
                containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
                containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.0)
                ])
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setupInputView() {
        containerView.addSubview(customInputView)
        customInputView.enableEdgesAnchor(top: containerView.topAnchor,
                                          leading: containerView.leadingAnchor,
                                          bottom: containerView.bottomAnchor,
                                          trailing: containerView.trailingAnchor)
        let textField: DPPaddingUITextField = {
            let tf = DPPaddingUITextField(xPadding: 10)
            tf.translatesAutoresizingMaskIntoConstraints = false
            tf.placeholder = "placeholder"
            return tf
        }()
        customInputView.addSubview(textField)
        textField.enableSizeAnchor(width: 200, height: 40)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: customInputView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: customInputView.centerYAnchor, constant: 200)
            ])
        
        let btn = UIButton(type: .system)
        customInputView.addSubview(btn)
        btn.setTitle("Resign", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 80),
            btn.heightAnchor.constraint(equalToConstant: 40),
            btn.centerXAnchor.constraint(equalTo: customInputView.centerXAnchor),
            btn.topAnchor.constraint(equalTo: textField.bottomAnchor)
            ])
        btn.addTarget(self, action: #selector(resignTF), for: .touchUpInside)
    }

}

extension KeyboardViewController {
    override func keyboardWillShow(notification: NSNotification) {
        scrollViewWhileKeyboardShowing(notification: notification, scrollView: scrollView)
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        scrollViewWhileKeyboardHiding(notification: notification, scrollView: scrollView)
    }
    
    @objc func resignTF() -> Void {
        view.endEditing(true)
    }
}
