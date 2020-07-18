//
//  LoginInteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LoginInteractorOutput: class {
    func successFoundSummoner()
    func isLogin()
    func successNoSummoner(_ name: String)
    func failureSummoner(_ error: APIErrors)
}
