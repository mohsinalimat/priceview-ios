//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

final class UIPriceView: UIView {
    
    public var price: Float = 0.0 {
        didSet {
            bind()
        }
    }
    public var locale: Locale = NSLocale.current
    
    private var currencyLabel: UILabel = {
//        let label = UILabel()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        return label
    }()
    
    private var integerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        return label
    }()

    private var decimalSeparatorLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 5, height: 20))
        return label
    }()
    
    private var decimalLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 25, y: 0, width: 40, height: 20))
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
        [integerLabel, decimalSeparatorLabel, decimalLabel].forEach { addSubview($0) }
        setupConstraints()
        bind()
    }
    
    private func setupConstraints() {
        
    }
    
    private func bind() {
        // computed property didSet?
        integerLabel.text = "\(priceData.integerPart)"
        decimalLabel.text = "\(priceData.decimalPart)"
        decimalSeparatorLabel.text = "\(priceData.decimalSeparator)"
        print("BIND")
    }
}

struct PriceData {
    let currencySymbol: String
    let decimalSeparator: String
    let integerPart: Int
    let decimalPart: Int
}

struct PriceTransformer {
    func transformedData(price: Float, locale: Locale = NSLocale.current) -> PriceData {
        // error handling
        let decimalSeparator = locale.decimalSeparator!
        let splittedPrice = String(price).split(separator: Character(decimalSeparator))
        let integerPart = Int(splittedPrice[0])!
        let decimalPart = Int(splittedPrice[1])!
        
        return PriceData(currencySymbol: locale.currencySymbol!, decimalSeparator: decimalSeparator, integerPart: integerPart, decimalPart: decimalPart)
    }
}

let ptransf = PriceTransformer()
let data = ptransf.transformedData(price: 12.12)
let data2 = ptransf.transformedData(price: 12.1221231)
print(data)
print(data2)

final class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let priceView = UIPriceView()
        priceView.frame = CGRect(x: 150, y: 200, width: 200, height: 50)
        priceView.price = 17.49
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
