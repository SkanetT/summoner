//
//  SpectatorCollectionHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol SpectatorCollectionHandlerProtocol {
    func attach(_ collectionView: UICollectionView)
    func updateData(participantSpectator: [ParticipantSpectator])
    func setAction(userSelect: ((String) -> ())?)

}
