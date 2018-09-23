//
//  SearchAPIStub.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import RxSwift

internal class SearchAPIStub: SearchAPIProtocol {
	func repository(q: String, pagination: Pagination) -> Observable<SearchAPIResponse<GitHubRepository>> {
		// NOTE リポジトリレイヤーから下が技術書典のメインイシューです
		return Observable.empty()
	}
}
