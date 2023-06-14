//
//  ExpandableRow.swift
//  LearnHistory
//
//  Created by Normand Martin on 2023-05-16.
//

import SwiftUI

struct ExpandableRow: View {
    let themeTitle: String
    let detail = [String]()
    @FetchRequest(sortDescriptors: []) var historicalSectionForSpecialEffect: FetchedResults<HistoricalSectionForSpecialEffect>
    var listOfThemes = Bundle.main.decodeJson([HistorySection].self, from: "List.json".localized)
    @State private var isExpanded: Bool = false
    @State private var subitems = [String]()
    @State private var selectedTheme: String? // New
    @State private var subitemsCount = 0
    @State private var progressionNumber = 0.0
    @State private var countFinishedTheme = 0
    @State private var isFinished = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(themeTitle)
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            self.isExpanded.toggle()
                        }
                    }
                Spacer()
                if themeTitle.localized != "Additional Information".localized{
                    Image(systemName: "checkmark.seal")
                        .font(.largeTitle)
                        .frame(height: 40,alignment: .trailing)
                        .foregroundColor(selectThemeAndStatus(themeTitle: themeTitle.localized) ? ColorReference.red : ColorReference.lightGreen)
                    
                }
            }
            if isExpanded {
                ForEach(subitems, id: \.self) { subitem in
                    Group {
                        if themeTitle.localized == "Additional Information".localized {
                            NavigationLink(destination: AppInformationView(theme: selectedTheme ?? ""), tag: subitem, selection: $selectedTheme) {
                                LineView(themeText: subitem, fromQuiz: true)
                            }
                            .onTapGesture {
                                self.selectedTheme = subitem
                            }
                            
                        }else{
                            NavigationLink(destination: MultipleChoiceQuizView(selectedTheme: subitem, sectionName: themeTitle), tag: subitem, selection: $selectedTheme) {
                                LineView(themeText: subitem, fromQuiz: true)
                            }
                            .onTapGesture {
                                self.selectedTheme = subitem
                            }
                        }
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                }
            }
        }
        .onAppear {
            subitems = [String]()
            updateSubitems()
        }
    }
    
    private func updateSubitems() {
        for detail in listOfThemes {
            if detail.name == themeTitle {
                for item in detail.themes {
                    subitems.append(item.themeTitle)
                }
            }
        }
    }
    func selectThemeAndStatus(themeTitle: String) -> Bool{
        var itemIsFinished = false
        for item in historicalSectionForSpecialEffect {
            if item.wrappedThemeTitle == themeTitle {
                itemIsFinished = item.isFinished
            }
        }
        return itemIsFinished
    }
}
