//
//  HBNumberFormatting.h
//  HBNumberFormatting
//
//  Created by Hayk Brsoyan on 6/18/17.
//  Copyright © 2017 Hayk Brsoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBPhoneNumberFormatter : NSObject

@property (nonatomic) BOOL isShake;
@property (nonatomic) CGFloat shakeSize;
@property (nonatomic) CGFloat shakeDuration;
@property (nonatomic) CGFloat shakeRepeatCount;

// Create formatter and setup your custom formatting, like this @"(111) 1233-222"
- (instancetype)initWithFormatting:(NSString *)formatting;

// Call this method from your uiviewcontroller <UITextFieldDelegate> similar method.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

// Set Contry code Prefix
- (void)setCountryName:(NSString *)name textField:(UITextField *)textField;

// You can check your formatting is valid or not.
- (BOOL)numberIsValidPhoneText:(NSString *)phoneText;

@end
