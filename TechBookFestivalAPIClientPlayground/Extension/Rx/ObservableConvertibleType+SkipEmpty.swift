//
//  Observable+SkipEmpty.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import RxSwift

extension ObservableConvertibleType where E: EmptyableProtocol {
	/// Emptyの場合はイベントを後続に伝搬させないストリームを作成します
	///
	/// - Returns: observable
	func skipEmpty() -> Observable<E> {
		return self.asObservable().filter { !$0.isEmpty }
	}
}

/// Emptyになりうることを示すプロトコルです
protocol EmptyableProtocol {
	var isEmpty: Bool { get }
}

extension String: EmptyableProtocol { }
