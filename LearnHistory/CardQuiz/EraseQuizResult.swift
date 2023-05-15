//
//  EraseQuizResult.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-05-11.
//

import SwiftUI

struct EraseQuizResult {
    
    static func erase(fetchRequest: FetchedResults<HistoricalEventDetail>, theme: String) {
       // @Environment(\.managedObjectContext) var moc
        
        for event in fetchRequest {
            event.numberOfBadAnswersQuiz = 0
            event.numberOfGoodAnswersQuiz = 0
        }
        
      //  try? moc.save()
    }
}
