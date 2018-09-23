//
//  GitHubSerachViewController.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

/// GitHub上でリポジトリをキーワード検索をする画面です
class GitHubSerachViewController: UIViewController {

	private let disposeBag = DisposeBag()

	@IBOutlet private weak var tableView: UITableView!
	private let searchViewModel: GitHubSearchViewModelProtocol = GitHubSearchViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(SearchResultTableViewCell.self)
		tableView.delegate = self

		bind()

		// 検索する
		searchViewModel.search(q: "Rx")
	}
}

// MARK: - GitHubSerachViewController Private Extension
private extension GitHubSerachViewController {
	private func bind() {
		// ViewModelのデータが変わったらTableViewをリロードする
		searchViewModel
			.dataStream
			.asObservable()
			.bind(to: tableView.rx.items(cellType: SearchResultTableViewCell.self)) { (row, element, cell) in
				cell.setData(data: element)
			}
			.disposed(by: disposeBag)
	}
}

// MARK: - GitHubSerachViewController/UITableViewDelegate
extension GitHubSerachViewController: UITableViewDelegate {
	// 追加読み込み
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if (scrollView.contentSize.height - scrollView.frame.size.height) < scrollView.contentOffset.y {
			searchViewModel.next()
		}
	}
}
