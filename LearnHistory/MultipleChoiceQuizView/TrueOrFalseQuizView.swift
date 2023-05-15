//
//  TrueOrFalseQuizView.swift
//  FirstQuizTest
//
//  Created by Normand Martin on 2022-01-02.
//

import SwiftUI
import AVFoundation


struct TrueOrFalseQuizView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var isFlippedLeft: Bool
    @Binding var isFlippedRight: Bool
    @Binding var nextButtonIsVisible: Bool
    @Binding var questionSection: QuestionSection
    @Binding var hintButtonIsVisible: Bool
    var soundPlayer = SoundPlayer.shared
    var soundState: String
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State var selectedTheme: String
    @StateObject var questionViewModel: QuestionViewModel
    @Binding var hintDemanded: Bool
    @FetchRequest var fetchRequest: FetchedResults<HistoricalEventDetail>
    var body: some View {
        VStack{
            Spacer()
            Text(questionViewModel.trueOrFalseQuestion)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading)
                .padding(.trailing)
            Spacer()
            HStack() {
                FlipView(isFlipped: isFlippedRight) {
                    Button{
                        
                        if questionViewModel.trueOrFalseAnswer == "True".localized {
                            questionSection = .showCardView
                            soundPlayer.playSound(soundName: "chime_clickbell_octave_up", type: "mp3", soundState: soundState)
                        }else{
                            nextButtonIsVisible = true
                            for event in fetchRequest{
                                if event.wrappedId == questionViewModel.id {
                                    event.numberOfBadAnswersQuiz = event.numberOfBadAnswersQuiz + 1
                                    
                                }
                            }
                            try? moc.save()
                            if hintDemanded {
                                BadAnswer1.substract()
                            }else{
                                BadAnswer2.substract()
                            }
                            isFlippedRight = true
                            hintButtonIsVisible = false
                            soundPlayer.playSound(soundName: "etc_error_drum", type: "mp3", soundState: soundState)
                        }
                        hintDemanded = false
                    }label: {
                        QuizButtonTextModifier(buttonTitle: "True".localized, identifyButtonRightAnswer: false)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .opacity(isFlippedLeft == true ? 0 : 1)
        
                } back: {
                    ZStack {
                    QuizButtonTextModifier3(title: "")
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    
                }
                .animation(Animation.spring(response: 0.7, dampingFraction: 0.7), value: isFlippedRight)
                FlipView(isFlipped: isFlippedLeft) {
                    Button{
                        
                        if questionViewModel.trueOrFalseAnswer == "False".localized {
                            questionSection = .showCardView
                            soundPlayer.playSound(soundName: "chime_clickbell_octave_up", type: "mp3", soundState: soundState)
                        }else{
                            isFlippedLeft = true
                            nextButtonIsVisible = true
                            for event in fetchRequest{
                                if event.wrappedId == questionViewModel.id {
                                    event.numberOfBadAnswersQuiz = event.numberOfBadAnswersQuiz + 1
                                }
                            }
                            try? moc.save()
                            BadAnswer2.substract()
                            hintButtonIsVisible = false
                            soundPlayer.playSound(soundName: "etc_error_drum", type: "mp3", soundState: soundState)
                        }
                        hintDemanded = false
                    }label: {
                        QuizButtonTextModifier(buttonTitle: "False".localized, identifyButtonRightAnswer: false)
                    }
                    .opacity(isFlippedRight == true ? 0 : 1)
                    .padding(.leading)
                    .padding(.trailing)
                } back: {
                    QuizButtonTextModifier2(title: "", hintDemanded: hintDemanded)
                        .padding(.leading)
                        .padding(.trailing)
                }
                .animation(Animation.spring(response: 0.7, dampingFraction: 0.7), value: isFlippedLeft)
            }
        }
    }
}

//struct TrueOrFalseQuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrueOrFalseQuizView(isCardViewQuiz:.constant(false), isFlippedLeft: .constant(false), isFlippedRight: .constant(false), soundState: "speaker.slash", selectedTheme: "", questionViewModel: QuestionViewModel(allEvents: [Event(id: UUID(), date: "", question: "", correctTAnswer: "", incorrectAnswer1: "", incorrectAnswer2: "", incorrectAnswer3: "",wikiSearchWord: "",questionTrueOrFalse: "",trueOrFalseAnswer: "",timeLine: "")]))
//    }
//}
