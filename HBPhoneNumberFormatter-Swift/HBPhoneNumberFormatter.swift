//
//  HBPhoneNumberFormatter.swift
//  HBPhoneNumberFormatter
//
//  Created by Hovhannes Stepanyan on 6/11/18.
//

import UIKit

class HBPhoneNumberFormatter: NSObject {
    var isShake: Bool = true
    var shakeSize: CGFloat = 5.0
    var shakeDuration: CGFloat = 0.1
    var shakeRepeatCount: CGFloat = 2.0
    
    /// Create formatter and setup your custom formatting, like this @"(111) 1233-222"
    init(formatting: String) {
        super.init()
        let count = formatting.count
        var buffer = [unichar]()
        let _formatting = NSString(string: formatting)
        _formatting.getCharacters(&buffer, range: NSMakeRange(0, count))
        for char in buffer {
            let character = String(char)
            if !self.isNumber(character) {
                symbols[String(buffer.index(of: char)!)] = character
            }
        }
        self.numberCount = formatting.count - symbols.count
    }
    
    /// Call this method from your uiviewcontroller <UITextFieldDelegate> similar method.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !self.isNumber(string) {
            self.shake(textField: textField)
            return false
        }
        if range.length > 0 && self.prefix == textField.text {
            self.shake(textField: textField)
            return false
        }
        if range.length > 0 {
            self.isDelete = true
        } else {
            self.isDelete = false
        }
        let number = self.getNumber(textField.text)
        let numberCount = number.count
        if numberCount == self.numberCount {
            if var symbol = self.symbolFor(textField.text?.count) {
                textField.text = String(format: "%@%@", textField.text!, symbol)
                symbol = self.symbolFor(textField.text?.count)!
                self.add(symbol, in: textField)
            }
            if range.location == self.numberCount + self.symbols.count + self.prefix.count {
                self.shake(textField:textField)
            }
            if range.length == 0 {
                return false
            }
        }
        
        // TextField is Empty
        if textField.text?.count == self.prefix.count {
            if self.numberCount + self.symbols.count > (textField.text?.count ?? 0) {
                if var symbol = self.symbolFor(self.prefix.count) {
                    if textField.text?.count != 0 {
                        textField.text = String(format:"%@%@", textField.text! ,symbol)
                    } else {
                        textField.text = String(format:"%@" , symbol)
                    }
                    symbol = self.symbolFor(textField.text?.count)!
                    self.add(symbol, in: textField)
                    
                    textField.text = String(format:"%@%@", textField.text!, string)
                    symbol = self.symbolFor(textField.text?.count)!
                    self.add(symbol, in: textField)
                } else {
                    textField.text = String(format:"%@", string)
                    let symbol = self.symbolFor(textField.text?.count)!
                    self.add(symbol, in: textField)
                }
            }
            return false
        }
        
        // When added symbol in textField
        if textField.text?.count == range.location {
            if self.numberCount + self.symbols.count + self.prefix.count > (textField.text?.count ?? 0) {
                if var symbol = self.symbolFor(textField.text?.count) {
                    textField.text = String(format:"%@%@", textField.text!, symbol)
                    symbol = self.symbolFor(textField.text?.count)!
                    self.add(symbol, in: textField)
                }
                if !self.isDelete && (textField.text?.count ?? 0) > 0 {
                    textField.text = String(format:"%@%@", textField.text!, string)
                }
                if var symbol = self.symbolFor(textField.text?.count) {
                    textField.text = String(format:"%@%@", textField.text!, symbol)
                    symbol = self.symbolFor(textField.text?.count)!
                    self.add(symbol, in: textField)
                }
                
                if self.isDelete {
                    textField.text = String(format:"%@%@", textField.text!, string)
                }
                return false
            }
            return false
        }
        
        // Delete text from textField
        if range.length > 0 {
            if range.location >= self.prefix.count {
                if textField.text?.count == range.location {
                    textField.text = textField.text?.substring(to: (textField.text?.endIndex)!)
                } else {
                    textField.text = textField.text?.substring(to: String.Index.init(encodedOffset: range.location))
                }
                if var symbol = self.symbolFor((textField.text?.count)! - 1) {
                    while(true) {
                        textField.text = textField.text!.substring(to: (textField.text?.endIndex)!)
                        if let _symbol = self.symbolFor((textField.text?.count)! - 1) {
                            symbol = _symbol
                            break
                        }
                    }
                }
            } else {
                textField.text = textField.text!.substring(to: String.Index.init(encodedOffset: self.prefix.count))
            }
            
            return false
        }
        return true
    }
    
    /// Set Contry code Prefix
    func setCountryName(_ name: String, textField: UITextField) {
        guard let code = CountryCode.countryCodeWith(name: name) else {
            print("We dosn't finde %@ .HB Default prefix is United States", name)
            self.prefix = CountryCode.countryCodeWith(name: "United States")!
            textField.text = String(format: "%@", self.prefix)
            return
        }
        self.prefix = code
        textField.text = String(format: "%@", code)
    }
    
    /// You can check your formatting is valid or not.
    func numberIsValidPhoneText(_ phoneText: String) -> Bool {
        let text = self.getNumber(phoneText)
        let length = text.count ?? 0
        if length == self.numberCount && self.isNumber(text) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: Private API
    
    private var symbols: Dictionary<String, Any> = [String: Any]()
    private var numberCount: Int = 0
    private var isDelete: Bool = false
    private var prefix: String = ""
    
    private func isNumber(_ number: String) -> Bool {
        let digits = CharacterSet(charactersIn: "0123456789").inverted
        return NSString(string: number).rangeOfCharacter(from: digits).location == NSNotFound
    }
    
    private func shake(textField: UITextField) {
        if self.isShake {
            let shake = CABasicAnimation(keyPath:"position")
            shake.duration = CFTimeInterval(self.shakeDuration)
            shake.repeatCount = Float(self.shakeRepeatCount)
            shake.autoreverses = true
            shake.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - self.shakeSize, y: textField.center.y))
            shake.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + self.shakeSize, y: textField.center.y))
            textField.layer.add(shake, forKey:"position")
        }
    }
    
    private func getNumber(_ mobileNumber: String?) -> String {
        let len = mobileNumber?.count ?? 0
        var buffer = [unichar]()
        NSString(string: mobileNumber!).getCharacters(&buffer, range:NSMakeRange(0, len))
        var number = ""
        for i in self.prefix.count..<len {
            let character = String(format:"%C", buffer[i])
            if self.isNumber(character) {
                if number.count != 0 {
                    number = String(format:"%@%@", number, character)
                } else {
                    number = String(format:"%@", character)
                }
            }
        }
        return number;
    }
    
    private func symbolFor(_ index: Int?) -> String? {
        let _index = (index ?? 0) - self.prefix.count
        for key in self.symbols.keys {
            if key == String(_index) {
                return self.symbols[key] as? String;
            }
        }
        return nil
    }
    
    private func add(_ symbol: String, in textField: UITextField) {
        var _symbol = symbol
        while _symbol.count > 0 {
            textField.text = String(format:"%@%@", textField.text!, symbol)
            _symbol = self.symbolFor(textField.text?.count)!
        }
    }

}
