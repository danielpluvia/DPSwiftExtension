//
//  DPPaddingUITextField.swift
//  DPSwiftExtension
//
//  Created by Xueqiang Ma on 3/11/18.
//

import Foundation

public class DPPaddingUITextField: UITextField {
  
  fileprivate let padding: UIEdgeInsets
  
  public init(frame: CGRect, padding: UIEdgeInsets) {
    self.padding = padding
    super.init(frame: frame)
    self.backgroundColor = .white
  }
  
  convenience public init(padding: UIEdgeInsets) {
    self.init(frame: .zero, padding: padding)
  }

  /// Add padding to the left and the right.
  ///
  /// - Parameter xPadding: left or right.
  convenience public init(xPadding: CGFloat) {
    self.init(frame: .zero, padding: UIEdgeInsets(top: 0, left: xPadding, bottom: 0, right: xPadding))
  }
  
  /// Add padding to the top and the bottom
  ///
  /// - Parameter yPadding: top or bottom.
  convenience public init(yPadding: CGFloat) {
    self.init(frame: .zero, padding: UIEdgeInsets(top: yPadding, left: 0, bottom: yPadding, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  public override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
}
