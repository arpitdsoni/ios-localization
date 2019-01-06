//
//  Localize.swift
//  Nof1
//
//  Created by Arpit Soni on 5/11/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import Foundation

public enum ProviderType {
    case json
    case strings
}

public class Localize {
    
    public static let shared = Localize()
    
    private let localizationStrings = LocalizationStrings()
    private let localizationJSON = LocalizationJSON()
    private var provider: Localization
    
    private init() {
        provider = localizationJSON
    }
    
    public var providerType = ProviderType.json {
        willSet(newValue) {
            switch newValue {
            case .strings:
                provider = localizationStrings
            case .json:
                provider = localizationJSON
            }
        }
    }
    
    public var availableLanguages: [String] {
        return provider.availableLanguages
    }
    
    public var currentLanguage: String {
        return provider.currentLanguage
    }
    
    public var preferredLocalizations: [String] {
        return provider.bundle.preferredLocalizations
    }
    
    public func localize(key: String, fileName: String, inDirectory directory: String?) -> String {
        return provider.localize(key: key, fileName: fileName, inDirectory: directory)
    }
    
    public func localize(key: String, fileName: String, inDirectory directory: String?, provider: ProviderType) -> String {
        switch provider {
        case .strings:
            return localizationStrings.localize(key: key, fileName: fileName)
        case .json:
            return localizationJSON.localize(key: key, fileName: fileName, inDirectory: directory)
        }
    }
    
    public func localize(key: String, fileName: String, inDirectory directory: String?, provider: ProviderType, arguments: [CVarArg]) -> String {
        let value = localize(key: key, fileName: fileName, inDirectory: directory, provider: provider)
        return String(format: value, arguments: arguments)
    }
    
    public func displayNameForLanguage(_ language: String) -> String {
        return provider.displayNameForLanguage(language)
    }
    
//    public func update(language: String) -> Void {
//        provider.currentLanguage = language
//    }
}

