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

- (instancetype)initWithFormatting:(NSString *)formatting;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

// You can check your formatting is valid or not.
- (BOOL)numberIsValidPhoneText:(NSString *)phoneText;

@end
