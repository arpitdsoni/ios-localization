//
//  String+Ext.swift
//  LocalizationExample
//
//  Created by Arpit Soni on 7/23/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import Foundation

public extension String {
    
    func localize(fileName: String, inDirectory directory: String?) -> String {
        return Localize.shared.localize(key: self, fileName: fileName, inDirectory: directory)
    }
    
    func localize(fileName: String, inDirectory directory: String?, provider: ProviderType) -> String {
        return Localize.shared.localize(key: self, fileName: fileName, inDirectory: directory, provider: provider)
    }
    
    func localize(fileName: String, inDirectory directory: String?, provider: ProviderType, arguments: [CVarArg]) -> String {
        return Localize.shared.localize(key: self, fileName: fileName, inDirectory: directory, provider: provider, arguments: arguments)
    }
}
