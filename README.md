# HBPhoneNumberFormatter

[![CI Status](http://img.shields.io/travis/HaykBrsoyan/HBPhoneNumberFormatter.svg?style=flat)](https://travis-ci.org/HaykBrsoyan/HBPhoneNumberFormatter)
[![Version](https://img.shields.io/cocoapods/v/HBPhoneNumberFormatter.svg?style=flat)](http://cocoapods.org/pods/HBPhoneNumberFormatter)
[![License](https://img.shields.io/cocoapods/l/HBPhoneNumberFormatter.svg?style=flat)](http://cocoapods.org/pods/HBPhoneNumberFormatter)
[![Platform](https://img.shields.io/cocoapods/p/HBPhoneNumberFormatter.svg?style=flat)](http://cocoapods.org/pods/HBPhoneNumberFormatter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

- #import <HBPhoneNumberFormatter/HBPhoneNumberFormatter.h>

You can set your custom formatting like @"(123) 1234:123" or @"123-123-12:12"
``` [[HBPhoneNumberFormatter alloc] initWithFormatting:@"(111) 1111-111"] ```

- In your ViewController conform to protocol <UITextFieldDelegate>. 
Override this method
```
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //check textField
    if ([textField isEqual:self.phoneField]) {
    	HBPhoneNumberFormatter *formatter = [[HBPhoneNumberFormatter alloc] initWithFormatting:@"(111) 1111-111"];
        return [formatter textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
```
- If you need change or disable animation.
HBPhoneNumberFormatter object have this properties you can change it 
``` 
	isShake, (default == YES)
	shakeSize, (default == 5)
	shakeDuration, (default == 0.1)
	shakeRepeatCount, (default == 2)
```

Example` 
``` 
HBPhoneNumberFormatter *formatter = [[HBPhoneNumberFormatter alloc] initWithFormatting:@"(111) 1111-111"];
formatter.shakeSize = 10;
formatter.shakeRepeatCount = 4; 
```
PhoneNumberTextField automatically formats phone numbers and gives the user full editing capabilities.
![alt text](https://github.com/Brsoyan/HBPhoneNumberFormatter/blob/master/app.gif)

You can check your textField validation ```- (BOOL)numberIsValidPhoneText:(NSString *)phoneText;```

## Installation

HBPhoneNumberFormatter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HBPhoneNumberFormatter”, ‘~> 1.0’
```
## Author

HaykBrsoyan, haykbrsoyan@gmail.com

## License

HBPhoneNumberFormatter is available under the MIT license. See the LICENSE file for more info.
# HBPhoneNumberFormatter
