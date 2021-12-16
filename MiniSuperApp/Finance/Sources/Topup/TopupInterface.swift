//
//  File.swift
//  
//
//  Created by Damor on 2021/12/16.
//

import Foundation
import ModernRIBs

public protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> Routing
}

public protocol TopupListener: AnyObject {
    func topupDidClose()
    func topupDidFinish()
}
