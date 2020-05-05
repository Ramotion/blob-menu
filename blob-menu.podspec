Pod::Spec.new do |s|
  s.name         = 'blob-menu'
  s.version      = '1.0.0'
  s.summary      = 'SwiftUI menu control.'
  s.homepage     = 'https://github.com/Ramotion/garland-view'
  s.license      = 'MIT'
  s.authors = { 'Igor Kolpachkov' => 'igor.k@ramotion.agency' }
  s.ios.deployment_target = '13.4'
  s.source       = { :git => 'https://github.com/Ramotion/blob-menu.git', :tag => s.version.to_s }
  s.source_files  = 'Sources/*.swift'
end
