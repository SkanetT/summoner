//
//  SpectatorPresenterOutput.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SpectatorPresenterOutput: class {
    func didReceiveDataForFirstTeam(_ data: [ParticipantSpectator])
    func didReceiveDataForSecondTeam(_ data: [ParticipantSpectator])
    func matchHasBans(_ bans: [BannedChampion])
    func noBansInMatch()
    func didReciveTitle(_ title: String?)
    func setActionForCell(_ userSelect: ((String) -> ())?)
}
