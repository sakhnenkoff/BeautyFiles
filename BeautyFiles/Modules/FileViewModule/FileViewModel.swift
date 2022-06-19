//
//  FileViewModel.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 17.06.2022.
//

import UIKit
import SwiftCSV

enum FileLoadingError: String, LocalizedError {
    case failedToLoadSpreadsheet
    case failedToGetURL
    
    var errorDescription: String? {
        switch self {
        case .failedToLoadSpreadsheet:
            return self.rawValue
        case .failedToGetURL:
            return self.rawValue
        }
    }
}

final class FileViewModel {
    var title: String {
        return "BeautyFiles"
    }

    private weak var coordinator: FileViewCoordinator?
    
    var fileTree: Node<RawFileObject>?

    init(_ coordinator: FileViewCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: Output
    
    func viewDidLoad() {
        do {
            try loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

// MARK: To-Do: Make separate service

private extension FileViewModel {
    func loadData() throws {
        guard let url = Bundle.main.getFileUrl(for: "fileList", ext: .csv) else {
            throw FileLoadingError.failedToGetURL }
            
        guard let spreadsheet = try? CSV(url: url) else {
            throw FileLoadingError.failedToLoadSpreadsheet
        }
        
        convertData(rawData: spreadsheet.enumeratedRows)
    }
    
    func convertData(rawData: [[String]]) {
        let allMappedItems = rawData.compactMap { RawFileObject(with: $0) }
        
        let fileTree = Node(RawFileObject(id: UUID(), parentId: nil, itemType: "mainDir", name: "Main Directory"))
        
        fileTree.children = allMappedItems.compactMap { item -> Node<RawFileObject>? in
            var childs: [RawFileObject] = []
            
            for nested in allMappedItems {
                if nested.parentId == item.id {
                    childs.append(nested)
                }
            }
            
            guard childs.count > 1 else { return nil }
            return Node(item, children: childs.map { Node($0) })
        }
        let toAppend = allMappedItems.filter { $0.parentId == nil && $0.itemType != "d" }.map { Node($0) }
        
        fileTree.children.append(contentsOf: toAppend)
        self.fileTree = fileTree
    }
}
