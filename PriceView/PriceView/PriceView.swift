//
//  PriceView.swift
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
    
    var style: PriceViewStyle = PriceViewStyle(
        integerTextStyle: TextStyle(size: 20, color: .black, kern: 1.2),
        decimalTextStyle: TextStyle(size: 10, color: .darkGray),
        decimalSeparatorTextStyle: TextStyle(size: 10, color: .darkGray),
        currencyTextStyle: TextStyle(size: 12, color: .black) )
    
    private lazy var currencyLabel = makeCurrencyLabel()
    private lazy var integerLabel = makeIntegerLabel()
    private lazy var decimalSeparatorLabel = makeDecimalSeparatorLabel()
    private lazy var decimalLabel = makeDecimalLabel()
 
    private var priceData: PriceData {
        // Inject transformer? cake pattern?
        return PriceTransformer().transformedData(price: price, locale: style.locale)
    }
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init(style: PriceViewStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    private func setup() {
        [integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            addSubview($0)
        }
        
        bind()
        setupConstraints(with: style)
    }
    
    private func bind() {
        // computed property didSet?
        
        let formatter = PriceFormatter()
        
        decimalSeparatorLabel.text = "\(priceData.decimalSeparator)"
        currencyLabel.text = priceData.currencySymbol
        
        //apply kerning
        integerLabel.attributedText = NSAttributedString(string: formatter.string(from: NSNumber(value: priceData.integerPart))!, attributes: [.kern: style.integerTextStyle.kern])
        
        decimalLabel.attributedText = NSAttributedString(string: "\(priceData.decimalPart)", attributes: [.kern: style.decimalTextStyle.kern])
    }
    
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

    private func setUpConstraints(between labelA: UILabel, and layoutGuide: UILayoutGuide, with alignment: TextVerticalAlignment) {
        switch alignment {
        case .baseline(let offset):
            labelA.lastBaselineAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset).isActive = true
        case .bottom(let offset):
            labelA.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset).isActive = true
        case .top(let offset):
            labelA.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset).isActive = true
        case .middle(let offset):
            labelA.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: offset).isActive = true
        }
    }
    
    private func setupConstraints(with style: PriceViewStyle) {
        [integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let viewMargins = layoutMarginsGuide
        
        let currencyBefore = style.symbolPosition == .beforeCurrency
        let currencyAfter = !currencyBefore
        
        // currency V
        setUpConstraints(between: currencyLabel, and: integerLabel, with: style.currencyTextStyle)
        
        // before
        currencyLabel.leadingAnchor.constraint(equalTo: viewMargins.leadingAnchor).isActive = currencyBefore
        currencyLabel.trailingAnchor.constraint(equalTo: integerLabel.leadingAnchor, constant: -style.currencySpacing).isActive = currencyBefore
        decimalLabel.trailingAnchor.constraint(equalTo: viewMargins.trailingAnchor).isActive = currencyBefore
        
        //after
        currencyLabel.trailingAnchor.constraint(equalTo: viewMargins.trailingAnchor).isActive = currencyAfter
        currencyLabel.leadingAnchor.constraint(equalTo: decimalLabel.trailingAnchor, constant: style.currencySpacing).isActive = currencyAfter
        integerLabel.leadingAnchor.constraint(equalTo: viewMargins.leadingAnchor).isActive = currencyAfter
        
        decimalSeparatorLabel.leadingAnchor.constraint(equalTo: integerLabel.trailingAnchor, constant: style.decimalSeparatorSpacing.leading).isActive = true
        
        decimalLabel.leadingAnchor.constraint(equalTo: decimalSeparatorLabel.trailingAnchor, constant: style.decimalSeparatorSpacing.trailing).isActive = true
        
        // V
        setUpConstraints(between: decimalSeparatorLabel, and: integerLabel, with: style.decimalSeparatorTextStyle)
        setUpConstraints(between: decimalLabel, and: integerLabel, with: style.decimalTextStyle)
        
        // V
        if let alignment = style.alignment {
            // CHECK IF HEIGHT IS SET?
            setUpConstraints(between: integerLabel, and: viewMargins, with: alignment)
        } else {
            integerLabel.topAnchor.constraint(equalTo: viewMargins.topAnchor).isActive = true
            integerLabel.bottomAnchor.constraint(equalTo: viewMargins.bottomAnchor).isActive = true
        }
    }
    
    // MARK: - UI
    
    private func makeIntegerLabel() -> UILabel {
        return makeLabel(with: style.integerTextStyle)
    }
    
    private func makeDecimalLabel() -> UILabel {
        return makeLabel(with: style.decimalTextStyle)
    }
    
    private func makeDecimalSeparatorLabel() -> UILabel {
        return makeLabel(with: style.decimalSeparatorTextStyle)
    }
    
    private func makeCurrencyLabel() -> UILabel {
        return makeLabel(with: style.currencyTextStyle)
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
