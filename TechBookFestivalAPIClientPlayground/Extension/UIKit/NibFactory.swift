//
//  NibFactory.swift
//  TechBookFestivalAPIClientPlayground
//
//  Created by Hideki Matsuoka on 2018/09/24.
//  Copyright © 2018年 matsuokah. All rights reserved.
//

import UIKit

// MARK: - NibFactory
public protocol NibFactory { }

// MARK: - NibFactory/UIViewController
public extension NibFactory where Self: UIViewController {
	// MARK: Public Methods
	public static func createWithNib() -> Self {
		return Self(nibName: String(describing: self), bundle: Bundle(for: self))
	}
}

// MARK: - NibFactory/UIView
public extension NibFactory where Self: UIView {
	// MARK: Public Methods
	public static func createNib() -> UINib {
		return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
	}

	public static func createWithNib() -> Self {
		return createNib().instantiate(withOwner: self, options: nil).first as! Self
	}
}


// MARK: - NibFactory/UIViewController
extension UIViewController: NibFactory { }

// MARK: - NibFactory/UIView
extension UIView: NibFactory { }
