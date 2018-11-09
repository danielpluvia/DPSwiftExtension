//
//  DPPagingScrollViewController.swift
//  DPSwiftExtension
//
//  Created by Xueqiang Ma on 9/11/18.
//

import UIKit

extension DPPagingScrollViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = scrollView.frame.width
        currentPage = floor((scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1
        view.endEditing(true)
    }
}

public class DPPagingScrollViewController: UIViewController {
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            let newOffset = CGPoint(x: self.currentPage * self.scrollView.frame.width, y: 0)
            self.scrollView.setContentOffset(newOffset, animated: false)
        }, completion: nil)
    }
    
    public func scrollTo(pageIndex: Int) {
        var index = pageIndex
        index = max(index, 0)
        index = min(pages.count - 1, index)
        currentPage = CGFloat(index)
        let newOffset = CGPoint(x: currentPage * scrollView.frame.width, y: 0)
        self.scrollView.setContentOffset(newOffset, animated: true)
        
    }
    
    public func set(pages: [UIView]) {
        self.containerView.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        self.pages = pages
        setupPages()
    }
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .brown
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isPagingEnabled = true
        return sv
    }()
    fileprivate let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    fileprivate var currentPage: CGFloat = 0
    fileprivate var pages = [UIView]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContainerView()
        setupPages()
    }
    
    // MARK: Setup Scroll View
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        if #available(iOS 11.0, *) {
            scrollView.enableEdgesAnchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        } else if #available(iOS 9.0, *) {
            scrollView.enableEdgesAnchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func setupContainerView() {
        scrollView.addSubview(containerView)
        if #available(iOS 9.0, *) {
            containerView.enableEdgesAnchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
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
                case 0:
                    NSLayoutConstraint.activate([
                        pageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                        pageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                        pageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                        ])
                case 1, 2:
                    NSLayoutConstraint.activate([
                        pageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                        pageView.leadingAnchor.constraint(equalTo: pages[i - 1].trailingAnchor),
                        pageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        pageView.widthAnchor.constraint(equalTo: pages[i - 1].widthAnchor)
                        ])
                case 3:
                    NSLayoutConstraint.activate([
                        pageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                        pageView.leadingAnchor.constraint(equalTo: pages[i - 1].trailingAnchor),
                        pageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        pageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                        pageView.widthAnchor.constraint(equalTo: pages[i - 1].widthAnchor)
                        ])
                default:
                    break
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
}
