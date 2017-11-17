Pod::Spec.new do |s|

  s.name         = "PriceView"
  s.version      = "0.1.2"
  s.summary      = "UIPriceView to display price with style."
  s.description  = "The missing UI component from UIKit, allows you to display a price or an amount in the currency format given the locale. Customizable or default text style."
  s.homepage     = "https://github.com/thomas-sivilay/priceview-ios"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Thomas Sivilay" => "thomas.sivilay@gmail.com" }
  s.social_media_url   = "https://twitter.com/thomassivilay"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/thomas-sivilay/priceview-ios.git", :tag => "#{s.version}" }
  s.source_files  = 'Source/**/*.{swift}'
  s.exclude_files = "Classes/Exclude"
  s.framework  = "UIKit"

end
