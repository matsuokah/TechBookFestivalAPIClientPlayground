//
//  UITableView+Registrable.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import UIKit

// MARK: - UITableView
public extension UITableView {
	// MARK: Public Methods
	/// UITableViewにRegistrableに準拠しているUITableViewCellを登録します
	///
	/// - Parameter registrableType: Registableに準拠しているUITableViewCell
	public func register<T: Registrable>(_ registrableType: T.Type) where T: UITableViewCell {
		switch registrableType {
		case let nibRegistrableType as NibRegistrable.Type:
			register(nibRegistrableType.nib, forCellReuseIdentifier: nibRegistrableType.reuseIdentifier)
		case let classRegistrableType as ClassRegistrable.Type:
			register(classRegistrableType, forCellReuseIdentifier: classRegistrableType.reuseIdentifier)
		default:
			assertionFailure("\(registrableType) is unknown type")
		}
	}

	/// Registrableに準拠しているUITableViewCellを取得します。
	///
	/// - Parameter indexPath: indexPath
	/// - Returns: セル
	public func dequeueReusableCell<T: Registrable>(for indexPath: IndexPath) -> T where T: UITableViewCell {
		guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with type \(T.self)")
		}
		return cell
	}
}

// MARK: - UITableView
public extension UITableView {
	// MARK: Public Methods
	/// UITableViewにRegistrableに準拠しているUITableViewHeaderFooterViewを登録します
	///
	/// - Parameter registrableType: Registableに準拠しているUITableViewHeaderFooterView
	public func register<T: Registrable>(_ registrableType: T.Type) where T: UITableViewHeaderFooterView {
		switch registrableType {
		case let nibRegistrableType as NibRegistrable.Type:
			register(nibRegistrableType.nib, forHeaderFooterViewReuseIdentifier: nibRegistrableType.reuseIdentifier)
		case let classRegistrableType as ClassRegistrable.Type:
			register(classRegistrableType, forHeaderFooterViewReuseIdentifier: classRegistrableType.reuseIdentifier)
		default:
			assertionFailure("\(registrableType) is unknown")
		}
	}

	/// Registrableに準拠しているUITableViewHeaderFooterViewを取得します。
	///
	/// - Parameter indexPath: indexPath
	/// - Returns: セル
	public func dequeueReusableHeaderFooterView<T: Registrable>() -> T where T: UITableViewHeaderFooterView {
		guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
			fatalError("Could not dequeue HeaderFooterView with type \(T.self)")
		}
		return view
	}
}
