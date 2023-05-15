//
//  AppInformationView.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-09-26.
//

import SwiftUI

struct AppInformationView: View {
    @Environment(\.dismiss) private var dismiss
    var theme: String
    var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    var deviceWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    var body: some View {
        ZStack {
            ColorReference.lightGreen
                .ignoresSafeArea()
            if theme == "What do you think?".localized{
                    VStack {
                        Spacer()
                        Image(systemName: "questionmark")
                            .resizable()
                            .frame(width: deviceHeight * 0.10, height: deviceHeight * 0.10)
                            .foregroundColor(ColorReference.darkGreen)
                            .scaledToFill()
                            .padding(.bottom)
                            .padding(.bottom)
                            .padding(.bottom)
                        Text("Help me improve Learn History. Tell me what you think of the app. Any suggestions? Any topics you'd like me to add?")
                            .foregroundColor(.black)
                            .font(Font.title)
                            .italic()
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(width: deviceHeight > deviceWidth ? deviceWidth * 0.85 : deviceWidth * 0.7)
                            .padding(.top)
                            .padding(.leading)
                            .padding(.trailing)
                        Button(action: {
                            ReviewHandler.requestReviewManually()
                        },
                               label: {
                            Text("Leave your comments here".localized)
                                .font(.title)
                        })
                        .padding()
                        Spacer()
                        Spacer()
                    }
                    .navigationTitle("What do you think?".localized)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action : {
                        dismiss()
                    }){
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                    })
            }else if theme == "Bibliography".localized{
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20){
                            Group {
                                Text("A History of Britain: Volume 1, Written by: Simon Schama")
                                Text("A History of Britain, Volume 2: The British Wars, 1603 - 1776, Written by: Simon Schama")
                                Text("A History of Britain: Volume 3, Written by: Simon Schama")
                                Text("A History of India, Written by: Michael H. Fisher , The Great Courses")
                                Text("A History of Russia: From Peter the Great to Gorbachev, Written by: Mark Steinberg , The Great Courses")
                                Text("Between the Rivers: The History of Mesopotamia , Written by: Alexis Q. Castor , The Great Courses")
                                Text("Big History: The Big Bang, Life on Earth, and the Rise of Humanity, Written by: David Christian , The Great Courses")
                                
                            }
                            Group{
                                Text("Europe: A History, Written by: Norman Davies")
                                Text("Foundations of Eastern Civilization, Written by: Craig G. Benjamin , The Great Courses")
                                Text("Heart of Europe: A History of the Holy Roman Empire, Written by: Peter H. Wilson")
                                Text("Histoire de France, de Clovis à Napoléon, Written by: Jacques Bainville")
                                Text("Histoire mondiale de la France, Written by: Patrick Boucheron")
                                Text("La grande histoire du monde, Written by: François Reynaert")
                                Text("Maya to Aztec: Ancient Mesoamerica Revealed, Written by: Edwin Barnhart , The Great Courses")
                                
                            }
                            Group{
                                Text("The Byzantine Empire, Written by: Charles Oman")
                                Text("The History of Ancient Egypt, Written by: Bob Brier , The Great Courses")
                                Text("The History of Spain: Land on a Crossroad, Written by: Joyce E. Salisbury , The Great Courses")
                                Text("The History of the United_States, 2nd Edition, Written by: The Great Courses , Allen C. Guelzo , Gary W. Gallagher , Patrick N. Allitt")
                                Text("The Ottoman Empire, Written by: Kenneth W. Harl , The Great Courses")
                                Text("Turning Points in Middle Eastern History, Written by: Eamonn Gearon , The Great Courses")
                                Text("Wikipedia: for all themes")
                            }


                        }
                        .foregroundColor(.black)
                        .padding()
                        .padding()
                        
                    }
                    .navigationTitle("Bibliography".localized)
                    .navigationBarTitleDisplayMode(.large)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action : {
                        dismiss()
                    }){
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                    })
                }

        }
        
    }
}

struct AppInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AppInformationView(theme: "Bibliography")
    }
}
