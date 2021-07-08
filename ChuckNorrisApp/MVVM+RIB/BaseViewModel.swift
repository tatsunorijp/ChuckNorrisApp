//
//  BaseViewModel.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 12/06/21.
//

import Foundation

protocol BaseViewModelInput: AnyObject { }
protocol BaseViewModelOutput: AnyObject { }

protocol BaseViewModelType: AnyObject {
    var input: BaseViewModelInput { get }
    var output: BaseViewModelOutput { get }
}

final class BaseViewModel: BaseViewModelType, BaseViewModelInput, BaseViewModelOutput {
    // inputs
    // ...
    
    init(interactor: BaseInteractable) { }
    
    // outputs
    // ...
    var input: BaseViewModelInput { return self }
    var output: BaseViewModelOutput { return self }
}
