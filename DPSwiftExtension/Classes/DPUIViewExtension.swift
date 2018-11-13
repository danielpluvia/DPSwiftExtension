//
//  DPUIViewExtension.swift
//  DPSwiftExtension
//
//  Created by Xueqiang Ma on 3/11/18.
//

extension UIView {
  
  /// Activate four edges anchors.
  ///
  /// - Parameters:
  ///   - top: top anchor
  ///   - leading: leading anchor
  ///   - bottom: bottom anchor
  ///   - trailing: trailing anchor
  ///   - topConstant: top constant
  ///   - leadingConstant: leading constant
  ///   - bottomConstant: bottom constant, it's usually negative
  ///   - trailingConstant: trailing constant, it's usually negative
  @available(iOS 9.0, *)
  @discardableResult
  public func enableEdgesAnchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, topConstant: CGFloat = 0, leadingConstant: CGFloat = 0, bottomConstant: CGFloat = 0, trailingConstant: CGFloat = 0) -> [NSLayoutConstraint] {
    self.translatesAutoresizingMaskIntoConstraints = false
    var anchors: [NSLayoutConstraint] = []
    if let top = top {
      anchors.append(self.topAnchor.constraint(equalTo: top, constant: topConstant))
    }
    if let leading = leading {
      anchors.append(self.leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
    }
    if let bottom = bottom {
      anchors.append(self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
    }
    if let trailing = trailing {
      anchors.append(self.trailingAnchor.constraint(equalTo: trailing, constant: trailingConstant))
    }
    anchors.forEach ({
      $0.isActive = true
    })
    return anchors
  }
  
  /// Activate width or height anchor.
  ///
  /// - Parameters:
  ///   - width: width
  ///   - height: height
  @available(iOS 9.0, *)
  @discardableResult
  public func enableSizeAnchor(width: CGFloat?, height: CGFloat?) -> [NSLayoutConstraint] {
    self.translatesAutoresizingMaskIntoConstraints = false
    var anchors: [NSLayoutConstraint] = []
    if let width = width {
      anchors.append(self.widthAnchor.constraint(equalToConstant: width))
    }
    if let height = height {
      anchors.append(self.heightAnchor.constraint(equalToConstant: height))
    }
    anchors.forEach({ $0.isActive = true })
    return anchors
  }
    
    @available(iOS 9.0, *)
    @discardableResult
    public func fillSuperview(padding: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var anchors: [NSLayoutConstraint] = []
        if let superviewTopAnchor = superview?.topAnchor {
            anchors.append(topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top))
        }
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            anchors.append(leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left))
        }
        if let superviewBottomAnchor = superview?.bottomAnchor {
            anchors.append(bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom))
        }
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            anchors.append(trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right))
        }
        anchors.forEach({ $0.isActive = true })
        return anchors
    }
  
}
