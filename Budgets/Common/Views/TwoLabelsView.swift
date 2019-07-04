//
//  TwoLabelsView.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 04.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class TwoLabelsView: UIView {
    
    var leftLabel = UILabel()
    var rightLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        leftLabel.textColor = UIColor.textGrey
        leftLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        leftLabel.textAlignment = .left
        rightLabel.textColor = UIColor.textGrey
        rightLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        rightLabel.textAlignment = .right
        
        
        
        let views = [
            "leftLabel": leftLabel,
            "rightLabel": rightLabel
        ]
        self.addSubviewsForAutoLayout(views: views)
        
        self.visualConstraint(format: "|[leftLabel]-[rightLabel]|", views: views)
        self.visualConstraint(format: "V:|[leftLabel(24)]|", views: views)
        self.visualConstraint(format: "V:|[rightLabel(24)]|", views: views)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
