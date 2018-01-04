//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import PriceView

final class MyViewController : UIViewController {
    let priceView1 = UIPriceView()
    let priceView2 = UIPriceView()
    let priceView3 = UIPriceView()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let integerTextStyle = TextStyle(size: 18, weight: .semibold, color: .black, verticalAlignment: .middle(0))
        let decimalTextStyle = TextStyle(size: 10, weight: .regular, color: .darkGray,  verticalAlignment: .top(4))
        let currencyTextStyle = TextStyle(size: 16, color: .black, verticalAlignment: .middle(0))
        let separatorTextStyle = TextStyle(size: 10, weight: .regular, color: .darkGray, verticalAlignment: .top(4))
        let locale = Locale(identifier: "en_GB")
        
        var style = Style(
            defaultTextStyle: TextStyle(size: 14, color: .darkGray, verticalAlignment: .middle(0)),
            layout: Layout(horizontalAlignment: .left, currencySpacing: 20),
            textStyles: .integer(TextStyle(size: 20, color: .black, verticalAlignment: .middle(0)))
        )

        priceView1.style = style
        priceView2.style = style
        priceView3.style = style
        
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()

        
        [priceView1, priceView2, priceView3, label1, label2, label3].forEach { view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let margin = view.layoutMarginsGuide

        label1.topAnchor.constraint(equalTo: margin.topAnchor, constant: 200).isActive = true
        label1.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        priceView1.topAnchor.constraint(equalTo: label1.topAnchor).isActive = true
        priceView1.lastBaselineAnchor.constraint(equalTo: label1.lastBaselineAnchor).isActive = true
        priceView1.leadingAnchor.constraint(equalTo: label1.trailingAnchor, constant: 20).isActive = true
        priceView1.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20).isActive = true

        label2.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        priceView2.topAnchor.constraint(equalTo: label2.topAnchor).isActive = true
        priceView2.lastBaselineAnchor.constraint(equalTo: label2.lastBaselineAnchor).isActive = true
        priceView2.leadingAnchor.constraint(equalTo: label2.trailingAnchor, constant: 20).isActive = true
        priceView2.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        
        label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20).isActive = true
        
        label3.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        priceView3.topAnchor.constraint(equalTo: label3.topAnchor).isActive = true
        priceView3.lastBaselineAnchor.constraint(equalTo: label3.lastBaselineAnchor).isActive = true
        priceView3.leadingAnchor.constraint(equalTo: label3.trailingAnchor, constant: 20).isActive = true
        priceView3.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true

        label1.text = "🇺🇸"
        label2.text = "🇫🇷"
        label3.text = "🇯🇵"
        priceView1.price = 1149.00
        priceView2.price = 1329.00
        priceView3.price = 129800
        
        let button = UIButton()
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .lightGray
        view.addSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        self.view = view
    }
    
    
    
    @objc func didTapButton() {
        print("TAPPED")
        priceView1.locale = Locale(identifier: "fr_FR")
//        priceView1.style = Style(defaultTextStyle: TextStyle(size: 14, color: .darkGray, verticalAlignment: .middle(0)), layout: Layout(), options: Options(locale: Locale(identifier: "en_GB")))
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


