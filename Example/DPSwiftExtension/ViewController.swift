//
//  ViewController.swift
//  DPSwiftExtension
//
//  Created by danielpluvia on 11/02/2018.
//  Copyright (c) 2018 danielpluvia. All rights reserved.
//

import UIKit
import DPSwiftExtension

class ViewController: UIViewController {
  
  lazy var redView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  let textField: DPPaddingUITextField = {
    let tf = DPPaddingUITextField(xPadding: 10)
    tf.placeholder = "placeholder"
    return tf
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(redView)
    self.view.addSubview(textField)
    
    self.redView.enableEdgesAnchor(
      top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor,
      topConstant: 100, leadingConstant: 100, bottomConstant: -500, trailingConstant: -100)
    
    self.textField.enableEdgesAnchor(top: self.redView.bottomAnchor, leading: self.redView.leadingAnchor, bottom: nil, trailing: self.redView.trailingAnchor, topConstant: 16, leadingConstant: 0, bottomConstant: 0, trailingConstant: 0)
    self.textField.enableSizeAnchor(width: nil, height: 40)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.view.backgroundColor = UIColor.random
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
