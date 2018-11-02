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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.view.backgroundColor = UIColor.random
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

