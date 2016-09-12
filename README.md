# IQRuleValidationManager

> IQRuleValidationManager主要用于对用户输入验证

## 使用方法
一般验证UITextField、UITextView的输入时，需要实现UItextView的delegate方法

```
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	BOOL validate = NO;
	//验证条件
	return Validate;
}

```
实现UITextField的delegate方法

```
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL validate = NO;
	//验证条件
	return Validate;
}
 
```
一般如果多处都需要验证，则在cotnroller中需要写无数的delegate的方法，对此IQRuleValidationManager采用UITextField、UITextView的类别方法完成上述验证，在实现中是需要使用如下的方式即可完成普通的验证

```
UITextField *textField;
textField.delegate = self;
textField.ruleType = IQRuleValidationType中的一种类型
```
