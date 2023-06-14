//
//  SectionHeader.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-02-12.
//

import SwiftUI

struct SectionHeader: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
                .fontWeight(.bold)
                .frame(height: 40,alignment: .leading)
                .background(Color.black)
                .foregroundColor(Color.white)
        }
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(text: "Texttutututututuutututuututuutgggg")
    }
}
