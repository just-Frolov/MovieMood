//
//  BaseRouter.swift
//  MovieMood
//
//  Created by Danil Frolov on 15.10.2023.
//

import UIKit

class BaseRouter<Assembly> {
    
    weak var root: UIViewController!
    var assembly: Assembly!
    
    func inject(
        root: UIViewController,
        assembly: Assembly
    ) {
        self.root = root
        self.assembly = assembly
    }
}
