//
//  GitHubOwner.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

internal struct GitHubOwner: Decodable {
	internal let login: String
	internal let id: Int
	internal let avatarUrl: String
	internal let gravatarId: String
	internal let url: String
	internal let receivedEventsUrl: String
	internal let type: String
}
