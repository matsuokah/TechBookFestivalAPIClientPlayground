//
//  Observable+Concurrent.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import Foundation

import RxSwift

/// SchedulerManager
fileprivate class SchedulerManager {
	static let shared = SchedulerManager()

	lazy var scheduler: ImmediateSchedulerType = {
		let operationQueue = OperationQueue()
		operationQueue.qualityOfService = QualityOfService.userInitiated
		operationQueue.maxConcurrentOperationCount = 4

		return OperationQueueScheduler(operationQueue: operationQueue)
	}()
}

// MARK: - Observable
public extension Observable {
	/// 並列スレッドで購読します
	///
	/// - Returns: observable
	public func subscribeOnConcurrent() -> Observable {
		return subscribeOn(SchedulerManager.shared.scheduler)
	}

	/// メインスレッドで監視します
	///
	/// - Returns: observable
	public func observeOnMain() -> Observable {
		return observeOn(MainScheduler.instance)
	}
}
