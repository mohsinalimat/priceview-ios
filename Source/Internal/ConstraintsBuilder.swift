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
                          locale: Locale,
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
        constraints = constraints + buildYConstraints(for: integerLabel, style: style, to: containerView)
        
        // Labels Y constraints
        [(currencyLabel, style.currency),
         (decimalLabel, style.decimal),
         (decimalSeparatorLabel, style.decimalSeparator)].forEach { (label, textStyle) in
            constraints.append(buildYConstraint(for: label, textStyle: textStyle, to: integerLabel))
        }
        
        // X constraints
        constraints.append(integerLabel.trailingAnchor.constraint(equalTo: decimalSeparatorLabel.leadingAnchor, constant: -style.decimalSeparatorSpacing.leading))
        constraints.append(decimalSeparatorLabel.trailingAnchor.constraint(equalTo: decimalLabel.leadingAnchor, constant: -style.decimalSeparatorSpacing.trailing))
        
        let left: NSLayoutConstraint
        let right: NSLayoutConstraint
        
        switch (SymbolPosition(with: locale)) {
        case .afterCurrency:
            constraints.append(currencyLabel.leadingAnchor.constraint(equalTo: decimalLabel.trailingAnchor, constant: style.currencySpacing))
            left = constraint(view: integerLabel, to: containerView, on: \UIView.leadingAnchor)
            right = constraint(view: currencyLabel, to: containerView, on: \UIView.trailingAnchor)
        case .beforeCurrency:
            constraints.append(currencyLabel.trailingAnchor.constraint(equalTo: integerLabel.leadingAnchor, constant: -style.currencySpacing))
            left = constraint(view: currencyLabel, to: containerView, on: \UIView.leadingAnchor)
            right = constraint(view: decimalLabel, to: containerView, on: \UIView.trailingAnchor)
        }
        
        switch style.horizontalAlignment {
        case .left, .natural:
            constraints.append(left)
        case .right:
            constraints.append(right)
        case .center, .justified:
            constraints.append(left)
            constraints.append(right)
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
        
        switch style.horizontalAlignment {
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
    
    private func constraint<Axis, L>(view: UIView, to viewB: UIView, on keyPath: KeyPath<UIView, L>, with constant: CGFloat = 0) -> NSLayoutConstraint where L: NSLayoutAnchor<Axis> {
            return view[keyPath: keyPath].constraint(equalTo: viewB[keyPath: keyPath], constant: constant)
    }
    
    private func buildYConstraints(for view: UIView, style: Style, viewMargins: UILayoutGuide) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let top = view.topAnchor.constraint(equalTo: viewMargins.topAnchor)
        let bottom = view.bottomAnchor.constraint(equalTo: viewMargins.bottomAnchor)
        let centerY = view.centerYAnchor.constraint(equalTo: viewMargins.centerYAnchor)
        
        switch style.verticalAlignment {
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
    
    private func buildYConstraint(for labelA: UILabel, textStyle: TextStyle, to integerLabel: UILabel) -> NSLayoutConstraint {
        switch textStyle.verticalAlignment {
        case .baseline(let x):
            return constraint(view: labelA, to: integerLabel, on: \UIView.lastBaselineAnchor, with: x)
        case .bottom(let x):
            return constraint(view: labelA, to: integerLabel, on: \UIView.bottomAnchor, with: x)
        case .middle(let x):
            return constraint(view: labelA, to: integerLabel, on: \UIView.centerYAnchor, with: x)
        case .top(let x):
            return constraint(view: labelA, to: integerLabel, on: \UIView.topAnchor, with: x)
        }
    }
    
    private func buildYConstraints(for label: UILabel, style: Style, to containerView: UIView) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        switch style.verticalAlignment {
        case .top:
            constraints.append(constraint(view: label, to: containerView, on: \UIView.topAnchor))
        case .bottom:
            constraints.append(constraint(view: label, to: containerView, on: \UIView.bottomAnchor))
        case .middle:
            constraints.append(constraint(view: label, to: containerView, on: \UIView.topAnchor))
            constraints.append(constraint(view: label, to: containerView, on: \UIView.bottomAnchor))
        }

        return constraints
    }
}


