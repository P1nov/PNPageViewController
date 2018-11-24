Pod::Spec.new do |s|
  s.name         = "PNPageController"
  s.homepage     = "https://github.com/P1nov/PNPageViewController"
  s.summary      = "PageCintroller on iOS."
  s.authors      = { "P1nov" => "1473781785@qq.com" }
  s.version      = "1.0.1"
  s.source       = { :git => "https://github.com/P1nov/PNPageViewController.git", :tag => s.version }
  s.platform     = :ios, '9.0'
  s.requires_arc = false
  s.license      = 'MIT'
  s.source_files = 'PNSegmentedControl/*.{h,m}'
  s.frameworks = 'Masonry'
end
