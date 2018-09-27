#
# Be sure to run `pod lib lint HBPhoneNumberFormatter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HBPhoneNumberFormatter'
  s.version          = '1.6'
  s.summary          = 'Framework for working with phone numbers'
  s.description      = <<-DESC
                       A Objective-C framework for create your custom formatting phone numbers.
                       DESC

  s.homepage         = 'https://github.com/Brsoyan/HBPhoneNumberFormatter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HaykBrsoyan' => 'haykbrsoyan@gmail.com' }
  s.source           = { 
                          :git => 'https://github.com/Brsoyan/HBPhoneNumberFormatter.git', 
                          :tag => s.version.to_s 
                       }

  s.ios.deployment_target = '9.0'

  s.source_files = 'HBPhoneNumberFormatter/Classes/**/*'
end
