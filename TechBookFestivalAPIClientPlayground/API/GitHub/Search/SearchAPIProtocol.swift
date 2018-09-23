//
//  SearchAPI.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import Foundation

import RxSwift

internal protocol SearchAPIProtocol {
	func repository(q: String) -> Observable<SearchAPIResponse<GitHubRepository>>
	func repository(q: String, pagination: Pagination) -> Observable<SearchAPIResponse<GitHubRepository>>
}

extension SearchAPIProtocol {
	func repository(q: String) -> Observable<SearchAPIResponse<GitHubRepository>> {
		return repository(q: q, pagination: .initial)
	}
}
