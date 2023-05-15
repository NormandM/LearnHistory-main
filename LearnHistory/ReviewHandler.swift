//
//  ReviewHandler.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-09-28.
//

import Foundation
import StoreKit
import SwiftUI

struct UserDefaultKeys {
    static let appStartUpsCountKey = "appStartUpsCountKey"
}
struct UserDefaultsKeys {
    static let appStartUpsCountKey = "appStartUpsCountKey"
    static let lastVersionPromptedForReviewKey = "lastVersionPromptedForReviewKey"
}

class ReviewHandler {
    
//    static func requestReview() {
//        var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appStartUpsCountKey)
//        count += 1
//        UserDefaults.standard.set(count, forKey: UserDefaultsKeys.appStartUpsCountKey)
//        
//        let infoDictionaryKey = kCFBundleVersionKey as String
//        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
//            else { fatalError("Expected to find a bundle version in the info dictionary") }
//
//        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
//        
//        if count >= 4 && currentVersion != lastVersionPromptedForReview {
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
//                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
//                    SKStoreReviewController.requestReview(in: scene)
//                }
//            }
//        }
//    }
    static func requestReviewManually() {
      let url = "https://apps.apple.com/app/learn-history/id1629933572?action=write-review"
      guard let writeReviewURL = URL(string: url)
          else { fatalError("Expected a valid URL") }
      UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}
