Pod::Spec.new do |s|
  s.name             = 'TravelUI'
  s.version          = '2.0.0'
  s.summary          = 'An awesome framework to offer cool transport stuff to your users'
  s.description      = 'An awesome framework to offer cool transport stuff to your users  '
  s.homepage         = 'https://github.com/sicardf/TravelUI_iOS'
  s.license          = { :type => 'GPL-3', :file => 'LICENSE' }
  s.authors          = { 'Flavien SICARD' => 'flavien.sicard@gmail.com' }
  s.source           = { :git => 'https://github.com/sicardf/TravelUI_iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'TravelUI/Workers/**/*.{h,m,swift}', 'TravelUI/Framedation/**/*.{h,m,swift}', 'TravelUI/Scenes/**/*.{h,m,swift}', 'TravelUI/Lib/**/*.{h,m,swift}', 'TravelUI/*.{h,m,swift}'
  s.resources = 'TravelUI/Resources/**/*.*', 'TravelUI/Storyboard/**/*.*', 'TravelUI/Scenes/**/*.xib'
end
