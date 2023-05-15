
//
//  Created by Normand Martin on 2021-11-07.
//

import SwiftUI
class QuestionViewModel: ObservableObject {
    @Published var buttonTitles = ["", "", "", ""]
    @Published var correctAnswer = String()
    @Published var wikiSearchWord = String()
    @Published var question = String()
    @Published var trueOrFalseQuestion = String()
    @Published var trueOrFalseAnswer = String()
    @Published var index = Int()
    @Published var id = UUID()
    @Published var indexOfQuestion = 0
    var arrayOfTitles = [String]()
    var arrayOfIndex = [Int]()
    var allEvents: [Event]
    
    init(allEvents: [Event]) {
        self.allEvents = allEvents
        initialize()
    }
    func increment() {
        var numberOfEvents = allEvents.count
        if indexOfQuestion == numberOfEvents - 1{
            numberOfEvents = 0
            indexOfQuestion = -1
        }
        indexOfQuestion += 1
        index = arrayOfIndex[indexOfQuestion]
        arrayOfTitles = [allEvents[index].correctTAnswer, allEvents[index].incorrectAnswer1, allEvents[index].incorrectAnswer2, allEvents[index].incorrectAnswer3]
        arrayOfTitles.shuffle()
        eventIdentification()
    }
    func initialize() {
        var numberOfEvents = allEvents.count
        arrayOfIndex = [Int]()
        if indexOfQuestion == numberOfEvents - 1{
            numberOfEvents = 0
            indexOfQuestion = 0
        }
        for n in 0...numberOfEvents - 1 {
            arrayOfIndex.append(n)
        }
        arrayOfIndex.shuffle()
        index = arrayOfIndex[indexOfQuestion]
        arrayOfTitles = [allEvents[index].correctTAnswer, allEvents[index].incorrectAnswer1, allEvents[index].incorrectAnswer2, allEvents[index].incorrectAnswer3]
        arrayOfTitles.shuffle()
    }
    func eventIdentification(){

        correctAnswer = allEvents[index].correctTAnswer
        buttonTitles[0] = arrayOfTitles[0]
        buttonTitles[1] = arrayOfTitles[1]
        buttonTitles[2] = arrayOfTitles[2]
        buttonTitles[3] = arrayOfTitles[3]
        wikiSearchWord = allEvents[index].wikiSearchWord
        question = allEvents[index].question
        trueOrFalseQuestion = allEvents[index].questionTrueOrFalse
        trueOrFalseAnswer = allEvents[index].trueOrFalseAnswer
        id = allEvents[index].id
    }
}

