//
//  GitHubSearchViewModel.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import RxSwift
import RxCocoa

internal protocol GitHubSearchViewModelProtocol {
	var dataStream: Observable<[GitHubRepository]> { get }
	func search(q: String)
	func next()
	func hasNext() -> Bool
}

fileprivate enum AppendableLoadingStatus {
	case ready // 読み込み可能
	, loadingAll // 初回読み込み, 全更新
	, loadingAppend // 追加読み込み
	, tail // 読み込みなし

	var isLoading: Bool {
		switch self {
		case .loadingAll:
			return true
		case .loadingAppend:
			return true;
		default:
			return false
		}
	}
}

internal class GitHubSearchViewModel: GitHubSearchViewModelProtocol {
	var dataStream: Observable<[GitHubRepository]> {
		return searchResult.asObservable()
	}

	private let searchAPI: SearchAPIProtocol = SearchAPIStub()
	private let perPage: UInt
	private let searchResult: BehaviorRelay<[GitHubRepository]> = BehaviorRelay(value: [])
	private let loadingStatus: BehaviorRelay<AppendableLoadingStatus> = BehaviorRelay(value: AppendableLoadingStatus.ready)
	private let page: BehaviorRelay<UInt> = BehaviorRelay(value: 1)
	private let query: BehaviorRelay<String> = BehaviorRelay(value: "")
	let disposeBag = DisposeBag()

	init(perPage: UInt = 100) {
		self.perPage = perPage
		bind()
	}

	func search(q: String) {
		self.query.accept(q)
	}

	func next() {
		if hasNext() && !loadingStatus.value.isLoading {
			page.accept(page.value + 1)
		}
	}

	func hasNext() -> Bool {
		return loadingStatus.value == .ready
	}
}

extension GitHubSearchViewModel {
	func bind() {
		// 1. Queryが変わったら初期値に戻す
		query.asObservable()
			.map { _ -> UInt in 1 }
			.bind(to: page)
			.disposed(by: disposeBag)

		query.asObservable()
			.map { _ -> [GitHubRepository] in [] }
			.bind(to: searchResult)
			.disposed(by: disposeBag)

		// ページ情報を作成する
		let perPage = self.perPage
		let pageObservable = self.page.asObservable()
			.distinctUntilChanged()
			.map { page -> Pagination in
				return Pagination(page: page, perPage: perPage)
		}

		// ページ切り替わり時にロード状態にする
		self.page
			.map { page -> AppendableLoadingStatus in
				return page > 1 ? .loadingAppend : .loadingAll
			}
			.bind(to: self.loadingStatus)
			.disposed(by: disposeBag)

		// 検索ストリーム
		// クエリとページの切り替わりを監視します
		let loading = Observable
			.combineLatest(query.asObservable().skipEmpty(), pageObservable.asObservable())
			.throttle(0.3, latest: true, scheduler: MainScheduler.instance)
			.flatMapLatest { [weak self] q, p -> Observable<[GitHubRepository]> in
				guard let `self` = self else { return .empty() }
				return self.searchAPI.repository(q: q, pagination: p).map { $0.items }
			}
			.subscribeOnConcurrent()

		// 検索結果
		loading
			.observeOnMain()
			.subscribe(onNext: { [weak self] result in
				guard let `self` = self else { return }
				// 結果を連結する
				self.searchResult.accept(self.searchResult.value + result)
			})
			.disposed(by: disposeBag)

		// ロードのステータス
		loading
			.map { result -> AppendableLoadingStatus in
				// 結果が0であればこれ以上の読み込みはナシ
				return result.isEmpty ? .tail : .ready
			}
			.subscribe(onNext: { [weak self] status in
				self?.loadingStatus.accept(status)
			})
			.disposed(by: disposeBag)
	}
}
