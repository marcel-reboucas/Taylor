//
//  CapricesExtensions.swift
//  Caprices
//
//  Created by Alex Culeva on 10/30/15.
//  Copyright © 2015 yopeso.dmitriicelpan. All rights reserved.
//

import Foundation

let defaultErrorDictionary = [ResultDictionaryErrorKey : [String.Empty]]

extension Int {
    var isEven: Bool { return self % 2 == 0 }
    var isOdd: Bool { return self % 2 == 1 }
}

extension Dictionary where Key: Hashable {
    mutating func setIfNotExist(value: Value, forKey key: Key) {
        if self[key] == nil { self[key] = value }
    }
}

extension Dictionary where Key: Hashable, Value: Summable {
    mutating func add(value: Value, toKey key: Key) {
        if self[key] == nil { self[key] = value }
        else { self[key]! = self[key]! + value }
    }
}


protocol Summable {
    func +(lhs: Self, rhs: Self) -> Self
}

extension Array: Summable  { }
extension Int: Summable { }
extension String: Summable { }

extension Array {
    var second: Element? { return self.count > 1 ? self[1] : nil }
}

extension Array where Element: StringType {
    
    var containFlags: Bool {
        return self.count == 2 && Flags.contains(String(self[1]))
    }
    
}

extension NSFileManager {
    func isDirectory(path: String) -> Bool {
        var isDirectory = ObjCBool(false)
        self.fileExistsAtPath(path, isDirectory: &isDirectory)
        return Bool(isDirectory)
    }
}
