Pod::Spec.new do |s|
  s.name         = "IQRuleValidationManager"
  s.version      = "0.0.1"
  s.summary      = "A short description of IQRuleValidationManager,IQRuleValidationManager manager UITextField/UITextView judgement method"
  s.description  = <<-DESC
                    IQRuleValidationManager manager UITextField/UITextView judgement method, you can use UITextField/UITextView property instand of it's protocol method
                    DESC
  s.homepage     = "https://github.com/junhg521/IQRuleValidationManager"
  s.license      = "MIT"
  s.author       = { "JunHg" => "wujun-5543473@163.com" }
  s.source       = { :git => "https://github.com/junhg521/IQRuleValidationManager.git", :tag => "0.0.1" }
  s.source_files  = "IQRuleValidationManager","IQRuleValidationManager/IQRuleExpression/**/*.{h,m}"
  s.exclude_files = "IQRuleValidationManager/IQRuleExpression/Exclude"
  s.public_header_files = "IQRuleValidationManager/IQRuleExpression/**/*.h"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.frameworks   = "UIKit"
end
