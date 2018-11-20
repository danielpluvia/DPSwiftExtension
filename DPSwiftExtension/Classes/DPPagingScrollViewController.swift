//
//  DPPagingScrollViewController.swift
//  DPSwiftExtension
//
//  Created by Xueqiang Ma on 9/11/18.
//

import UIKit

extension DPPagingScrollViewController: UIScrollViewDelegate {
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = scrollView.frame.width
        currentPage = floor((scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1
        view.endEditing(true)
    }
}

open class DPPagingScrollViewController: UIViewController {
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            let newOffset = CGPoint(x: self.currentPage * self.scrollView.frame.width, y: 0)
            self.scrollView.setContentOffset(newOffset, animated: false)
        }, completion: nil)
    }
    
    open func scrollTo(pageIndex: Int) {
        var index = pageIndex
        index = max(index, 0)
        index = min(pages.count - 1, index)
        currentPage = CGFloat(index)
        let newOffset = CGPoint(x: currentPage * scrollView.frame.width, y: 0)
        scrollView.setContentOffset(newOffset, animated: true)
        view.endEditing(true)
    }
    
    open func scrollForward() {
        let index = Int(currentPage) + 1
        scrollTo(pageIndex: index)
    }
    
    open func scrollBackward() {
        let index = Int(currentPage) - 1
        scrollTo(pageIndex: index)
    }
    
    public func set(pages: [UIView]) {
        self.containerView.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        self.pages = pages
        setupPages()
    }
    public fileprivate(set) var currentPage: CGFloat = 0
    
    lazy public var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isPagingEnabled = true
        return sv
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContainerView()
        setupPages()
    }
    
    fileprivate let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    fileprivate var pages = [UIView]()
    
    // MARK: Setup Scroll View
    
    @objc open func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        if #available(iOS 11.0, *) {
            scrollView.enableEdgesAnchor(top: view.safeAreaLayoutGuide.topAnchor,
                                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                         trailing: view.safeAreaLayoutGuide.trailingAnchor)
        } else if #available(iOS 9.0, *) {
            scrollView.enableEdgesAnchor(top: view.topAnchor,
                                         leading: view.leadingAnchor,
                                         bottom: view.bottomAnchor,
                                         trailing: view.trailingAnchor)
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func setupContainerView() {
        scrollView.addSubview(containerView)
        if #available(iOS 9.0, *) {
            containerView.enableEdgesAnchor(top: scrollView.topAnchor,
                                            leading: scrollView.leadingAnchor,
                                            bottom: scrollView.bottomAnchor,
                                            trailing: scrollView.trailingAnchor) // These are special ScrollView constraints and they have no effect on your content size or position.
            NSLayoutConstraint.activate([
                containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                ])
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: Setup Pages
    
    /// Add self.pages to container and add constraints to them.
    fileprivate func setupPages() {
        pages.forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(view)
        }
        if #available(iOS 9.0, *) {
            for i in 0..<pages.count {
                let pageView = pages[i]
                switch i {
                case 0: // first page
                    NSLayoutConstraint.activate([
                        pageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                        pageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                        pageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                        ])
                case pages.count - 1:   // last page
                    NSLayoutConstraint.activate([
                        pageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                        pageView.leadingAnchor.constraint(equalTo: pages[i - 1].trailingAnchor),
                        pageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        pageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                        pageView.widthAnchor.constraint(equalTo: pages[i - 1].widthAnchor)
                        ])
                default:
                    NSLayoutConstraint.activate([
                        pageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                        pageView.leadingAnchor.constraint(equalTo: pages[i - 1].trailingAnchor),
                        pageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        pageView.widthAnchor.constraint(equalTo: pages[i - 1].widthAnchor)
                        ])
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
