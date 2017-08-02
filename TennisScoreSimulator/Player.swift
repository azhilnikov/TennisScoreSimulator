//
//  Player.swift
//  TennisScoreSimulator
//
//  Created by Alexey on 1/8/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class Player {
    
    private(set) var name: String
    private(set) var gameScore: GameScore
    private(set) var setScore: Int
    private(set) var tiebreakScore: Int
    
    init(name: String) {
        self.name = name
        self.gameScore = .zero
        self.setScore = 0
        self.tiebreakScore = 0
    }
    
    func wonPoint(opponent: Player, isTiebreak: Bool) {
        if isTiebreak {
            tiebreakScore += 1
            if tiebreakScore >= MatchScore.maximumTiebreakScore,
                tiebreakScore - opponent.tiebreakScore >= MatchScore.minimumTiebreakScoreDifference {
                // Won set on tiebreak
                gameScore = .game
            }
        } else {
            gameScore.updateWonPoint(opponentGameScore: opponent.gameScore)
        }
    }
    
    func lostPoint(_ point: GameScore, isTiebreak: Bool) {
        if !isTiebreak {
            gameScore.updateLostPoint(point)
        }
    }
    
    func currentGameScore(_ isTiebreak: Bool) -> Int {
        return isTiebreak ? tiebreakScore : gameScore.rawValue
    }
    
    func newGame() {
        self.gameScore = .zero
        self.tiebreakScore = 0
    }
    
    func wonSet(opponent: Player, isTiebreak: Bool) {
        setScore += 1
        
        if isTiebreak ||
            (setScore >= MatchScore.maximumSetScore && setScore - opponent.setScore >= MatchScore.minimumSetScoreDifference) {
            // Set won by "player"
            gameScore = .set
        }
    }
    
    func newSet() {
        setScore = 0
    }
}
