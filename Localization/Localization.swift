//
//  Localization.swift
//  Nof1
//
//  Created by Arpit Soni on 7/23/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import Foundation

public let CurrentLangChangeNN = Notification.Name("CurrentLanguageChange")
public let CurrentLangKey = "CurrentLanguage"

protocol Localization {
    func localize(key: String, fileName: String, inDirectory directory: String?) -> String
}

extension Localization {
    var bundle: Bundle {
        return Bundle.main
    }
    
    var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    var defaultLanguage: String {
        return "en"
    }
    
    var currentLanguage: String {
        return bundle.preferredLocalizations.first ?? defaultLanguage
        //        get {
        //            if let lang = defaults.string(forKey: CurrentLangKey) {
        //                return lang
        //            }
        //            for preferredLang in Locale.preferredLanguages {
        //                var lang = preferredLang
        //                if availableLanguages.contains(preferredLang) {
        //                    return lang
        //                }
        //
        //                lang = preferredLang.components(separatedBy: "-")[0]
        //                if availableLanguages.contains(lang) {
        //                    return lang
        //                }
        //            }
        //            return defaultLanguage
        //        }
        //        set(newValue) {
        ////            defaults.setValue(newValue, forKey: CurrentLangKey)
        //            defaults.set([newValue], forKey: "AppleLanguages")
        //            defaults.synchronize()
        //            NotificationCenter.default.post(name: CurrentLangChangeNN, object: self)
        //        }
    }
    
    var availableLanguages: [String] {
        guard let languages = bundle.urls(forResourcesWithExtension: "lproj", subdirectory: "")?.map({ $0.deletingPathExtension().lastPathComponent }).filter({ $0 != "Base" }), !languages.isEmpty else {
            return [defaultLanguage]
        }
        return languages
    }
    
    func displayNameForLanguage(_ language: String) -> String {
        let locale = NSLocale(localeIdentifier: currentLanguage)
        if let name = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return name.capitalized
        }
        return ""
    }
}
