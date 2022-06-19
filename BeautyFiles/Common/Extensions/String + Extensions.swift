//
//  String + Extensions.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 17.06.2022.
//

import Foundation

extension String {
       func capitalizingFirstLetter() -> String {
           return prefix(1).capitalized + dropFirst()
       }

       mutating func capitalizeFirstLetter() {
           self = self.capitalizingFirstLetter()
       }
}
