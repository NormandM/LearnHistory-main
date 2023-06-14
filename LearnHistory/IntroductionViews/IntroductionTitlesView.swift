//
//  IntroductionTitles.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-01-30.
//

import SwiftUI
import StoreKit
struct IntroductionTitlesView: View {
    @State private var questionSection = QuestionSection.multipleChoiceQuestionNotAnswered
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var nextButtonIsVisible = false
    @State private var hintButtonIsVisible = false
    @State private var fromNoCoinsView = false
    var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    @State var showWelcome = false
    var body: some View {
        ZStack {
            ColorReference.darkGreen
            VStack {
                Image("H5")
                    .resizable()
                    .frame(width: deviceHeight * 0.15, height: deviceHeight * 0.15, alignment: .center)
                    .padding(.top)
                Text("Learn History")
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                    .foregroundColor(ColorReference.lightGreen)
                    .multilineTextAlignment(.center)
                VStack {
                    Spacer()
                    NavigationLink("Timelines") {
                        SelectionView(selection: "TimeLinesDetailView")
                        
                    }
                    .fontWeight(.bold)
                    .italic()
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .font(.headline)
                    
                    Text("Start here")
                        .font(.caption)
                        .foregroundColor(ColorReference.lightGreen)
                    Spacer()
                    NavigationLink("Study") {
                        SelectionView(selection: "StudyView")
                    }
                    .fontWeight(.bold)
                    .italic()
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .font(.headline)
                    Group {
                        Text("Read and learn")
                            .font(.caption)
                            .foregroundColor(ColorReference.lightGreen)
                        Spacer()
                        NavigationLink("Quiz") {
                            SelectionMultipleChoiceView()
                            
                        }
                        .fontWeight(.bold)
                        .italic()
                        .textCase(.uppercase)
                        .foregroundColor(.white)
                        .font(.headline)
                        Text("Test your knowledge")
                            .font(.caption)
                            .foregroundColor(ColorReference.lightGreen)
                        
                        Spacer()
                        NavigationLink("Manage your credits") {
                            CoinManagementView(questionSection: $questionSection, coins: $coins, nextButtonIsVisible: $nextButtonIsVisible, hintButtonIsVisible: $hintButtonIsVisible, fromNocoinsView: $fromNoCoinsView, lastQuizSection: .menuPage)
                        }
                        .fontWeight(.bold)
                        .italic()
                        .textCase(.uppercase)
                        .foregroundColor(.white)
                        .font(.headline)
                        
                    }
                }
                Spacer()
                
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            var numberOfOpen: Int = UserDefaults.standard.integer(forKey: "numberOfOpen")
            if numberOfOpen > 10 {
                SKStoreReviewController.requestReview()
                numberOfOpen = 0
                UserDefaults.standard.set(numberOfOpen, forKey: "numberOfOpen")
            }
            UserDefaults.standard.set(numberOfOpen + 1, forKey: "numberOfOpen")
            if !hasLaunchedBefore {
                self.showWelcome = true
                self.hasLaunchedBefore = true
            }
        }
        .alert(isPresented: $showWelcome) {
            Alert(title: Text("Welcome to the new version of LEARN HISTORY!".localized),
                  message: Text("New themes were added\nMIDDLE EAST\nByzantine Empire\nMuslim Empire\nOttoman Empire\n\nHave fun, more themes to come!".localized),
                  dismissButton: .default(Text("OK")))
        }
    }
}

//struct IntroductionTitles_Previews: PreviewProvider {
//    static var previews: some View {
//        IntroductionTitlesView(isQuizSelectionView: .constant(false), isTimeLineView: .constant(false), isViewStudy: .constant(false), isViewManageCredit: .constant(false), titleSelected: .constant(""))
//    }
//}
