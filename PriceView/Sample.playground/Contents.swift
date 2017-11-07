//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import PriceView

final class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let integerTextStyle = TextStyle(size: 32, color: .black, kern: 0.0, verticalAlignment: .middle(0))
        let decimalTextStyle = TextStyle(size: 12, color: .black, kern: 0.0, verticalAlignment: .baseline(0))
        let currencyTextStyle = TextStyle(size: 12, color: .black, kern: 0.0, verticalAlignment: .middle(0))
        let separatorTextStyle = TextStyle(size: 32, color: .black, kern: 0.0, verticalAlignment: .middle(0))
        
        let style = PriceViewStyle(integerTextStyle: integerTextStyle, decimalTextStyle: decimalTextStyle, decimalSeparatorTextStyle: separatorTextStyle, currencyTextStyle: currencyTextStyle, decimalSeparatorSpacing: (0,0), currencySpacing: 10, alignment: .middle(0))
        let priceView = UIPriceView(style: style)
        view.addSubview(priceView)

        let margin = view.layoutMarginsGuide
        
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true
        priceView.centerYAnchor.constraint(equalTo: margin.centerYAnchor).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        priceView.layoutMargins = .init(top: 30, left: 30, bottom: 30, right: 30)
        priceView.layer.borderColor = UIColor.green.cgColor
        priceView.layer.borderWidth = 1.0
        
        priceView.price = 12.84
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
