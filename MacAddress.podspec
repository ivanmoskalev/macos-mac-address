Pod::Spec.new do |s|
  s.name             = 'MacAddress'
  s.version          = '1.2.0'
  s.summary          = 'Obtain the device\'s MAC address on macOS that is compatible with Mac App Store\'s receipt validation.'

  s.description      = <<-DESC
MacAddress is a lightweight Swift microlibrary for macOS that provides an easy way to obtain the MAC address of a device's network interface. This library is especially useful when working with Mac App Store receipt validation, as it implements the Apple's recommended fallback strategy (en0 builtin → en1 builtin → en0 non-builtin).
                       DESC

  s.homepage         = 'https://github.com/ivanmoskalev/macos-mac-address'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ivan Moskalev' => 'ivan.moskalev@gmail.com' }
  s.source           = { :git => 'https://github.com/ivanmoskalev/macos-mac-address.git', :tag => s.version.to_s }

  s.swift_version         = '5.3'
  s.osx.deployment_target = '10.13'
  s.source_files          = 'Sources/MacAddress/*'
  s.requires_arc          = true
end
