//
//  LoginPresenterInput.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LoginPresenterInput: class {
    func viewWillAppear()
    func attach(_ viewController: LoginPresenterOutput)
    func sideMenuTap()
    func didInputName(_ name: String, _ region: String)
    func serverChangeTap()
}
