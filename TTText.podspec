

Pod::Spec.new do |spec|

  spec.name         = "TTText"
	
  spec.version      = "0.0.1"
	
  spec.summary      = "Swift 5 string interpolation - NSAttributedString"

  spec.description  = "Use string difference to achieve exactly the same effect as AttributedStrings, simplifying the creation of AttributedStrings"

  spec.homepage     = "https://github.com/temagit/TTText.git"

  spec.license      = { :type => "MIT" }

  spec.author       = { "tema.tian" => "temagsoft@163.com" }

  spec.source       = { :git => "https://github.com/temagit/TTText.git", :branch => 'master' }

  spec.platform     = :ios, "9.0"
	
  spec.ios.deployment_target = '9.0'

  spec.source_files = "Classes", "Classes/*.swift"
	

end
