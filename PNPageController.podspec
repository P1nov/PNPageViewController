Pod::Spec.new do |s|
  s.name         = "PNPageController"
  s.homepage     = "https://github.com/P1nov/PNPageViewController"
  s.summary      = "PageCintroller on iOS."
  s.author       = { "P1nov" => "1473781785@qq.com" }
  s.version      = "3.2.3"
  s.source       = { :git => "https://github.com/P1nov/PNPageViewController.git", :tag => "1.0.0" }
  s.platform     = :ios, '8.0'
  s.requires_arc = false
  s.license      = 'MIT'
  s.source_files = 'PNPageController/*.{h,m}'
end
