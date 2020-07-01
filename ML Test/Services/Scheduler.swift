//
//  Scheduler.swift
//  ML Test
//
//  Created by Emiliano on 6/30/20.
//

import Foundation

final class Scheduler {
    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()
    static let mainScheduler = RunLoop.main
}
