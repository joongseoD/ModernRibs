//
//  File.swift
//  
//
//  Created by Damor on 2021/11/30.
//

import UIKit

public enum DismissButtonType {
    case back, close
    
    public var iconSystemName: String {
        switch self {
        case .back: return "chevron.backward"
        case .close: return "xmark"
        }
    }
}

