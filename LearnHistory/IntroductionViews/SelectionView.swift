//
//  QuizSelectionView.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-01-29.
//
import SwiftUI

struct SelectionView: View {
    @Environment(\.dismiss) private var dismiss
    let listOfThemes = Bundle.main.decodeJson([HistorySection].self, from:"ListTitle.json".localized)
    var selection: String
    @State private var progressionNumber = 0.0
    var body: some View {
        List{
            ForEach(listOfThemes) {section in
                if section.name.localized != "References".localized {
                    Section(header: SectionHeader(text:(section.name))){
                        ForEach(section.themes) {theme in
                            if selection == "StudyView" {
                                NavigationLink(destination: StudyView(selectedTheme: theme.themeTitle)) {
                                    LineView(themeText: theme.themeTitle, fromQuiz: false)
                                }
                            }else if selection == "TimeLinesDetailView"{
                                NavigationLink(destination: TimeLinesDetailView(selectedTheme: theme.themeTitle)) {
                                    LineView(themeText: theme.themeTitle, fromQuiz: false)
                                }
                            }
                        }
                    }
                    .listRowBackground(ColorReference.lightGreen)
                }
            }
        }
        .preferredColorScheme(.dark)
        .navigationTitle("History themes")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            dismiss()
        }){
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .padding()
        })
    }
}

struct QuizSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(selection: "MutipleChoiceQuiz")
    }
}


