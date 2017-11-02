//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct TextStyle {
    var size: CGFloat
    var color: UIColor
    var kern: CGFloat
    var baselineOffset: CGFloat
    
    init(size: CGFloat,
         color: UIColor,
         kern: CGFloat = 0.0,
         baselineOffset: CGFloat = 0
    ) {
        self.size = size
        self.color = color
        self.kern = kern
        self.baselineOffset = baselineOffset
    }
}

struct PriceViewStyle {
    var integerTextStyle: TextStyle
    var decimalTextStyle: TextStyle
    var decimalSeparatorTextStyle: TextStyle
    var currencyTextStyle: TextStyle
    var locale: Locale
    
    init(integerTextStyle: TextStyle,
         decimalTextStyle: TextStyle,
         decimalSeparatorTextStyle: TextStyle,
         currencyTextStyle: TextStyle,
         locale: Locale = NSLocale.current
    ) {
        self.integerTextStyle = integerTextStyle
        self.decimalTextStyle = decimalTextStyle
        self.decimalSeparatorTextStyle = decimalSeparatorTextStyle
        self.currencyTextStyle = currencyTextStyle
        self.locale = locale
    }
}

final class UIPriceView: UIView {
    
    public var price: Double = 0.0 {
        didSet {
            bind()
        }
    }
    
    public var style: PriceViewStyle = PriceViewStyle(
        integerTextStyle: TextStyle(size: 64, color: .black),
        decimalTextStyle: TextStyle(size: 16, color: .darkGray, baselineOffset: -20),
        decimalSeparatorTextStyle: TextStyle(size: 32, color: .darkGray, baselineOffset: -20),
        currencyTextStyle: TextStyle(size: 20, color: .black, baselineOffset: -25)
    )
    
    private lazy var currencyLabel = makeCurrencyLabel()
    private lazy var integerLabel = makeIntegerLabel()
    private lazy var decimalSeparatorLabel = makeDecimalLabel()
    private lazy var decimalLabel = makeDecimalLabel()
    
    private var priceData: PriceData {
        // Inject transformer? cake pattern?
        return PriceTransformer().transformedData(price: price, locale: style.locale)
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    private func setup() {
        [integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach {
            //$0.layer.borderWidth = 1.0
            //$0.layer.borderColor = UIColor.red.cgColor
            addSubview($0)
        }
        bind()
        setupConstraints()
    }
    
    private func bind() {
        // computed property didSet?
        
        let formatter = PriceFormatter()
        
        integerLabel.text = formatter.string(from: NSNumber(value: priceData.integerPart))
        decimalLabel.text = "\(priceData.decimalPart)"
        decimalSeparatorLabel.text = "\(priceData.decimalSeparator)"
        currencyLabel.text = priceData.currencySymbol
    }
    
    private func setupConstraints() {
        [integerLabel, decimalSeparatorLabel, decimalLabel, currencyLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let viewMargins = self.layoutMarginsGuide
        
        let currencyBefore = false
        let currencyAfter = !currencyBefore

        currencyLabel.lastBaselineAnchor.constraint(equalTo: integerLabel.lastBaselineAnchor, constant: style.currencyTextStyle.baselineOffset).isActive = true

        // before
        currencyLabel.leadingAnchor.constraint(equalTo: viewMargins.leadingAnchor, constant: 0).isActive = currencyBefore
        currencyLabel.trailingAnchor.constraint(equalTo: integerLabel.leadingAnchor, constant: 0).isActive = currencyBefore
        decimalLabel.trailingAnchor.constraint(equalTo: viewMargins.trailingAnchor, constant: 0).isActive = currencyBefore
        
        //after
        currencyLabel.trailingAnchor.constraint(equalTo: viewMargins.trailingAnchor, constant: 0).isActive = currencyAfter
        currencyLabel.leadingAnchor.constraint(equalTo: decimalLabel.trailingAnchor, constant: 0).isActive = currencyAfter
        integerLabel.leadingAnchor.constraint(equalTo: viewMargins.leadingAnchor, constant: 0).isActive = currencyAfter
        
        
        integerLabel.topAnchor.constraint(equalTo: viewMargins.topAnchor, constant: 0).isActive = true
        integerLabel.bottomAnchor.constraint(equalTo: viewMargins.bottomAnchor, constant: 0).isActive = true
        decimalSeparatorLabel.leadingAnchor.constraint(equalTo: integerLabel.trailingAnchor, constant: 0).isActive = true
        decimalSeparatorLabel.lastBaselineAnchor.constraint(equalTo: integerLabel.lastBaselineAnchor, constant: style.decimalSeparatorTextStyle.baselineOffset).isActive = true
        decimalLabel.leadingAnchor.constraint(equalTo: decimalSeparatorLabel.trailingAnchor, constant: 0).isActive = true
        decimalLabel.lastBaselineAnchor.constraint(equalTo: integerLabel.lastBaselineAnchor, constant: style.decimalTextStyle.baselineOffset).isActive = true
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
        return label
    }
}

struct PriceData {
    let currencySymbol: String
    let decimalSeparator: String
    let integerPart: Int64
    let decimalPart: Int64
    let locale: Locale
}

struct PriceTransformer {
    func transformedData(price: Double, locale: Locale = NSLocale.current) -> PriceData {
        // error handling
        let decimalSeparator = locale.decimalSeparator!
        let splittedPrice = String(price).split(separator: Character(decimalSeparator))
        let integerPart = Int64(splittedPrice[0])!
        let decimalPart = Int64(splittedPrice[1])!
        
        return PriceData(currencySymbol: locale.currencySymbol!, decimalSeparator: decimalSeparator, integerPart: integerPart, decimalPart: decimalPart, locale: locale)
    }
}

final class PriceFormatter: NumberFormatter {
    override init() {
        super.init()
        groupingSeparator = ","
        numberStyle = .decimal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("--")
    }
}

final class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let priceView = UIPriceView()
        view.addSubview(priceView)
        
        priceView.translatesAutoresizingMaskIntoConstraints = false

        let margin = view.layoutMarginsGuide
        
        priceView.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true
        priceView.centerYAnchor.constraint(equalTo: margin.centerYAnchor).isActive = true

        priceView.price = 1512.49

        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
