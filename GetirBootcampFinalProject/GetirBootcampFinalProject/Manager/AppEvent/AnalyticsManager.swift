//
//  AnalyticsManager.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 25.04.2024.
//

import Foundation
import Firebase

final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func logButtonTapEvent(buttonName: String?) {
        guard let buttonName = buttonName else { return }
        Analytics.logEvent(AnalyticsEventSelectContent,
                           parameters: [
                            AnalyticsParameterContent: buttonName,
                            "content_id": buttonName,
                            AnalyticsParameterContentType: "Button"
                           ])
    }
}
