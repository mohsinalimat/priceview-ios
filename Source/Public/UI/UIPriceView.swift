//
//  UIPriceView.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public final class UIPriceView: UIView {
    
    // MARK: - Properties
    
    public var price: Double = 0.0 {
        didSet {
            bind()
        }
    }
    
    public var style = Style(
        integerTextStyle: TextStyle(size: 20, color: .black, kern: 1.2),
        decimalTextStyle: TextStyle(size: 10, color: .darkGray),
        decimalSeparatorTextStyle: TextStyle(size: 10, color: .darkGray),
        currencyTextStyle: TextStyle(size: 12, color: .black) ) {
        didSet {
            updateStyle()
            bind()
        }
    }
    
    public var locale: Locale {
        didSet {
            setupConstraints()
            bind()
        }
    }
    
    private let containerView = UIView()
    private lazy var currencyLabel = makeCurrencyLabel()
    private lazy var integerLabel = makeIntegerLabel()
    private lazy var decimalSeparatorLabel = makeDecimalSeparatorLabel()
    private lazy var decimalLabel = makeDecimalLabel()
    
    private let builder = ConstraintsBuilder()
    private var currentConstraints = [NSLayoutConstraint]()
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        self.locale = Locale.current
        super.init(frame: frame)
        setup()
    }
    
    public init(style: Style, locale: Locale = Locale.current) {
        self.style = style
        self.locale = locale
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance methods
    
    private func setup() {
        addSubview(containerView)
        [integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            containerView.addSubview($0)
        }
        
        bind()
        setupConstraints()
    }
    
    private func bind() {
        let formatter = Formatter(with: style, locale: locale)
        
        decimalSeparatorLabel.text = formatter.decimalSeparator
        currencyLabel.text = formatter.currencySymbol
        
        let formattedInteger = formatter.formattedInteger(price: price)
        let formattedDecimal = formatter.formattedDecimal(price: price)
        
        //apply kerning
        integerLabel.attributedText = NSAttributedString(string: formattedInteger, attributes: [.kern: style.textStyles.integer.kern])
        decimalLabel.attributedText = NSAttributedString(string: formattedDecimal, attributes: [.kern: style.textStyles.decimal.kern])
    }
    
    private func updateStyle() {
        setupConstraints()
        [(integerLabel, style.textStyles.integer),
         (decimalSeparatorLabel, style.textStyles.decimalSeparator),
         (decimalLabel, style.textStyles.decimal),
         (currencyLabel, style.textStyles.currency)].forEach {
            updateLabel($0.0, with: $0.1)
        }
    }
        
    private func setupConstraints() {
        NSLayoutConstraint.deactivate(currentConstraints)
                
        currentConstraints = builder.buildConstraints(style: style,
                                                      locale: locale,
                                                      containerView: containerView,
                                                      integerLabel: integerLabel,
                                                      decimalLabel: decimalLabel,
                                                      decimalSeparatorLabel: decimalSeparatorLabel,
                                                      currencyLabel: currencyLabel,
                                                      viewMargins: layoutMarginsGuide)
        
        NSLayoutConstraint.activate(currentConstraints)
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
        label.minimumScaleFactor = 0.5
        updateLabel(label, with: style)
        
        return label
    }
    
    private func updateLabel(_ label: UILabel, with textStyle: TextStyle) {
        label.textColor = textStyle.color
        switch textStyle.fontSize {
        case .font(let font):
            label.font = font
        case let .size(size, weight):
            label.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: weight)
        }
    }
}
