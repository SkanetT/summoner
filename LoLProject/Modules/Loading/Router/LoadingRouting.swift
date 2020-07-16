//
//  LoadingRouting.swift
//  LoLProject
//
//  Created by Антон on 16.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol LoadingRouting {
    func windowContainer()
    func showError(_ error: APIErrors )
}
