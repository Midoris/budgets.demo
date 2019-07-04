//
//  UIView+extension.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 04.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(views: [UIView]) {
        views.forEach {self.addSubview($0)}
    }
    
    func addSubviewsForAutoLayout(views: [String: UIView]) {
        for (_, sview) in views {
            self.addSubviewForAutoLayout(sview)
        }
    }
    
    func addSubviewForAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    class func spacerView() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = false
        return view
    }
    
    @discardableResult
    func visualConstraint(format: String,
                          options: NSLayoutConstraint.FormatOptions = [],
                          metrics: [String: CGFloat]? = nil,
                          views: [String: UIView]) -> [NSLayoutConstraint] {
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: views)
        self.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    func addLayoutConstraint(firstViewAttribute: (UIView, NSLayoutConstraint.Attribute),
                             secondViewAttribute: (UIView, NSLayoutConstraint.Attribute)? = nil,
                             relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal,
                             multiplier: CGFloat = 1.0,
                             constant: CGFloat = 0.0,
                             identifier: String? = nil
        ) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint.layout(firstViewAttribute: firstViewAttribute, secondViewAttribute: secondViewAttribute, relation: relation, multiplier: multiplier, constant: constant)
        constraint.identifier = identifier
        self.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func horizontalCenteredSameSizeLayout(subview: UIView) -> [NSLayoutConstraint] {
        let views = ["subview": subview]
        return visualConstraint(format: "H:|[subview]|", views: views)
    }
    
    @discardableResult
    func verticalCenteredSameSizeLayout(subview: UIView) -> [NSLayoutConstraint] {
        let views = ["subview": subview]
        return visualConstraint(format: "V:|[subview]|", views: views)
    }
    
    @discardableResult
    func addCenteredSameSizeLayout(subview: UIView) -> [NSLayoutConstraint] {
        
        self.addSubviewsForAutoLayout(views: ["subview": subview])
        var layouts = horizontalCenteredSameSizeLayout(subview: subview)
        layouts += verticalCenteredSameSizeLayout(subview: subview)
        
        return layouts
    }
    
}

extension UIView {
    
    static func getTitleSubtitleView(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -4, width: 0, height: 18))
        
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 0, height: 14))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.black
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 38))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        return titleView
    }
}
