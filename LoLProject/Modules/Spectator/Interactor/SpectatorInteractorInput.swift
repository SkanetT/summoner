//
//  SpectatorInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SpectatorInteractorInput: class {
    func attach(_ output: SpectatorInteractorOutput)
    func fetchParticipantSpectators()
    func fetchDataForTitle()
    func fetchBans()
    func attemptToReconnect(summonerName: String)

}
