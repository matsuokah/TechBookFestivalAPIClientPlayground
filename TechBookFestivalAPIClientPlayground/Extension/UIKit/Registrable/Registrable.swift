//
//  Registrable.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import UIKit

// MARK: - Registrable
public protocol Registrable: class {
	static var reuseIdentifier: String { get }
}

// MARK: - Registrable
public extension Registrable {
	/// クラス名をCellのIdentifierとして使います。
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
}

// MARK: - ClassRegistrabne
public protocol ClassRegistrable: Registrable { }

// MARK: - ClassRegistrabne
public protocol NibRegistrable: Registrable {
	/// nibを生成して返します
	static var nib: UINib { get }
}

// MARK: - NibRegistrable
public extension NibRegistrable where Self: UIView {
	public static var nib: UINib {
		return Self.createNib()
	}
}
