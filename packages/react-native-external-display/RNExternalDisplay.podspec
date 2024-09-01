require 'json'
pkg = JSON.parse(File.read('./package.json'))

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

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
  s.source_files = "ios/**/*.{h,m,mm}"
  s.requires_arc = true

  if defined? install_modules_dependencies
    install_modules_dependencies(s)
  else
    s.dependency 'React-Core'
  end

end

  