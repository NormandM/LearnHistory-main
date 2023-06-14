//
//  SelectionMultipleChoiceView.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-07-25.
//

import SwiftUI
import AVFoundation

struct SelectionMultipleChoiceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var historicalEventDetail: FetchedResults<HistoricalEventDetail>
    var listOfThemes = Bundle.main.decodeJson([HistorySection].self, from:"List.json".localized)
    var listOfTitleThemes = Bundle.main.decodeJson([HistorySection].self, from:"ListTitle.json".localized)
    @FetchRequest(sortDescriptors: []) var historicalSectionForSpecialEffect: FetchedResults<HistoricalSectionForSpecialEffect>
    @State private var finishedNumberOfThemes = 0
    @State private var showParticleEffect = false
    @State private var sectionNameForParticleEffect = ""
    @State private var referencesSectionIndex: Int?
    var soundPlayer = SoundPlayer.shared
    var body: some View {
        VStack {
            if showParticleEffect {
                ZStack {
                    ParticleEffectView()
                        .transition(.asymmetric(insertion: .slide, removal: AnyTransition.opacity.animation(.linear(duration: 3.0))))
                        .navigationBarBackButtonHidden(true)
                        .onAppear{
                            soundPlayer.playSound(soundName: "Acoustic Trio", type: "wav", soundState: nil)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                                withAnimation {
                                    showParticleEffect = false
                                    for section in historicalSectionForSpecialEffect{
                                        if section.isFinished && !section.effectTriggered{
                                            section.effectTriggered = true
                                            try?moc.save()
                                        }
                                    }
                                    
                                }
                            }
                        }
                    VStack {
                        Text("Congratulation you have mastered:")
                            .foregroundColor(.white)
                        Text(sectionNameForParticleEffect)
                            .foregroundColor(ColorReference.lightGreen)
                            .fontWeight(.bold)
                            .padding()
                        Text("10 coins were added to your total")
                            .italic()
                            .fontWeight(.bold)
                            .font(.callout)
                            .foregroundColor(ColorReference.orange)
                    }
                    .preferredColorScheme(.light)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    
                }
            }else{
                List{
                    ForEach(listOfTitleThemes.indices, id: \.self) {index in
                        let section = listOfTitleThemes[index]
                        Section(header: SectionHeader(text: section.name)){
                            ForEach(section.themes) {theme in
                                ExpandableRow(themeTitle: theme.themeTitle)
                            }
                            .listRowBackground(referencesSectionIndex == index ? ColorReference.orange : ColorReference.lightGreen)
                            .onAppear{
                                if section.name.localized == "References".localized{
                                    referencesSectionIndex = index
                                }
                            }
                        }
                        .foregroundColor(.black)
                    }
                    .onAppear{
                        referencesSectionIndex = nil
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
        .onAppear {
            for section in historicalSectionForSpecialEffect {
                if section.isFinished && !section.effectTriggered {
                    showParticleEffect = true
                    sectionNameForParticleEffect = section.wrappedThemeTitle
                }
            }
        }
    }
}


struct SelectionMultipleChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionMultipleChoiceView()
    }
}



