//
//  AppCoordinator.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 17.06.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController? { get }
    
    func start()
}

final class AppCoordinator: Coordinator {
    private weak var mainWindow: UIWindow?
    private var navigationController: UINavigationController?
    
    var rootViewController: UIViewController? {
        return mainWindow?.rootViewController
    }
    
    var currentCoordinators: [Coordinator] = []
//
    init(_ window: UIWindow) {
        let navcontroller = UINavigationController()
        window.rootViewController = navcontroller
        self.mainWindow = window
        self.navigationController = navcontroller
        window.makeKeyAndVisible()
    }
    
    // MARK: Coordinator
    
    func start() {
        let fileCoordinator = FileViewCoordinator(navigationController!)
        fileCoordinator.start()
        currentCoordinators.append(fileCoordinator)
    }
    
}

