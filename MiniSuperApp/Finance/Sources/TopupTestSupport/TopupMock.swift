//
//  File.swift
//  
//
//  Created by Damor on 2021/12/30.
//

import Foundation
import Topup

public final class TopupListenerMock: TopupListener {
  
  public var topupDidCloseCallCount = 0
  public func topupDidClose() {
    topupDidCloseCallCount += 1
  }
  
  public var topupDidFinishCallCount = 0
  public func topupDidFinish() {
    topupDidFinishCallCount += 1
  }
  
  public init() {
    
  }
  
}
