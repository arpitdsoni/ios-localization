//
//  FirstViewController.swift
//  LocalizationExample
//
//  Created by Arpit Soni on 7/23/18.
//  Copyright © 2018 Arpit Soni. All rights reserved.
//

import UIKit
import ResearchKit
import Localization

class FirstViewController: UIViewController {
    
    @IBOutlet weak var big: UILabel!
    @IBOutlet weak var small: UILabel!
    @IBOutlet weak var plural: UILabel!
    @IBOutlet weak var survey: UIButton!
    @IBOutlet weak var log: UILabel!
    
    enum Strings: String, Localizable {
        case big = "big_text"
        case small = "level.one.two.three"
        
        var fileName: String {
            return "first_view"
        }
        
        var directory: String? {
            return "JSON"
        }
    }
    
    enum PluralStrings: String, Localizable {
        
        case plural = "pending_files_%d"
        
        var fileName: String {
            return "Localizable"
        }
        
        var provider: ProviderType {
            return .strings
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        log.text = """
        Available Languages: \(Localize.shared.availableLanguages)\n
        Preferred localizations: \(Localize.shared.preferredLocalizations)\n
        Preferred languages: \(Locale.preferredLanguages)\n
        Current Language: \(Localize.shared.currentLanguage)\n
        Apple Languages: \(UserDefaults.standard.array(forKey: "AppleLanguages") ?? [])
        """
//        NotificationCenter.default.addObserver(self, selector: #selector(localize), name: CurrentLangChangeNN, object: nil)
    }
    
    @objc func localize() {
        big.text = Strings.big.localize(arguments: ["Arpit", 17])
        small.text = Strings.small.localized
        plural.text = String(format: PluralStrings.plural.localized, 10)
    }
    
    @IBAction func surveyTapped(_ sender: Any) {
        var steps = [ORKStep]()
        
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "The Questions Three"
        instructionStep.text = "Who would cross the Bridge of Death must answer me these questions three, ere the other side they see."
        steps += [instructionStep]
        
        let dateAF = ORKDateAnswerFormat(style: .dateAndTime, defaultDate: nil, minimumDate: nil, maximumDate: nil, calendar: nil)
        let dateQS = ORKQuestionStep(identifier: "date", title: "Date", answer: dateAF)
        steps += [dateQS]
        
        let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
        nameAnswerFormat.multipleLines = false
        let nameQuestionStepTitle = "What is your name?"
        let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
        steps += [nameQuestionStep]
        
        let questQuestionStepTitle = "What is your quest?"
        let textChoices = [
            ORKTextChoice(text: "Create a ResearchKit App", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Seek the Holy Grail", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Find a shrubbery", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
        let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
        steps += [questQuestionStep]
        
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Right. Off you go!"
        summaryStep.text = "That was easy!"
        steps += [summaryStep]
        
        let task = ORKOrderedTask(identifier: "SurveyTask", steps: steps)
        let taskVC = ORKTaskViewController(task: task, taskRun: nil)
        taskVC.delegate = self
        self.present(taskVC, animated: true, completion: nil)
    }
}

extension FirstViewController: ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
