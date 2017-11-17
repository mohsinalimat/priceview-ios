//
//  ConstraintsBuilder.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/17/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

struct ConstraintsBuilder {
    
    func buildConstraints(style: Style, containerView: UIView, integerLabel: UILabel, decimalLabel: UILabel, decimalSeparatorLabel: UILabel, currencyLabel: UILabel, viewMargins: UILayoutGuide) -> [NSLayoutConstraint] {
        [containerView, integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let currencyBefore = SymbolPosition(with: style.options.locale) == .beforeCurrency
        var constraints = [NSLayoutConstraint]()
        
        constraints += xConstraints(for: containerView, with: viewMargins, and: style.layout.horizontalAlignment)
        constraints += yConstraints(for: containerView, with: viewMargins, and: style.layout.verticalAlignment)
        
        constraints += [integerLabel.topAnchor.constraint(equalTo: containerView.topAnchor), integerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)]
        
        constraints += [decimalLabel.leadingAnchor.constraint(equalTo: decimalSeparatorLabel.trailingAnchor, constant: style.layout.decimalSeparatorSpacing.trailing)]
        constraints += [decimalSeparatorLabel.leadingAnchor.constraint(equalTo: integerLabel.trailingAnchor, constant: style.layout.decimalSeparatorSpacing.leading)]
        
        if currencyBefore {
            constraints += [currencyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor), currencyLabel.trailingAnchor.constraint(equalTo: integerLabel.leadingAnchor, constant: -style.layout.currencySpacing)]
            constraints.append(decimalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))
        } else {
            constraints += [currencyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                            currencyLabel.leadingAnchor.constraint(equalTo: decimalLabel.trailingAnchor, constant: style.layout.currencySpacing)]
            constraints.append(integerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor))
        }
        
        constraints.append(yConstraint(between: currencyLabel, and: integerLabel, with: style.textStyles.currency))
        constraints.append(yConstraint(between: decimalSeparatorLabel, and: integerLabel, with: style.textStyles.decimalSeparator))
        constraints.append(yConstraint(between: decimalLabel, and: integerLabel, with: style.textStyles.decimal))
        
        return constraints
    }
    
    // MARK: - Private
    
    private func yConstraint(between labelA: UILabel,
                             and labelB: UILabel,
                             with labelATextStyle: TextStyle) -> NSLayoutConstraint {
        switch labelATextStyle.verticalAlignment {
        case .baseline(let offset):
            return labelA.lastBaselineAnchor.constraint(equalTo: labelB.lastBaselineAnchor, constant: offset)
        case .bottom(let offset):
            return labelA.bottomAnchor.constraint(equalTo: labelB.bottomAnchor, constant: offset)
        case .top(let offset):
            return labelA.topAnchor.constraint(equalTo: labelB.topAnchor, constant: offset)
        case .middle(let offset):
            return labelA.centerYAnchor.constraint(equalTo: labelB.centerYAnchor, constant: offset)
        }
    }
    
    private func yConstraints(for view: UIView,
                              with layoutGuide: UILayoutGuide,
                              and alignment: Layout.VerticalAlignment) -> [NSLayoutConstraint] {
        let top = view.topAnchor.constraint(equalTo: layoutGuide.topAnchor)
        let bottom = view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        let centerY = view.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor)
        
        switch alignment {
        case .top:
            top.priority = .defaultHigh
            bottom.priority = .defaultLow
            return [top, bottom]
        case .bottom:
            top.priority = .defaultLow
            bottom.priority = .defaultHigh
            return [top, bottom]
        case .middle:
            top.priority = .defaultLow
            bottom.priority = .defaultLow
            centerY.priority = .defaultHigh
            return [top, bottom, centerY]
        }
    }
    
    private func xConstraints(for view: UIView,
                              with layoutGuide: UILayoutGuide,
                              and alignment: NSTextAlignment) -> [NSLayoutConstraint] {
        let left = view.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor)
        let right = view.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor)
        let leading = view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor)
        let trailing = view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        let centerX = view.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)
        
        switch alignment {
        case .natural:
            leading.priority = .defaultHigh
            trailing.priority = .defaultLow
            return [leading, trailing]
        case .left:
            left.priority = .defaultHigh
            right.priority = .defaultLow
            return [left, right]
        case .right:
            left.priority = .defaultLow
            right.priority = .defaultHigh
            return [left, right]
        case .justified, .center:
            trailing.priority = .defaultLow
            leading.priority = .defaultLow
            centerX.priority = .defaultHigh
            return [trailing, leading, centerX]
        }
    }
}
