//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import PriceView

final class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let priceView = UIPriceView()
        view.addSubview(priceView)

        let margin = view.layoutMarginsGuide
        
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true
        priceView.centerYAnchor.constraint(equalTo: margin.centerYAnchor).isActive = true
        priceView.layer.borderColor = UIColor.green.cgColor
        priceView.layer.borderWidth = 1.0
        
        priceView.price = 12.84
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
