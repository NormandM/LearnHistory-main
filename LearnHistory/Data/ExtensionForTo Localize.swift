//
//  ExtensionForTo Localize.swift
//  LearnHistory
//
//  Created by Normand Martin on 2022-04-05.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
extension String {
    var separateFirstword: String{
        var n = 0
        let arraySeperate = self.components(separatedBy: " ")
        let count = arraySeperate.count
        var newString = String()
        switch count {
        case 1:
            newString = self
        case 6, 7,8,9:
            for item in arraySeperate {
                if n < 4{
                    newString = newString + " " + item
                }
                n = n + 1
            }
        default:
            for item in arraySeperate {
                if n == 0 {
                    newString = item
                }
                if count > 2 {
                    if n == 1 {
                      newString = newString + " " + item
                    }
                }
                n = n + 1
            }
        }
        return newString
    }
}
    extension String {

        var separateOtherWords: String {
            var n = 0
            let arraySeperate = self.components(separatedBy: " ")
            let count = arraySeperate.count
            var newString = String()
            switch count {
            case 1:
                newString = self
            case 2:
                newString = arraySeperate[1]
            case 6,7,8,9:
                for item in arraySeperate {
                    if n > 3 {
                        newString = newString + " " + item
                    }
                    n = n + 1
                }
                
            default:
                for item in arraySeperate {
                    if n > 1 {
                        newString = newString + " " + item
                    }
                    n = n + 1
                }
            }
            return newString
        }
    }
