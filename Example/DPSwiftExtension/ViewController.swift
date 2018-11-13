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
        self.view.addSubview(redView)
        self.redView.fillSuperview(padding: .init(top: 100, left: 100, bottom: 100, right: 100))
//        self.redView.enableEdgesAnchor(
//            top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor,
//            topConstant: 100, leadingConstant: 100, bottomConstant: -500, trailingConstant: -100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let str = "123"
        let result = str.validateRegex(pattern: "[0-9]*")
        print(result)
        addKeyboardObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.random
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


