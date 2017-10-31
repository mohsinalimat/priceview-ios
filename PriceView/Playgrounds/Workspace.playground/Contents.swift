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
        return label
    }()
    
    private var integerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    private var decimalSeparatorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var decimalLabel: UILabel = {
        let label = UILabel()
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
            addSubview($0)
        }
        bind()
    }
    
    private func bind() {
        // computed property didSet?
        integerLabel.text = "\(priceData.integerPart)"
        decimalLabel.text = "\(priceData.decimalPart)"
        decimalSeparatorLabel.text = "\(priceData.decimalSeparator)"
        print("BIND")
        layout()
    }
    
    private func layout() {
        let integerLabelSize = size(of: integerLabel)
        let decimalSeparatorLabelSize = size(of: decimalSeparatorLabel)
        let decimalLabelSize = size(of: decimalLabel)

        integerLabel.frame = CGRect(origin: .zero, size: integerLabelSize)
        decimalSeparatorLabel.frame = CGRect(origin: CGPoint(x: integerLabel.frame.maxX, y: 0), size: decimalSeparatorLabelSize)
        decimalLabel.frame = CGRect(origin: CGPoint(x: decimalSeparatorLabel.frame.maxX, y: 10), size: decimalLabelSize)
    }
    
    private func size(of label: UILabel) -> CGSize {
        guard let text = label.text else {
            return .zero
        }
        
        return text.size(withAttributes: [.font: label.font])
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
        priceView.frame = CGRect(x: 150, y: 200, width: 200, height: 50)
        priceView.price = 1512124564657.49
        view.addSubview(priceView)
        
        
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 250, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
