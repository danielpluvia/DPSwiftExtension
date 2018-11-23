//
//  PagingViewController.swift
//  DPSwiftExtension_Example
//
//  Created by Xueqiang Ma on 20/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import DPSwiftExtension

extension PagingViewController {
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        super.scrollViewDidEndDecelerating(scrollView)
        pageControl.currentPage = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.x / (scrollView.contentSize.width * 2.0 / 3.0)
        self.pageControl.update(progress: progress)
    }
}

class PagingViewController: DPPagingScrollViewController {
    
    fileprivate let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        return view
    }()
    
    fileprivate let pageControl = DPPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageControl.indicatorWidth = 40
        pageControl.indicatorHeight = 20
        pageControl.layoutIfNeeded()
    }
    
    fileprivate func setupPages() {
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        view1.backgroundColor = .red
        view2.backgroundColor = .yellow
        view3.backgroundColor = .green
        let pages = [view1, view2, view3]
        set(pages: pages)
        pageControl.set(numberOfPages: pages.count)
    }
    
    fileprivate func setupHeaderView() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80)
            ])
        headerView.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
    }
    
    override func setupScrollView() {
        setupHeaderView()
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.enableEdgesAnchor(top: headerView.bottomAnchor,
                                     leading: view.safeAreaLayoutGuide.leadingAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
}
