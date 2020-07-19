//
//  LoginRouting.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol LoginRouting {
    func sideMenu()
    func showWrongName()
    func presentSummoner()
    func showNoSummoner(_ name: String)
    func showError(_ error: APIErrors )
    func showPicker()
    func serverDidChange(_ server: ((String) -> ())?)
}
