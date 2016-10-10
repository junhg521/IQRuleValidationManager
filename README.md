#IQRuleValidationManager使用说明
> 该文档主要描述IQRuleValidationManager在开发中使用说明

## UITextField、UITextView常规验证
验证UITextField、UITextView的输入时，需要在实现的方法中实现UItextView的delegate方法

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	BOOL validate = NO;
	//验证条件
	return Validate;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	BOOL validate = NO;
	//验证条件
	return Validate;
}
```
如果模块中较多的使用UITextField、UITextView，同时验证的内容可能大部分相同，比如：长度限制、数字限时、小数点限制等。

为了统一处理UITextField、UITextView的内容，使得验证的方法可以统管理，从而提出IQRuleValidationManager

## IQRuleValidationManager使用
使用UITextField、UITextView的实现文件中***必须遵循UItextViewDelegate/UITextFieldDelegate***，在**IQRuleExpression原理**中将会分析该规则，采用UITextField、UITextView的类别方法完成上述验证

```
@interface classA<UITextFieldDelegate>
@property(strong) UITextField *textField;

self.textField.ruleType = IQRuleValidationType中的一种类型
或使用
self.textField.ruleManagerClassName = @"自定义的规则名字";
```

## IQRuleValidationManager原理
IQRuleValidationManager主要采用swizzle技术对于**遵循ItextViewDelegate/UITextFieldDelegate**的类替换/添加相应的方法

未实现协议实现的原理图如下所示
![未实现协议的原理图](http://junhg521.github.io/JSSource/swizzle/swizzleInd.png)

实现协议实现的原理图如下所示
![实现协议的原理图](http://junhg521.github.io/JSSource/swizzle/swizzle.png)
### IQIndirectlyImplementProtocolManager
默认实现**UITextFieldDelegate/UITextViewDelegate**的方法，提供**遵循ItextViewDelegate/UITextFieldDelegate**的类为实现其协议方法时为其添加默认的实现方法，用于能够swizzle到相关的实现代码
### IQRuleValidationManager
实现UITextField/UITextView的具体规则，可以定义其基类，并实现IQRuleValidationManager协议

```
@protocol IQRuleValidationManager <NSObject>

@required
/**
 *  @brief  提供对应于IQRuleValidationType所处理的类名,继承的子类都必须提供该方法
 *
 *  @return 类名
 */
+ (nonnull NSString *)validationClassName;

@optional
/**
 *  @brief  提供对应于IQRuleValidationType所处理的正则表达式,继承的子类都必须提供该方法
 *
 *  @param type 定义的处理类型
 *
 *  @return 返回正则表达式字符串
 */
- (nonnull NSString *)regularExpressionWhenChanged;
/**
 *  @brief  提供对应于IQRuleValidationType所处理的正则表达式,继承的子类都必须提供该方法
 *
 *  @param type 定义的处理类型
 *
 *  @return 返回正则表达式字符串
 */
- (nonnull NSString *)regularExpressionWhileEndEditing;

@end
```
默认的IQRuleValidationManager类提供了目前项目中用到基本规则，主要定义在IQRuleValidationType中，该IQRuleValidationType的字段含义如下所示

```
typedef NS_ENUM(NSUInteger, IQRuleValidationType)
{
    IQRuleValidationNone = 0,
    IQRuleValidationPositive,                       // such as 1, 11,1111,11111
    IQRuleValidationPositiveWithTwoDecimalPoint, // such as 1.23, 11.23 111.23,1111.23
};
```


## IQRuleValidationManager缺陷
目前所用到的规则较少，暂代更新