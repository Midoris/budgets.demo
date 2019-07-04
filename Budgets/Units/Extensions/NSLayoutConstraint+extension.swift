//
//  NSLayoutConstraint+extension.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 04.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    class func layout(firstViewAttribute: (UIView, NSLayoutConstraint.Attribute),
                      secondViewAttribute: (UIView, NSLayoutConstraint.Attribute)? = nil,
                      relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal,
                      multiplier: CGFloat = 1.0,
                      constant: CGFloat = 0.0 ) -> NSLayoutConstraint {
        
        var secondView: UIView? = nil
        var secondAttribute: NSLayoutConstraint.Attribute = NSLayoutConstraint.Attribute.notAnAttribute
        if secondViewAttribute != nil {
            secondView = secondViewAttribute!.0
            secondAttribute = secondViewAttribute!.1
        }
        
        // setting multiplier to 0.0 causes crash
        let safeMultiplier = max(multiplier, 0.0001)
        
        return NSLayoutConstraint(item: firstViewAttribute.0, attribute: firstViewAttribute.1, relatedBy: relation, toItem: secondView, attribute: secondAttribute, multiplier: safeMultiplier, constant: constant)
        
    }
    
    class func constraintsForCenteredSameSize(superview: UIView, subview: UIView) -> [NSLayoutConstraint] {
        
        var constraints: [NSLayoutConstraint] = []
        
        let viewsDic = ["subview": subview]
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: [], metrics: nil, views: viewsDic)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: [], metrics: nil, views: viewsDic)
        
        return constraints
    }
    
    class func sizeConstraint(item: UIView, size: CGSize) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(
            item: item,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: size.width))
        constraints.append(NSLayoutConstraint(
            item: item,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: size.height))
        return constraints
    }
    
}

