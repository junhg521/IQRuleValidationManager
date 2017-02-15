Pod::Spec.new do |s|
  s.name         = "IQRuleValidation"
  s.version      = "0.0.1"
  s.summary      = "IQRuleValidation manager UITextField/UITextView input text validations rules"
  s.description  = <<-DESC
                    A short description of IQRuleValidation,IQRuleValidation manager UITextField/UITextView validations rules, you don't implement UITextField Delegate or UITextView delegate method just set UITextField proprty which you can attend the same result
                    DESC
  s.homepage     = "https://github.com/junhg521/IQRuleValidationManager"
  s.license      = "MIT"
  s.author       = { "JunHg" => "wujun-5543473@163.com" }
  s.source       = { :git => "https://github.com/junhg521/IQRuleValidationManager.git", :tag => "0.0.1" }
  s.source_files  = "IQRuleValidation/**/*.{h,m}"
  s.exclude_files = "IQRuleValidation/Exclude"
  s.public_header_files = "IQRuleValidation/**/*.h"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.frameworks   = "UIKit","Foundation"
end
