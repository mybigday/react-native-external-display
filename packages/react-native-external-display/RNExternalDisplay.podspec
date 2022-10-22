require 'json'
pkg = JSON.parse(File.read('./package.json'))

Pod::Spec.new do |s|
  s.name         = "RNExternalDisplay"
  s.version      = pkg["version"]
  s.summary      = pkg["description"]
  s.homepage     = pkg["homepage"]
  s.license      = pkg["license"]
  s.author       = pkg["author"]
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "10.0"
  s.source       = { :git => pkg["repository"], :tag => "master" }
  s.source_files = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React-Core"

end

  