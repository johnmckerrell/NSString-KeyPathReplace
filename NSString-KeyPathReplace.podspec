#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NSString-KeyPathReplace"
  s.version          = "0.1.0"
  s.summary          = "Simple Objective C NSString category for replacing key path references with values from a dictionary."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  A simple NSString cateogory that gives you the ability to interpolate values
  into a string taken from a given NSDictionary. It also allows you to specify
  default values to be used if the dictionary does not contain a value for a
  keypath. Default values can be provided inline with the keypath or in a
  separate dictionary.
                       DESC

  s.homepage         = "https://github.com/johnmckerrell/NSString-KeyPathReplace"
  s.license          = 'MIT'
  s.author           = { "John McKerrell" => "john@mckerrell.net" }
  s.source           = { :git => "https://github.com/johnmckerrell/NSString-KeyPathReplace.git", :tag => s.version.to_s }

  s.source_files = 'NSString-KeyPathReplace/*'

  s.dependency 'RegexKitLite', '~> 4.0'
end
