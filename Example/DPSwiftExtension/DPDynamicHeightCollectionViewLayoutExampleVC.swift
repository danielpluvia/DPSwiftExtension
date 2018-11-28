//
//  DPDynamicHeightCollectionViewLayoutExampleVC.swift
//  DPSwiftExtension_Example
//
//  Created by Xueqiang Ma on 26/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import DPSwiftExtension

class DPDynamicHeightCollectionViewLayoutExampleVC: UIViewController {
    
    fileprivate let cellId = "cellId"
    fileprivate let padding: CGFloat = 10
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = DPDynamicHeightCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        //        collectionView.backgroundColor = UIColor(red: 245, green: 246, blue: 249, alpha: 100)
        collectionView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.98, alpha: 1.0)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
}

extension DPDynamicHeightCollectionViewLayoutExampleVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}

extension DPDynamicHeightCollectionViewLayoutExampleVC: UICollectionViewDelegate {
    
}

