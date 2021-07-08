//
//  BaseViewController.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 12/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    private let viewModel: BaseViewModelType?
    private let router: BaseRouting?
    
    let disposeBag = DisposeBag()
    let error: PublishSubject<Error> = PublishSubject()
    let isLoading = BehaviorRelay(value: true)
    
    private var internalScrollView: UIScrollView?
    private lazy var loadingViewController = createLoadingViewController()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        let interactor = BaseInteractor()
        viewModel = BaseViewModel(interactor: interactor)
        router = BaseRouter()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DeInit: \(self.description)")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        prepare()
        bindViewModel()
        configureNavigationBar()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func prepare() {}
    
    func bindViewModel() {
        isLoading.asDriver()
            .skip(1)
            .drive(onNext: { [weak self] shouldShowLoader in
                self?.handleLoadingView(shouldShowLoader)
            })
            .disposed(by: disposeBag)
        
        error.asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }
    
    final func configureNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = Asset.Colors.orange400.color
        navigationController.navigationBar.backgroundColor = Asset.Colors.orange400.color
        navigationController.navigationBar.tintColor = Asset.Colors.white.color
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: Asset.Colors.white.color,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
    }
    
    func createLoadingViewController() -> UIViewController {
        let loadingView = UIViewController()
        return loadingView
    }
    
    func handleLoadingView(_ isLoading: Bool) {
        if isLoading {
            view.endEditing(true)
            add(loadingViewController)
            // adicionar constrainst "edges to superview"
        } else {
            loadingViewController.removeFromParent()
        }
    }
    
    func handleError(_ error: Error, onConfirm: (() -> Void)? = nil) {
        dump(error)
        
        // handle error
        Alert.show(in: self, title: "titulo do erro", message: "menssagem de erro")
    }

    func keyboardWillAppear(with size: CGSize, duration: TimeInterval) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: size.height + 16, right: 0)
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
        
        var rect = view.frame
        rect.size.height -= size.height
        guard let activeTextField = findActiveTextField(view.subviews) else { return }
        if !rect.contains(activeTextField.frame.origin) {
            internalScrollView?.scrollRectToVisible(activeTextField.frame, animated: true)
        }
    }

    func keyboardWillDisappear(with size: CGSize, duration: TimeInterval) {
        let contentInsets = UIEdgeInsets.zero
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
    }
}

extension BaseViewController {
    func observeKeyboardNotifications(with scrollView: UIScrollView? = nil) {
        internalScrollView = scrollView
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let info = notification.userInfo,
              let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
              .cgRectValue.size,
              let animationDuration = (
                  info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
              )?.doubleValue
        else { return }

        keyboardWillAppear(with: keyboardSize, duration: animationDuration)
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        guard let info = notification.userInfo,
              let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
              .cgRectValue.size,
              let animationDuration = (
                  info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
              )?.doubleValue
        else { return }

        keyboardWillDisappear(with: keyboardSize, duration: animationDuration)
    }
    
    // testar os dois dismiss
    @objc func dismissKeyboard2(_ gesture: UITapGestureRecognizer) {
        let viewGesture = gesture.view
        let loc = gesture.location(in: viewGesture)
        if let subview = viewGesture?.hitTest(loc, with: nil), subview.isKind(of: UIButton.self) {
            return
        }
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func dismissKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func findActiveTextField(_ subviews: [UIView]) -> UITextField? {
        for view in subviews {
            if let textField = view as? UITextField, textField.isFirstResponder {
                return textField
            }

            return findActiveTextField(view.subviews)
        }
        return nil
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch
    ) -> Bool {
        guard let view = touch.view else { return false }
        return (view is UIControl) == false
    }
}

enum Alert {
    static func show(
        in viewController: UIViewController,
        title: String?,
        message: String?,
        onConfirm: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK", style: .cancel,
                handler: { _ in
                    onConfirm?()
                }
            ))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
}
