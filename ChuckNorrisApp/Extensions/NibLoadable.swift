//
//  NibLoadable.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 12/06/21.
//

import UIKit

protocol NibLoadable: AnyObject {}

extension NibLoadable where Self: UIView {
    static var nibBundle: Bundle {
        return Bundle(for: self)
    }

    static var nibName: String {
        return String(describing: self)
    }

    static func loadFromNib(withOwner owner: Any?) -> Self {
        guard let view = nibBundle.loadNibNamed(nibName, owner: owner, options: nil)?.first as? Self
        else {
            fatalError("Could not load nib named '\(nibName)'.")
        }
        return view
    }
}
