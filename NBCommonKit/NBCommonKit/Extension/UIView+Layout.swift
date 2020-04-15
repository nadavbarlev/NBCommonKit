//
//  UIView+Layout.swift
//  NBCommonKit
//
//  Created by Nadav Bar Lev on 16/04/2020.
//  Copyright © 2020 Nadav Bar Lev. All rights reserved.
//

import UIKit

public struct NBLayoutConstraints {
    public var top: NSLayoutConstraint?
    public var leading: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    public var trailing: NSLayoutConstraint?
    public var width: NSLayoutConstraint?
    public var height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    open func anchors(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                        trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero,
                        size: CGSize? = nil) -> NBLayoutConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = NBLayoutConstraints()
        
        if let top = top {
            constraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
    
        if let leading = leading {
            constraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            constraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            constraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if let size = size {
            constraints.width = widthAnchor.constraint(equalToConstant: size.width)
            constraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
      
        [constraints.top, constraints.leading, constraints.bottom, constraints.trailing,
         constraints.width, constraints.height].forEach { $0?.isActive = true }
        
        return constraints
    }
    
    @discardableResult
    open func fillSuperview(with padding: UIEdgeInsets = .zero) -> Bool {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
              let superviewBottomAnchor = superview?.bottomAnchor,
              let superviewLeadingAnchor = superview?.leadingAnchor,
              let superviewTrailingAnchor = superview?.trailingAnchor else { return false }
        anchors(top: superviewTopAnchor, leading: superviewLeadingAnchor,
                bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
        return true
    }
    
    @discardableResult
    open func centerInSuperview() -> Bool {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewCenterXAnchor = superview?.centerXAnchor,
              let superviewCenterYAnchor = superview?.centerYAnchor else { return false }
        centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        return true
    }
}
