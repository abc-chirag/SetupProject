//
//  String+Extension.swift
//  Trichordal
//
//  Created by Sunil Zalavadiya on 16/01/19.
//  Copyright © 2019 Sunil Zalavadiya. All rights reserved.
//

import Foundation
import MobileCoreServices

extension String {
    func getUtf8Data() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }
    
    /// EZSE: Converts String to Int
    public func toInt() -> Int? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        if let num = numberFormatter.number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Double
    public func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        if let num = numberFormatter.number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    public func isAllDigits() -> Bool {
        
        print(self)
        
        let charcterSet  = NSCharacterSet(charactersIn: self).inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
    
    /// EZSE: Converts String to Float
    public func toFloat() -> Float? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        if let num = numberFormatter.number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Bool
    public func toBool() -> Bool? {
        return (self as NSString).boolValue
    }
    
    /// EZSE: Trims white space and new line characters
    public mutating func trim() {
        self = self.trimmed()
    }
    
    /// EZSE: Trims white space and new line characters, returns a new string
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&.*-~`\"'#()+,:;<>=^_{}\\]\\[])[A-Za-z\\d$@$!%*?&.*-~`\"'#()+,:;<>=^_{}\\]\\[]{8,}"//"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}"
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    func getDateWithFormate(formate: String, timezone: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = formate
        formatter.timeZone = TimeZone(abbreviation: timezone)
        
        return formatter.date(from: self)
    }
    
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func encodedUrlComponentString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func encodedUrlQueryString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func checkIfVideoAvailable() -> Bool {
        let arrExtension = ["mp4", "mp3", "mov"]
        
        let urlExtenstion = URL(fileURLWithPath: self).pathExtension
        
        for temp in arrExtension {
            if temp.lowercased() == urlExtenstion.lowercased() {
                return true
            }
        }
        return false
    }
}

extension String {
    func isImage() -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.lowercased() as CFString, nil)
        return UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeImage)
    }
    
    func isVideo() -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.lowercased() as CFString, nil)
        return UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeMovie)
    }
    
    func isImageMimeType() -> Bool {
        if let mimeUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, self as CFString, nil)?.takeUnretainedValue() {
            let extUTI = UTTypeCopyPreferredTagWithClass(mimeUTI, kUTTagClassFilenameExtension)
            if let fileExtension = extUTI?.takeRetainedValue() as String? {
                return fileExtension.isImage()
            }
        }
        return false
    }
    
    func isVideoMimeType() -> Bool {
        if let mimeUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, self as CFString, nil)?.takeUnretainedValue() {
            let extUTI = UTTypeCopyPreferredTagWithClass(mimeUTI, kUTTagClassFilenameExtension)
            if let fileExtension = extUTI?.takeRetainedValue() as String? {
                return fileExtension.isVideo()
            }
        }
        return false
    }
}

extension Data {
    /// Data to Hexadecimal String
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
}


extension String {
    func isAudio() -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.lowercased() as CFString, nil)
        return UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeAudio)
    }
    func isAudioMimeType() -> Bool {
        if let mimeUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, self as CFString, nil)?.takeUnretainedValue() {
            let extUTI = UTTypeCopyPreferredTagWithClass(mimeUTI, kUTTagClassFilenameExtension)
            if let fileExtension = extUTI?.takeRetainedValue() as String? {
                return fileExtension.isAudio()
            }
        }
        return false
    }
}


extension String {
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
