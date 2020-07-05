//
//  SpectatorInteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SpectatorInteractorOutput: class {
    func didReceiveParticipantSpectators(_ participantSpectators: [ParticipantSpectator])
    func didReceiveGameQueueConfigId(_ gameQueueConfigId: Int?)
    func didReceiveBans(_ bans: [BannedChampion])
    func reconnectSuccess()
    func reconnectFailure(_ error: APIErrors)
}
