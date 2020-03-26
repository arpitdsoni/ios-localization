//
//  LocalizationJSON.swift
//  Nof1
//
//  Created by Arpit Soni on 7/23/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import Foundation

fileprivate extension NSDictionary {
    
    static func parse(fromFile fileName: String, bundle: Bundle, language: String, inDirectory directory: String?) -> NSDictionary? {
        
        // Note: Use this if lproj folders doesnt exist at root
//        guard let bundlePath = bundle.path(forResource: language, ofType: "lproj", inDirectory: directory),
//            let bundle = Bundle(path: bundlePath),
//            let path = bundle.path(forResource: fileName, ofType: "json") else {
//            return nil
//        }
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json", subdirectory: directory) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            return dict
        } catch let error {
            print("cannot parse your json file: \(fileName) \nError: \(error.localizedDescription)")
        }
        return nil
    }
}

class LocalizationJSON: Localization {
    
    private func readJSON(fileName: String, inDirectory directory: String?) -> NSDictionary? {
        var lang = currentLanguage
        var dict = NSDictionary.parse(fromFile: fileName, bundle: bundle, language: lang, inDirectory: directory)
        
        if dict != nil {
            return dict
        }
        
        lang = currentLanguage.components(separatedBy: "-")[0]
        dict = NSDictionary.parse(fromFile: fileName, bundle: bundle, language: lang, inDirectory: directory)
        
        if dict != nil {
            return dict
        }
        
        return NSDictionary.parse(fromFile: fileName, bundle: bundle, language: defaultLanguage, inDirectory: directory)
    }
    
    func localize(key: String, fileName: String, inDirectory directory: String?) -> String {
        let error = "🔥 \(key)"
        
        guard let dict = readJSON(fileName: fileName, inDirectory: directory) else {
            return error
        }
        
        guard let value = dict.value(forKeyPath: key) as? String else {
            return error
        }
        
        return value
    }
}
