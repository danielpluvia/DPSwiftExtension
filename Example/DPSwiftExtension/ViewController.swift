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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.addSubview(redView)
    self.redView.enableEdgesAnchor(
      top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor,
      topConstant: 100, leadingConstant: 100, bottomConstant: -100, trailingConstant: -100)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.view.backgroundColor = UIColor.random
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

