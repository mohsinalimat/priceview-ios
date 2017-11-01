//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

final class UIPriceView: UIView {
    
    public var price: Double = 0.0 {
        didSet {
            bind()
        }
    }
    public var locale: Locale = NSLocale.current
    
    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    private var integerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.baselineAdjustment = .none
        label.font = UIFont.boldSystemFont(ofSize: 44)
        return label
    }()

    private var decimalSeparatorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    private var decimalLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.baselineAdjustment = .none
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    private var priceData: PriceData {
        // Inject transformer? cake pattern?
        return PriceTransformer().transformedData(price: price, locale: locale)
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
        [integerLabel, decimalSeparatorLabel, decimalLabel].forEach {
            //$0.layer.borderWidth = 1.0
            //$0.layer.borderColor = UIColor.red.cgColor
            addSubview($0)
        }
        bind()
        setupConstraints()
    }
    
    private func bind() {
        // computed property didSet?
        integerLabel.text = "\(priceData.integerPart)"
        decimalLabel.text = "\(priceData.decimalPart)"
        decimalSeparatorLabel.text = "\(priceData.decimalSeparator)"
    }
    
    private func setupConstraints() {
        
        integerLabel.translatesAutoresizingMaskIntoConstraints = false
        decimalSeparatorLabel.translatesAutoresizingMaskIntoConstraints = false
        decimalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let viewMargins = self.layoutMarginsGuide
        let integerLabelMargins = integerLabel.layoutMarginsGuide
        let decimalSeparatorLabelMargins = decimalSeparatorLabel.layoutMarginsGuide
        let decimalLabelMargins = decimalLabel.layoutMarginsGuide
        
        integerLabel.leadingAnchor.constraint(equalTo: viewMargins.leadingAnchor, constant: 0).isActive = true
        integerLabel.topAnchor.constraint(equalTo: viewMargins.topAnchor, constant: 0).isActive = true
        integerLabel.bottomAnchor.constraint(equalTo: viewMargins.bottomAnchor, constant: 0).isActive = true
        decimalSeparatorLabel.leadingAnchor.constraint(equalTo: integerLabelMargins.trailingAnchor, constant: 8).isActive = true
        decimalSeparatorLabel.lastBaselineAnchor.constraint(equalTo: integerLabel.lastBaselineAnchor).isActive = true
        decimalLabel.leadingAnchor.constraint(equalTo: decimalSeparatorLabelMargins.trailingAnchor, constant: 8).isActive = true
        decimalLabel.lastBaselineAnchor.constraint(equalTo: integerLabel.lastBaselineAnchor).isActive = true
        decimalLabel.trailingAnchor.constraint(equalTo: viewMargins.trailingAnchor, constant: 0).isActive = true
    }
}

struct PriceData {
    let currencySymbol: String
    let decimalSeparator: String
    let integerPart: Int64
    let decimalPart: Int64
}

struct PriceTransformer {
    func transformedData(price: Double, locale: Locale = NSLocale.current) -> PriceData {
        // error handling
        print(price)
        let decimalSeparator = locale.decimalSeparator!
        let splittedPrice = String(price).split(separator: Character(decimalSeparator))
        let integerPart = Int64(splittedPrice[0])!
        let decimalPart = Int64(splittedPrice[1])!
        
        return PriceData(currencySymbol: locale.currencySymbol!, decimalSeparator: decimalSeparator, integerPart: integerPart, decimalPart: decimalPart)
    }
}

let ptransf = PriceTransformer()
let data = ptransf.transformedData(price: 12.12)
let data2 = ptransf.transformedData(price: 151212456465447.49)
print(data)
print(data2)

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
