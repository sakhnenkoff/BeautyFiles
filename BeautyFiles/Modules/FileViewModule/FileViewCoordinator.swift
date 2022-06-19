//
//  FileViewCoordinator.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 17.06.2022.
//

import Foundation
import UIKit

final class FileViewCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    var rootViewController: UIViewController? {
        navigationController.viewControllers.first
    }
    
    var input: FileViewModel?
        
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Coordinating
    
    func start() {
        let vc: FileViewController = .instantiate(storyboard: .main)
        let vm = FileViewModel(self)
        self.input = vm
        vc.viewModel = vm
        
        print(vc)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    deinit {
        print("\(self) deinit")
    }
}

