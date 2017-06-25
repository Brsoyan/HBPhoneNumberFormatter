//
//  HBNumberFormatting.m
//  HBNumberFormatting
//
//  Created by Hayk Brsoyan on 6/18/17.
//  Copyright © 2017 Hayk Brsoyan. All rights reserved.
//

#import "HBPhoneNumberFormatter.h"

@interface HBPhoneNumberFormatter ()

@property (nonatomic) NSDictionary *symbols;
@property (nonatomic) int numberCount;
@property (nonatomic) BOOL isDelete;
@end

@implementation HBPhoneNumberFormatter

- (instancetype)initWithFormatting:(NSString *)formatting {
    if(!(self = [super init])) {
        return nil;
    }
    
    // Default shake config
    self.isShake = YES;
    self.shakeDuration = 0.1;
    self.shakeRepeatCount = 2;
    self.shakeSize = 5;
    
    NSUInteger len = [formatting length];
    unichar buffer[len + 1];
    
    [formatting getCharacters:buffer range:NSMakeRange(0, len)];
    
    NSMutableDictionary *symbols = [[NSMutableDictionary alloc] init];
    for(int i = 0; i < len; i++) {
        NSString *character = [NSString stringWithFormat:@"%C", buffer[i]];
        if (![self isNumber:character]) {
            symbols[[@(i) stringValue]] = character;
        }
    }
    self.symbols = [symbols copy];
    self.numberCount = (int)([formatting length] - self.symbols.count);
    
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // typing symbol is number
    if (![self isNumber:string]) {
        [self shakeTextField:textField];
        return NO;
    }
    NSString *number = [self getNumber:textField.text];
    NSUInteger numberLength = number.length;
    if(numberLength == self.numberCount) {
        NSString *symbol = [self containSymbolForIndex:textField.text.length];
        if (symbol) {
            textField.text = [NSString stringWithFormat:@"%@%@", textField.text, symbol];
            symbol = [self containSymbolForIndex:textField.text.length];
            while (symbol) {
                textField.text = [NSString stringWithFormat:@"%@%@", textField.text, symbol];
                symbol = [self containSymbolForIndex:textField.text.length];
            }            
        }
        
        if (range.location == self.numberCount + self.symbols.count) {
            [self shakeTextField:textField];
        }
        if(range.length == 0) {
            return NO;
        }
    }
    
    // When added symbol in textField
    if (textField.text.length == range.location) {
        if (self.numberCount + self.symbols.count > textField.text.length) {
            if (!self.isDelete) {
                textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            }
            NSString *symbol = [self containSymbolForIndex:textField.text.length];
            if (symbol) {
                textField.text = [NSString stringWithFormat:@"%@%@", textField.text, symbol];
                symbol = [self containSymbolForIndex:textField.text.length];
                while (symbol) {
                    textField.text = [NSString stringWithFormat:@"%@%@", textField.text, symbol];
                    symbol = [self containSymbolForIndex:textField.text.length];
                }
            }

            if (self.isDelete) {
                textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            }
            self.isDelete = NO;
            return NO;
        }
        self.isDelete = NO;
        return NO;
    }
    
    // TextField is Empty
    if (textField.text.length == 0) {
        self.isDelete = NO;
        if (self.numberCount + self.symbols.count > textField.text.length) {
            NSString *symbol = [self containSymbolForIndex:0];
            if (symbol) {
                textField.text = [NSString stringWithFormat:@"%@", symbol];
                symbol = [self containSymbolForIndex:textField.text.length];
                while (symbol) {
                    textField.text = [NSString stringWithFormat:@"%@%@", textField.text, symbol];
                    symbol = [self containSymbolForIndex:textField.text.length];
                }
                
                textField.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
                symbol = [self containSymbolForIndex:textField.text.length];
                while (symbol) {
                    textField.text = [NSString stringWithFormat:@"%@%@", textField.text, symbol];
                    symbol = [self containSymbolForIndex:textField.text.length];
                }
                
                return NO;
            }
        }
        return NO;
    }
    
    // Delete text from textField
    if(range.length > 0) {
        self.isDelete = YES;
        if (textField.text.length == range.location) {
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        } else {
            textField.text = [textField.text substringToIndex:range.location];
        }
        NSString *symbol = [self containSymbolForIndex:textField.text.length - 1];
        if (symbol) {
            do {
                textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
                symbol = [self containSymbolForIndex:(textField.text.length - 1)];
            } while(symbol);
        }
        return NO;
    }
    return YES;
}

- (NSString *)containSymbolForIndex:(NSUInteger)index {
        for (NSString *key in self.symbols.allKeys) {
            if ([key isEqualToString:[@(index) stringValue]]) {
                return self.symbols[key];
            }
        }
    return nil;
}

- (NSString *)getNumber:(NSString *)mobileNumber {
    NSUInteger len = [mobileNumber length];
    unichar buffer[len + 1];
    [mobileNumber getCharacters:buffer range:NSMakeRange(0, len)];
    for(int i = 0; i < len; i++) {
        NSString *character = [NSString stringWithFormat:@"%C", buffer[i]];
        if (![self isNumber:character]) {
            mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:character withString:@""];
        }
    }
    return mobileNumber;
}

- (BOOL)isNumber:(NSString *)number {
    NSCharacterSet *digits = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return [number rangeOfCharacterFromSet:digits].location == NSNotFound;
}

- (BOOL)numberIsValidPhoneText:(NSString *)phoneText {
    int length = (int)[[self getNumber:phoneText] length];
    NSString *text = [self getNumber:phoneText];
    if (length == self.numberCount && [self isNumber:text]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)shakeTextField:(UITextField *)textField {
    if (self.isShake) {
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
        [shake setDuration:self.shakeDuration];
        [shake setRepeatCount:self.shakeRepeatCount];
        [shake setAutoreverses:YES];
        [shake setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake(textField.center.x - self.shakeSize,textField.center.y)]];
        [shake setToValue:[NSValue valueWithCGPoint:
                           CGPointMake(textField.center.x + self.shakeSize, textField.center.y)]];
        [textField.layer addAnimation:shake forKey:@"position"];
    }
}

@end
