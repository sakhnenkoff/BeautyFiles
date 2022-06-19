//
//  Bundle + Extensions.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 18.06.2022.
//

import Foundation

extension Bundle {
    enum FileExtensions: String {
        case txt
        case csv
    }
    
    func getFileUrl(for fileName: String, ext: FileExtensions) -> URL? {
        return self.url(forResource: fileName, withExtension: ext.rawValue)
    }
}
