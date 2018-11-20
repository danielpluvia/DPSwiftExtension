//
//  PagingViewController.swift
//  DPSwiftExtension_Example
//
//  Created by Xueqiang Ma on 20/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import DPSwiftExtension

class PagingViewController: DPPagingScrollViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        view1.backgroundColor = .red
        view2.backgroundColor = .yellow
        view3.backgroundColor = .green
        set(pages: [view1, view2, view3])
    }
    
}
