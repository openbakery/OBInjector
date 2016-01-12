Pod::Spec.new do |spec|
  spec.name         = 'OBInjector'
  spec.version      = '1.1.2'
  spec.summary      = "A small and simple objective-c dependency injection framework"
  spec.homepage     = "https://github.com/openbakery/OBInjector"
  spec.author       = { "René Pirringer" => "rene@openbakery.org" }
  spec.social_media_url = 'https://twitter.com/rpirringer'
  spec.source       = { :git => "https://github.com/openbakery/OBInjector.git", :tag => spec.version.to_s }
  spec.platform = :ios
  spec.ios.deployment_target = '6.0'
  spec.license      = 'BSD'
  spec.requires_arc = true
  spec.source_files = ['Core/Source/*.{h,m}']
end
