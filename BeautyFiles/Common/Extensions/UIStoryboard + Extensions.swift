//
//  UIStoryboard + Extensions.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 17.06.2022.
//

import UIKit

enum Storyboard: String {
    case main
    
    var filename: String {
        return self.rawValue.capitalizingFirstLetter()
    }
}

extension UIStoryboard {
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }

    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateViewController<T>() -> T where T: StoryboardInstantiable {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        
        return viewController
    }
}

protocol StoryboardInstantiable {
    static var storyboardIdentifier: String { get }
}

