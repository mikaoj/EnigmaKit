Pod::Spec.new do |s|
  s.name             = "EnigmaKit"
  s.version          = "0.1.0"
  s.summary          = "Enigma encryption in Swift."
  s.description      = <<-DESC
  Enigma encryption/decryption in Swift.
                       DESC

  s.homepage         = "https://github.com/mikaoj/EnigmaKit"
  s.license          = 'MIT'
  s.author           = { "Joakim Gyllström" => "joakim@backslashed.se" }
  s.source           = { :git => "https://github.com/mikaoj/EnigmaKit.git", :tag => s.version.to_s }

  s.requires_arc = true
  
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  
  s.source_files = 'Pod/Classes/**/*'
end
