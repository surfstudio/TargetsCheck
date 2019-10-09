//
//  MainPresenter.swift
//  TargetsCheck
//
//  Created by Александр Чаусов on 09/10/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

final class MainPresenter: MainModuleOutput {

    // MARK: - MainModuleOutput

    // MARK: - Properties

    weak var view: MainViewInput?

}

// MARK: - MainModuleInput

extension MainPresenter: MainModuleInput {
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
