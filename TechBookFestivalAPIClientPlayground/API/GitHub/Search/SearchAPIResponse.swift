//
//  SearchAPIResponse.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import Foundation

/// 検索結果
internal struct SearchAPIResponse<Response: Decodable>: Decodable {
	internal let totalCount: Int
	internal let incompleteResults: Bool
	internal let items: [Response]
}
