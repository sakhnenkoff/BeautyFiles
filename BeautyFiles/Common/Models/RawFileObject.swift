//
//  FileObject.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 18.06.2022.
//

import Foundation
import UIKit

enum itemType: String {
    case file = "f"
    case directory = "d"
    case mainDir = "md"
}

struct FileObject {
    let id: UUID
    let itemType: String
    var name: String
}

extension FileObject: Equatable {
    static func == (lhs: FileObject, rhs: FileObject) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: RawFileObject

struct RawFileObject {
    let id: UUID
    let parentId: UUID?
    let itemType: String
    var name: String
}

extension RawFileObject {
    init?(with csvRow: [String]) {
        guard let id = UUID(uuidString: csvRow[0]) else { return nil }
        self.id = id
        self.parentId = UUID(uuidString: csvRow[1])
        self.itemType = csvRow[2]
        self.name = csvRow[3]
    }
}

extension RawFileObject: Equatable {
    static func == (lhs: RawFileObject, rhs: RawFileObject) -> Bool {
        lhs.id == rhs.id
    }
}
