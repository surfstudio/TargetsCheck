//
//  MainModuleConfigurator.swift
//  TargetsCheck
//
//  Created by Александр Чаусов on 09/10/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

final class MainModuleConfigurator {

    func configure() -> (UIViewController, MainModuleOutput) {
        let view = MainViewController()
        let presenter = MainPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
