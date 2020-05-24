//
//  FullInfoMatch.swift
//  LoLProject
//
//  Created by Антон on 21.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct FullInfoMatch: Codable {
    
    let gameCreation, gameDuration, queueId, mapId: Int
    let participants: [Participant]
    let participantIdentities: [ParticipantIdentity]

}

struct Participant: Codable {
    let participantId, teamId, championId: Int
    let spell1Id, spell2Id: Int
    let stats: Stats

}

struct Stats: Codable {
    let participantId: Int
    let win: Bool
    let item0, item1, item2, item3: Int
    let item4, item5, item6, kills: Int
    let deaths, assists, largestKillingSpree, largestMultiKill: Int
    let killingSprees, longestTimeSpentLiving, doubleKills, tripleKills: Int
    let quadraKills, pentaKills, unrealKills, totalDamageDealt: Int
    let magicDamageDealt, physicalDamageDealt, trueDamageDealt, largestCriticalStrike: Int
    let totalDamageDealtToChampions, magicDamageDealtToChampions, physicalDamageDealtToChampions, trueDamageDealtToChampions: Int
    let totalHeal, totalUnitsHealed, damageSelfMitigated, damageDealtToObjectives: Int
    let damageDealtToTurrets, visionScore, timeCCingOthers, totalDamageTaken: Int
    let magicalDamageTaken, physicalDamageTaken, trueDamageTaken, goldEarned: Int
    let goldSpent, turretKills, inhibitorKills, totalMinionsKilled: Int
    let neutralMinionsKilled, neutralMinionsKilledTeamJungle, neutralMinionsKilledEnemyJungle, totalTimeCrowdControlDealt: Int
    let champLevel, visionWardsBoughtInGame, sightWardsBoughtInGame, wardsPlaced: Int
    let wardsKilled: Int?
    let firstBloodKill, firstBloodAssist, firstTowerKill, firstTowerAssist: Bool?
    let firstInhibitorKill, firstInhibitorAssist: Bool?
    let combatPlayerScore, objectivePlayerScore, totalPlayerScore, totalScoreRank: Int?
    let playerScore0, playerScore1, playerScore2, playerScore3: Int?
    let playerScore4, playerScore5, playerScore6, playerScore7: Int?
    let playerScore8, playerScore9, perk0, perk0Var1: Int?
    let perk0Var2, perk0Var3, perk1, perk1Var1: Int?
    let perk1Var2, perk1Var3, perk2, perk2Var1: Int?
    let perk2Var2, perk2Var3, perk3, perk3Var1: Int?
    let perk3Var2, perk3Var3, perk4, perk4Var1: Int?
    let perk4Var2, perk4Var3, perk5, perk5Var1: Int?
    let perk5Var2, perk5Var3, perkPrimaryStyle, perkSubStyle: Int?
    let statPerk0, statPerk1, statPerk2: Int?
}

struct ParticipantIdentity: Codable {
    let participantId: Int
    let player: Player
}

struct Player: Codable {
    let accountId, summonerName, summonerId: String
    let profileIcon: Int

}
