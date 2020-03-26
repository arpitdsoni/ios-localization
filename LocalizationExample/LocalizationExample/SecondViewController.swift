//
//  SecondViewController.swift
//  LocalizationExample
//
//  Created by Arpit Soni on 7/23/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import UIKit
import Localization

class SecondViewController: UIViewController {
    
    @IBOutlet weak var changeLangBtn: UIButton!
    
    enum Strings: String, Localizable {
        
        case changeLangBtn = "change_lang_button"
        case languages = "languages"
        
        var fileName: String {
            return "Localizable"
        }
        
        var provider: ProviderType {
            return .strings
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLangBtn.setTitle(Strings.changeLangBtn.localized, for: .normal)
        changeLangBtn.isEnabled = false
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: Strings.languages.localized, preferredStyle: UIAlertController.Style.actionSheet)
        for language in Localize.shared.availableLanguages {
            let displayName = Localize.shared.displayNameForLanguage(language)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.changeToLanguage(language)
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    private func changeToLanguage(_ langCode: String) {
        if Bundle.main.preferredLocalizations.first != langCode {
            let message = "In order to change the language, the App must be closed and reopened by you."
            let confirmAlertCtrl = UIAlertController(title: "App restart required", message: message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Close now", style: .destructive) { _ in
//                Localize.shared.update(language: langCode)
                exit(EXIT_SUCCESS)
            }
            confirmAlertCtrl.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            confirmAlertCtrl.addAction(cancelAction)
            
            present(confirmAlertCtrl, animated: true, completion: nil)
        }
    }
}

