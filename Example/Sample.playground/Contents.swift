//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import PriceView

final class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let integerTextStyle = TextStyle(size: 20, color: .black, kern: 0.0, verticalAlignment: .middle(0))
        let decimalTextStyle = TextStyle(size: 10, color: .gray, kern: 0.0, verticalAlignment: .top(2))
        let currencyTextStyle = TextStyle(size: 12, color: .black, kern: 0.0, verticalAlignment: .middle(0))
        let separatorTextStyle = TextStyle(size: 10, color: .gray, kern: 0.0, verticalAlignment: .top(2))
    let locale = Locale(identifier: "fr_FR")
        
        let style = PriceViewStyle(integerTextStyle: integerTextStyle,
                                   decimalTextStyle: decimalTextStyle,
                                   decimalSeparatorTextStyle: separatorTextStyle,
                                   currencyTextStyle: currencyTextStyle,
                                   decimalSeparatorSpacing: (0,0),
                                   currencySpacing: 10,
                                   verticalAlignment: .middle,
                                    locale: locale)
        let priceView = UIPriceView(style: style)
        view.addSubview(priceView)

        let margin = view.layoutMarginsGuide
        
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true
        priceView.centerYAnchor.constraint(equalTo: margin.centerYAnchor).isActive = true
//        priceView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        priceView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        priceView.price = 16516512.00955
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
