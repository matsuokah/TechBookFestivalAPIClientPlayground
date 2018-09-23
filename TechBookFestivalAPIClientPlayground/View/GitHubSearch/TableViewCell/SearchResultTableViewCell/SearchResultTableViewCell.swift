//
//  SearchResultTableViewCell.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
	func setData(data: GitHubRepository) {
		self.textLabel?.text = data.fullName
	}
}

extension SearchResultTableViewCell: NibRegistrable { }
