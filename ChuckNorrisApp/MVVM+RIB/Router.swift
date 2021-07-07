//
//  Router.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 12/06/21.
//

import UIKit

class Router {
    weak var viewController: UIViewController!
}

protocol BaseRouting: AnyObject {}

final class BaseRouter: Router, BaseRouting { }
