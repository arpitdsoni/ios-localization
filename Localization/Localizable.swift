//
//  Localizable.swift
//  LocalizationExample
//
//  Created by Arpit Soni on 7/24/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import Foundation

public protocol Localizable {
    var fileName: String { get }
    var provider: ProviderType { get }
    var localized: String { get }
    var directory: String? { get }
}

public extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var provider: ProviderType {
        return .json
    }
    
    var localized: String {
        return rawValue.localize(fileName: fileName, inDirectory: directory, provider: provider)
    }
    
    func localize(arguments: [CVarArg]) -> String {
        return rawValue.localize(fileName: fileName, inDirectory: directory, provider: provider, arguments: arguments)
    }
    
    var directory: String? {
        return nil
    }
}
