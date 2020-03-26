//
//  LocalizationStrings.swift
//  LocalizationExample
//
//  Created by Arpit Soni on 7/23/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import Foundation

class LocalizationStrings: Localization {
    
    func localize(key: String, fileName: String, inDirectory directory: String? = nil) -> String {
        let error = "🔥 \(key)"
        return bundle.localizedString(forKey: key, value: error, table: fileName)
        
        // Note: Use this if lproj folders doesnt exist at root
//        if let path = bundle.path(forResource: currentLanguage, ofType: "lproj", inDirectory: appConfigDirName),
//            let bundle = Bundle(path: path) {
//            return bundle.localizedString(forKey: key, value: value, table: fileName)
//        }
//        return value
    }
}
