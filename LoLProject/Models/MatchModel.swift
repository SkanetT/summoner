//
//  Member.swift
//  LoLProject
//
//  Created by Антон on 28.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation



struct MatchModel {
    
    var summonerInMatch: SummonerInMatch = .init()
    
    var members: [Member] = []
    
    
    init(match: FullInfoMatch, summonerName: String) {
        
        summonerInMatch.dateCreation = match.gameCreation
        
        switch match.queueId {
        case 400:
            summonerInMatch.matchType = "Normal (Draft Pick)"
        case 420:
            summonerInMatch.matchType = "Ranked Solo/Duo"
        case 430:
            summonerInMatch.matchType = "Normal (Blind Pick)"
        case 440:
            summonerInMatch.matchType = "Ranked Flex"
        case 700:
            summonerInMatch.matchType = "Clash"
        case 1020:
            summonerInMatch.matchType = "One for All"
        default:
            summonerInMatch.matchType = "Error type \(match.queueId)"
        }
        
        
        summonerInMatch.date = { () -> String in
            let realTime = round(Double(match.gameCreation/1000))
            let date = Date(timeIntervalSince1970: realTime)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: date)
            return strDate
        } ()
        
        summonerInMatch.time = { () -> String in
            let timeMatch = match.gameDuration / 60
            let timeMatchSec = match.gameDuration % 60
            var result: String = ""
            if timeMatchSec < 10 {
                result = "\(timeMatch):0\(timeMatchSec)"
            } else {
                result = "\(timeMatch):\(timeMatchSec)"
            }
            return result
        } ()
        
        if let myPlayerIdentities = match.participantIdentities.first(where: { $0.player.summonerName == summonerName }){
            summonerInMatch.idInMatch = myPlayerIdentities.participantId
            if let myPlayer = match.participants.first(where: { $0.participantId == summonerInMatch.idInMatch }) {
                summonerInMatch.win = myPlayer.stats.win
                summonerInMatch.championKey = String(myPlayer.championId)
                summonerInMatch.kda = "\(myPlayer.stats.kills) / \(myPlayer.stats.deaths) / \(myPlayer.stats.assists)"
                summonerInMatch.spellKey1 = String(myPlayer.spell1Id)
                summonerInMatch.spellKey2 = String(myPlayer.spell2Id)
                summonerInMatch.wardId = String(myPlayer.stats.item6)
                summonerInMatch.firstItemId = String(myPlayer.stats.item0)
                summonerInMatch.secondItemId = String(myPlayer.stats.item1)
                summonerInMatch.thirdItemId = String(myPlayer.stats.item2)
                summonerInMatch.fourthItemId = String(myPlayer.stats.item3)
                summonerInMatch.fifthItemId = String(myPlayer.stats.item4)
                summonerInMatch.sixthItemId = String(myPlayer.stats.item5)
            }
        }
        
        for id in 1...match.participantIdentities.count {
            if let member = match.participants.first(where: { $0.participantId == id }), let memberIdentities = match.participantIdentities.first(where: { $0.participantId == id }) {
                
                var memberData = Member()
                memberData.name = memberIdentities.player.summonerName
                memberData.championKey = String(member.championId)
                memberData.kda = "\(member.stats.kills) / \(member.stats.deaths) / \(member.stats.assists)"
                memberData.spellKey1 = String(member.spell1Id)
                memberData.spellKey2 = String(member.spell2Id)
                memberData.wardId = String(member.stats.item6)
                memberData.firstItemId = String(member.stats.item0)
                memberData.secondItemId = String(member.stats.item1)
                memberData.thirdItemId = String(member.stats.item2)
                memberData.fourthItemId =  String(member.stats.item3)
                memberData.fifthItemId = String(member.stats.item4)
                memberData.sixthItemId = String(member.stats.item5)
                
                members.append(memberData)
                
            }
        }
        
        
    }
    
}
    

struct Member {
    var name: String = ""
    var championKey: String = ""
    var kda: String = ""
    var spellKey1: String = ""
    var spellKey2: String = ""
    var wardId: String = ""
    var firstItemId: String = ""
    var secondItemId: String = ""
    var thirdItemId: String = ""
    var fourthItemId: String = ""
    var fifthItemId: String = ""
    var sixthItemId: String = ""
}

struct SummonerInMatch {
    var matchType: String = ""
    var date: String = ""
    var dateCreation: Int = 0
    var time: String = ""
    var win: Bool = false
    var idInMatch = 0
    
    var championKey: String = ""
    var kda: String = ""
    var spellKey1: String = ""
    var spellKey2: String = ""
    var wardId: String = ""
    var firstItemId: String = ""
    var secondItemId: String = ""
    var thirdItemId: String = ""
    var fourthItemId: String = ""
    var fifthItemId: String = ""
    var sixthItemId: String = ""
}
