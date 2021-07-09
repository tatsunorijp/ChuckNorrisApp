//
//  BaseButton.swift
//  BaseMVVM
//
//  Created by Tatsu on 26/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class BaseButton: UIButton {
    
    struct ButtonState {
        var state: UIControl.State?
        var title: String?
        var icon: UIImage?
    }
    
    let isLoading = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()
    
    private lazy var buttonState: ButtonState = {
        return ButtonState(state: state,
                           title: title(for: state),
                           icon: image(for: state))
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.titleColor(for: .normal)
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([xCenterConstraint, yCenterConstraint])
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isLoading.asDriver()
            .drive { shouldShowLoader in
                shouldShowLoader ? self.showLoading() : self.hideLoading()
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isLoading.asDriver()
            .skip(1)
            .drive { shouldShowLoader in
                shouldShowLoader ? self.showLoading() : self.hideLoading()
            }
            .disposed(by: disposeBag)
    }
    
    private func showLoading() {
        buttonState.title = self.title(for: .normal)
        buttonState.icon = self.image(for: .normal)
        
        setTitle("", for: .normal)
        setImage(nil, for: .normal)
        
        activityIndicator.startAnimating()
        isEnabled = false
    }
    
    private func hideLoading() {
        activityIndicator.stopAnimating()
        isEnabled = true
        setTitle(buttonState.title, for: .normal)
        setImage(buttonState.icon, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareLayout()
    }
    
    func prepareLayout() {}
    
}
