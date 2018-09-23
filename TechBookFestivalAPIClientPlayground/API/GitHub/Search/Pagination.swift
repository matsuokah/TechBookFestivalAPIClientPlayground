//
//  Pagination.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

struct Pagination {
	let page: UInt
	let perPage: UInt
}

extension Pagination {
	static let defaultPerPage: UInt = 100
	static let defaultPage: UInt = 1
	static let initial = Pagination.init(page: Pagination.defaultPage, perPage: Pagination.defaultPerPage)
}

extension Pagination {
	var query: String {
		return "per_page=\(perPage)&page=\(page)"
	}
}
