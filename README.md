# priceview-ios
An user-friendly UI view to display a price or an amount

## Why?
We are displaying prices everywhere in our apps and I agree with [@frankrausch](https://twitter.com/frankrausch) it’s hard for users to read. Then why not being able to easily have a component that render it for us, doing formatting, styling, layout with just couple properties? 

Oh small tip you can use/pair with your designer on the sample playground to adjust the style and have it exactly how you wanted to be.

## Requirements
iOS 9.0+
Swift 4.0+

## Installation
### CocoaPods
To integrate PriceView into your Xcode project using CocoaPods, specify it in your Podfile:
```
target '<Your Target Name>' do
    pod 'PriceView'
end
```

Then, run the following command:
`$ pod install`

### Carthage
I plan to make PriceView available on Carthage soon as well.

## Usage
### Quick start

#### Default
```swift
import PriceView

final class ViewController: UIViewController {
	private lazy var priceView = UIPriceView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		priceView.price = 12.34
	}
}

```

#### Custom
If you don’t like the default behavior of PriceView, it’s fine, and it’s still simple to be used. 

This is the list of things available for customization:

* Layout
	* Vertical Alignment: The vertical alignment of text within the view
	* Horizontal Alignment: The text alignment within the view
	* Currency spacing: Spacing between the currency symbol and the price
	* Decimal separator spacing: Spacing leading and trailing the decimal separator.

* Options
	* Locale: The locale used for defining currency symbol, thousand grouping separator, decimal separator.
	* Fraction Digits: The exact number of decimal displayed.

* Default text style
	* The fallback text style used when declaring a `Style` with variadic parameters init (see TextStyles)

* TextStyles
	* A collection of specific text style either for the integer part, the decimal part, the currency symbol and the decimal separator. If the collection is not complete (have one of each) the default text style will be applied.

* TextStyle
	* Font: For custom cont or preferredFontSize
	* Size and Weight: Not recommended to set a defined size but still available
	* Kern
	* Vertical alignment

##### Examples

*Style with variadic text styles*
```swift
let style = Style(
            defaultTextStyle: TextStyle(size: 15, color: .gray, verticalAlignment: .bottom(0)),
            textStyles: .integer(TextStyle(size: 32, color: .black, verticalAlignment: .bottom(0)))
        )
```

*Style*
```swift
let style = Style(
            integerTextStyle: 
            TextStyle(size: 32, color: .black, verticalAlignment: .bottom(0)),
            decimalTextStyle:
            TextStyle(size: 15, color: .gray, verticalAlignment: .bottom(0)),
            decimalSeparatorTextStyle:
            TextStyle(size: 15, color: .gray, verticalAlignment: .bottom(0)),
            currencyTextStyle:
            TextStyle(size: 15, color: .gray, verticalAlignment: .bottom(0))
        )
```

## Credits

[UIKonf 2017 – Frank Rausch – Good Typography, Better Apps](https://youtu.be/YM2Nj691PMo)

## Licence

PriceView is released under the MIT license. [See LICENSE](https://github.com/thomas-sivilay/priceview-ios/blob/master/LICENSE) for details.
