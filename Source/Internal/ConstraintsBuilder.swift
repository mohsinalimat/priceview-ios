//
//  ConstraintsBuilder.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/17/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

struct ConstraintsBuilder {
    
    func buildConstraints(style: Style,
                          containerView: UIView,
                          integerLabel: UILabel,
                          decimalLabel: UILabel,
                          decimalSeparatorLabel: UILabel,
                          currencyLabel: UILabel,
                          viewMargins: UILayoutGuide) -> [NSLayoutConstraint] {
        [containerView, integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        var constraints = [NSLayoutConstraint]()
    
        // Container constraints
        constraints = constraints + buildConstraints(for: containerView, style: style, viewMargins: viewMargins)
        
        // Integer Y constraints
        switch style.layout.verticalAlignment {
        case .top:
            constraints.append(integerLabel.topAnchor.constraint(equalTo: containerView.topAnchor))
        case .bottom:
            constraints.append(integerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor))
        case .middle:
            constraints.append(integerLabel.topAnchor.constraint(equalTo: containerView.topAnchor))
            constraints.append(integerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor))
        }
        
        // Labels Y constraints
        [(currencyLabel, style.textStyles.currency),
         (decimalLabel, style.textStyles.decimal),
         (decimalSeparatorLabel, style.textStyles.decimalSeparator)].forEach { (label, textStyle) in
            constraints.append(buildXConstraint(for: label, textStyle: textStyle, to: integerLabel))
        }
        
        // X constraints
        constraints.append(integerLabel.trailingAnchor.constraint(equalTo: decimalSeparatorLabel.leadingAnchor, constant: -style.layout.decimalSeparatorSpacing.leading))
        constraints.append(decimalSeparatorLabel.trailingAnchor.constraint(equalTo: decimalLabel.leadingAnchor, constant: -style.layout.decimalSeparatorSpacing.trailing))
        
        var left: NSLayoutConstraint?
        var right: NSLayoutConstraint?
        
        switch (SymbolPosition(with: style.options.locale)) {
        case .afterCurrency:
            constraints.append(currencyLabel.leadingAnchor.constraint(equalTo: decimalLabel.trailingAnchor, constant: -style.layout.currencySpacing))
            left = integerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            right = currencyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        case .beforeCurrency:
            constraints.append(currencyLabel.trailingAnchor.constraint(equalTo: integerLabel.leadingAnchor, constant: -style.layout.currencySpacing))
            left = currencyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            right = decimalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        }
        
        switch style.layout.horizontalAlignment {
        case .left, .natural:
            constraints.append(left!)
        case .right:
            constraints.append(right!)
        case .center, .justified:
            constraints.append(left!)
            constraints.append(right!)
        }
        
        return constraints
    }
    
    // MARK: - Private
    
    private func buildConstraints(for container: UIView,
                                  style: Style,
                                  viewMargins: UILayoutGuide) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let left = container.leftAnchor.constraint(equalTo: viewMargins.leftAnchor)
        let right = container.rightAnchor.constraint(equalTo: viewMargins.rightAnchor)
        let centerX = container.centerXAnchor.constraint(equalTo: viewMargins.centerXAnchor)
        
        switch style.layout.horizontalAlignment {
        case .left, .natural:
            right.priority = .defaultLow
        case .right:
            left.priority = .defaultLow
        case .center, .justified:
            left.priority = .defaultLow
            right.priority = .defaultLow
            constraints.append(centerX)
        }
        
        constraints.append(left)
        constraints.append(right)
        
        constraints = constraints + buildYConstraints(for: container, style: style, viewMargins: viewMargins)
        
        return constraints
    }
    
    private func buildYConstraints(for view: UIView, style: Style, viewMargins: UILayoutGuide) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let top = view.topAnchor.constraint(equalTo: viewMargins.topAnchor)
        let bottom = view.bottomAnchor.constraint(equalTo: viewMargins.bottomAnchor)
        let centerY = view.centerYAnchor.constraint(equalTo: viewMargins.centerYAnchor)
        
        switch style.layout.verticalAlignment {
        case .top:
            bottom.priority = .defaultLow
        case .bottom:
            top.priority = .defaultLow
        case .middle:
            top.priority = .defaultLow
            bottom.priority = .defaultLow
            constraints.append(centerY)
        }
        
        constraints.append(top)
        constraints.append(bottom)

        return constraints
    }
    
    private func buildXConstraint(for labelA: UILabel, textStyle: TextStyle, to integerLabel: UILabel) -> NSLayoutConstraint {
        switch textStyle.verticalAlignment {
        case .baseline(let x):
            return labelA.lastBaselineAnchor.constraint(equalTo: integerLabel.lastBaselineAnchor, constant: x)
        case .bottom(let x):
            return labelA.bottomAnchor.constraint(equalTo: integerLabel.bottomAnchor, constant: x)
        case .middle(let x):
            return labelA.centerYAnchor.constraint(equalTo: integerLabel.centerYAnchor, constant: x)
        case .top(let x):
            return labelA.topAnchor.constraint(equalTo: integerLabel.topAnchor, constant: x)
        }
    }
}


