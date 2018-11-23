//
//  DPPageControl.swift
//  DPSwiftExtension
//
//  Created by Xueqiang Ma on 21/11/18.
//

import UIKit

fileprivate class IndicatorContainerView: UIView {
    
    var indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class DPPageControl: UIControl {
    // MARK: open vars
    open var numberOfPages: Int = 0
    open var currentPage: Int = 0
    open var progress: CGFloat = 0   // 0...1
    open var hidesForSinglePage: Bool = false
    open var indicatorWidth: CGFloat = 30 {
        didSet {
            widthConstraint?.constant = indicatorWidth
            inactiveWidthConstraint?.constant = indicatorWidth
        }
    }
    open var indicatorHeight: CGFloat = 5 {
        didSet {
            inactiveHeightConstraint?.constant = indicatorHeight
        }
    }
    open var radius: CGFloat {
        return indicatorHeight / 3.0
    }
    open var pageIndicatorTintColor: UIColor = UIColor.red.withAlphaComponent(0.3) {
        didSet {
            stackView.arrangedSubviews.forEach { (arrangedSubview) in
                guard let containerView = arrangedSubview as? IndicatorContainerView else { return }
                containerView.indicator.backgroundColor = pageIndicatorTintColor
            }
        }
    }
    open var currentPageIndicatorTintColor: UIColor = .red {
        didSet {
            active.backgroundColor = currentPageIndicatorTintColor
        }
    }
    // MARK: fileprivate vars
    fileprivate var active: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate var stackView: UIStackView = {  // Contains inactive indicators
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    // Constraints of the active view
    fileprivate var centerXConstraint: NSLayoutConstraint?
    fileprivate var widthConstraint: NSLayoutConstraint?
    // Constraints of the first inactive view
    fileprivate var inactiveWidthConstraint: NSLayoutConstraint?
    fileprivate var inactiveHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 40)
    }
    
}

extension DPPageControl {
    open func set(numberOfPages: Int) {
        resetViews()
        guard numberOfPages > 0 else {
            self.numberOfPages = 0
            return
        }
        self.numberOfPages = numberOfPages
        
        // Add inactive indicators and constraints
        let firstView = IndicatorContainerView()
        stackView.addArrangedSubview(firstView)
        firstView.indicator.layer.cornerRadius = radius
        inactiveWidthConstraint = firstView.indicator.widthAnchor.constraint(equalToConstant: indicatorWidth)
        inactiveHeightConstraint = firstView.indicator.heightAnchor.constraint(equalToConstant: indicatorHeight)
        inactiveWidthConstraint?.isActive = true
        inactiveHeightConstraint?.isActive = true
        firstView.indicator.backgroundColor = pageIndicatorTintColor
        for _ in 1..<numberOfPages {
            let containerView = IndicatorContainerView()
            stackView.addArrangedSubview(containerView)
            NSLayoutConstraint.activate([
                containerView.indicator.widthAnchor.constraint(equalTo: firstView.indicator.widthAnchor),
                containerView.indicator.heightAnchor.constraint(equalTo: firstView.indicator.heightAnchor)
                ])
            containerView.indicator.backgroundColor = pageIndicatorTintColor
            containerView.indicator.layer.cornerRadius = radius
        }
        
        // set active indicator and constraints
        NSLayoutConstraint.activate([
            active.heightAnchor.constraint(equalTo: firstView.indicator.heightAnchor),
            active.centerYAnchor.constraint(equalTo: firstView.indicator.centerYAnchor)
            ])
        centerXConstraint = active.centerXAnchor.constraint(equalTo: firstView.indicator.centerXAnchor)
        centerXConstraint?.isActive = true
        widthConstraint = active.widthAnchor.constraint(equalToConstant: indicatorWidth)
        widthConstraint?.isActive = true
        active.backgroundColor = currentPageIndicatorTintColor
        active.layer.cornerRadius = radius
    }
    
    open func update(progress: CGFloat) {
        guard progress >= 0 && progress <= 1 else { return }
        self.progress = max(progress, 0)
        self.progress = min(progress, 1)
        let totalWidth = self.frame.width * CGFloat(numberOfPages - 1) / CGFloat(numberOfPages)
        centerXConstraint?.constant = totalWidth * self.progress
        let calculateProgress = self.progress * CGFloat(numberOfPages - 1)
        let distance = abs(round(calculateProgress) - calculateProgress)
        let mult = distance * 2
        let perWidth = self.frame.width / CGFloat(numberOfPages)
        let widthConstant = perWidth * CGFloat(mult) + indicatorWidth
        widthConstraint?.constant = min(widthConstant, perWidth * 0.65)
    }
}

extension DPPageControl {
    fileprivate func setupViews() {
        setupStackView()
        setupActiveView()
    }
    
    fileprivate func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    
    fileprivate func setupActiveView() {
        addSubview(active)
    }
    
    /// Remove subviews and constraints
    fileprivate func resetViews() {
        stackView.removeAllArrangedSubviews()   // Remove inactive indicator's views and constraints
        NSLayoutConstraint.deactivate(active.constraints)   // invalidate active indicator's constraints
        centerXConstraint = nil
        widthConstraint = nil
        inactiveWidthConstraint = nil
        inactiveHeightConstraint = nil
    }
}
