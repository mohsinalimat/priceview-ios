//
//  UIPriceView.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public final class UIPriceView: UIView {
    
    public var price: Double = 0.0 {
        didSet {
            bind()
        }
    }
    
    var style = Style(
        integerTextStyle: TextStyle(size: 20, color: .black, kern: 1.2),
        decimalTextStyle: TextStyle(size: 10, color: .darkGray),
        decimalSeparatorTextStyle: TextStyle(size: 10, color: .darkGray),
        currencyTextStyle: TextStyle(size: 12, color: .black) )
    
    private let containerView = UIView()
    private lazy var currencyLabel = makeCurrencyLabel()
    private lazy var integerLabel = makeIntegerLabel()
    private lazy var decimalSeparatorLabel = makeDecimalSeparatorLabel()
    private lazy var decimalLabel = makeDecimalLabel()
    
    private var formatter: Formatter {
        return Formatter(with: style)
    }
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    private func setup() {
        addSubview(containerView)
        [integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            containerView.addSubview($0)
        }
        
        bind()
        setupConstraints(with: style)
    }
    
    private func bind() {
        decimalSeparatorLabel.text = formatter.decimalSeparator
        currencyLabel.text = formatter.currencySymbol
        
        let formattedInteger = formatter.formattedInteger(price: price)
        let formattedDecimal = formatter.formattedDecimal(price: price)
        
        //apply kerning
        integerLabel.attributedText = NSAttributedString(string: formattedInteger, attributes: [.kern: style.textStyles.integer.kern])
        
        decimalLabel.attributedText = NSAttributedString(string: formattedDecimal, attributes: [.kern: style.textStyles.decimal.kern])
    }
    
    // MARK: - Constraints
    
    private func setUpConstraints(between labelA: UILabel, and labelB: UILabel, with labelATextStyle: TextStyle) {
        switch labelATextStyle.verticalAlignment {
        case .baseline(let offset):
            labelA.lastBaselineAnchor.constraint(equalTo: labelB.lastBaselineAnchor, constant: offset).isActive = true
        case .bottom(let offset):
            labelA.bottomAnchor.constraint(equalTo: labelB.bottomAnchor, constant: offset).isActive = true
        case .top(let offset):
            labelA.topAnchor.constraint(equalTo: labelB.topAnchor, constant: offset).isActive = true
        case .middle(let offset):
            labelA.centerYAnchor.constraint(equalTo: labelB.centerYAnchor, constant: offset).isActive = true
        }
    }

    private func setUpVerticalConstraints(for view: UIView,
                                          with layoutGuide: UILayoutGuide,
                                          and alignment: Layout.VerticalAlignment) {
        let top = view.topAnchor.constraint(equalTo: layoutGuide.topAnchor)
        let bottom = view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        let centerY = view.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor)

        switch alignment {
        case .top:
            top.isActive = true
            top.priority = .required
            bottom.isActive = true
            bottom.priority = .defaultLow
        case .bottom:
            top.isActive = true
            top.priority = .defaultLow
            bottom.isActive = true
            bottom.priority = .defaultHigh
        case .middle:
            top.isActive = true
            top.priority = .defaultLow
            bottom.isActive = true
            bottom.priority = .defaultLow
            centerY.isActive = true
            centerY.priority = .defaultHigh
        }
    }
    
    private func setUpHorizontalConstraints(for view: UIView,
                                            with layoutGuide: UILayoutGuide,
                                            and alignment: NSTextAlignment) {
        let left = view.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor)
        let right = view.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor)
        let leading = view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor)
        let trailing = view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        let centerX = view.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)
        
        switch alignment {
        case .natural:
            leading.isActive = true
            leading.priority = .defaultHigh
            trailing.isActive = true
            trailing.priority = .defaultLow
        case .left:
            left.isActive = true
            left.priority = .defaultHigh
            right.isActive = true
            right.priority = .defaultLow
        case .right:
            left.isActive = true
            left.priority = .defaultLow
            right.isActive = true
            right.priority = .defaultHigh
        case .justified, .center:
            trailing.isActive = true
            trailing.priority = .defaultLow
            leading.isActive = true
            leading.priority = .defaultLow
            centerX.isActive = true
            centerX.priority = .defaultHigh
        }
    }
    
    private func setupConstraints(with style: Style) {
        [containerView, integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let viewMargins = layoutMarginsGuide
        
        setUpVerticalConstraints(for: containerView, with: viewMargins, and: style.layout.verticalAlignment)
        setUpHorizontalConstraints(for: containerView, with: viewMargins, and: style.layout.horizontalAlignment)
        
        let currencyBefore = style.symbolPosition == .beforeCurrency
        let currencyAfter = !currencyBefore
        
        integerLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        integerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        // before
        currencyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = currencyBefore
        currencyLabel.trailingAnchor.constraint(equalTo: integerLabel.leadingAnchor, constant: -style.layout.currencySpacing).isActive = currencyBefore
        decimalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = currencyBefore
        
        //after
        currencyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = currencyAfter
        currencyLabel.leadingAnchor.constraint(equalTo: decimalLabel.trailingAnchor, constant: style.layout.currencySpacing).isActive = currencyAfter
        integerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = currencyAfter
        
        decimalSeparatorLabel.leadingAnchor.constraint(equalTo: integerLabel.trailingAnchor, constant: style.layout.decimalSeparatorSpacing.leading).isActive = true
        
        decimalLabel.leadingAnchor.constraint(equalTo: decimalSeparatorLabel.trailingAnchor, constant: style.layout.decimalSeparatorSpacing.trailing).isActive = true
        
        // V
        setUpConstraints(between: currencyLabel, and: integerLabel, with: style.textStyles.currency)
        setUpConstraints(between: decimalSeparatorLabel, and: integerLabel, with: style.textStyles.decimalSeparator)
        setUpConstraints(between: decimalLabel, and: integerLabel, with: style.textStyles.decimal)
    }
    
    // MARK: - UI
    
    private func makeIntegerLabel() -> UILabel {
        return makeLabel(with: style.textStyles.integer)
    }
    
    private func makeDecimalLabel() -> UILabel {
        return makeLabel(with: style.textStyles.decimal)
    }
    
    private func makeDecimalSeparatorLabel() -> UILabel {
        return makeLabel(with: style.textStyles.decimalSeparator)
    }
    
    private func makeCurrencyLabel() -> UILabel {
        return makeLabel(with: style.textStyles.currency)
    }
    
    private func makeLabel(with style: TextStyle) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: style.size)
        label.textColor = style.color
        label.minimumScaleFactor = 0.5
        return label
    }
}
