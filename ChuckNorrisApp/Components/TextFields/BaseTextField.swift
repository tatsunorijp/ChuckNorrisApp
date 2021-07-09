//
//  BaseTextField.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 25/06/21.
//

import UIKit

class BaseTextField: UITextField {
    private static let defaultHeight: CGFloat = 44
    private static let halfHeight = defaultHeight / 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareLayout()
    }

    var padding: UIEdgeInsets {
        UIEdgeInsets(
            top: 0, left: BaseTextField.halfHeight, bottom: 0, right: BaseTextField.halfHeight
        )
    }

    func setLeftIcon(color: UIColor, icon: UIImage) {
        let imageView = UIImageView(frame: CGRect(
                                        x: 12, y: 0,
                                        width: 24, height: 24)
        )
        imageView.tintColor = color
        imageView.image = icon
        imageView.contentMode = .scaleAspectFit
        
        let contentView = UIView(frame: CGRect(
                                    x: 0, y: 0,
                                    width: 42, height: 24)
        )
        
        contentView.addSubview(imageView)
        
        leftViewMode = .always
        leftView = contentView
    }
    
    func prepareLayout() {}

}
