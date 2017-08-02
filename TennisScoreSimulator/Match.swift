//
//  Match.swift
//  TennisScoreSimulator
//
//  Created by Alexey on 1/8/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct MatchScore {
    static let maximumSetScore = 6
    static let minimumSetScoreDifference = 2
    static let maximumTiebreakScore = 7
    static let minimumTiebreakScoreDifference = 2
}

class Match: MatchProtocol {
    
    private(set) var playerOne: Player
    private(set) var playerTwo: Player
    private(set) var isMatchOver: Bool
    private var isTiebreak: Bool
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOne = Player(name: playerOneName)
        self.playerTwo = Player(name: playerTwoName)
        self.isMatchOver = false
        self.isTiebreak = false
    }
    
    // Return match score
    // Return format: "s1-s2, g1-g2", s1, s2 - number of sets won by player 1 and player2. g1, g2 current game score.
    // If new game has not started yet (game score 0-0), return format is "s1-s2"
    // If game score is 40-40, return format is "s1-s2, Deuce"
    // If one of the players has advantage, return format is "s1-s2, Advantage "player name""
    func score() -> String {
        // Current set score
        var result = "\(playerOne.setScore)-\(playerTwo.setScore)"
        
        if let gameScore = self.gameScore() {
            // Append current game score if the game is is progress
            result.append(", \(gameScore)")
        }
        
        return result
    }
    
    // Update score for both players, check that game or set is over
    func pointWonBy(_ player: Player) {
        if isMatchOver {
            return
        }
        
        let opponent = player === playerOne ? playerTwo : playerOne
        
        player.wonPoint(opponent: opponent, isTiebreak: isTiebreak)
        opponent.lostPoint(player.gameScore, isTiebreak: isTiebreak)
        
        if .game == player.gameScore {
            // Game won by "player"
            player.wonSet(opponent: opponent, isTiebreak: isTiebreak)
            if .set == player.gameScore {
                // Set won by "player"
                self.isMatchOver = true
            }
            player.newGame()
            opponent.newGame()
        }
        
        self.isTiebreak = MatchScore.maximumSetScore == player.setScore && MatchScore.maximumSetScore == opponent.setScore
    }
    
    // MARK: - Private method
    
    // Return game score.
    // Return format: "g1-g2", g1, g2 current game score.
    // If new game has not started yet (game score 0-0), return nil
    // If game score is 40-40, return format is ", Deuce"
    // If one of the players has advantage, return format is ", Advantage "player name""
    private func gameScore() -> String? {
        
        if 0 == playerOne.currentGameScore(isTiebreak), 0 == playerTwo.currentGameScore(isTiebreak) {
            return nil
        }
        
        if .forty == playerOne.gameScore, .forty == playerTwo.gameScore {
            return "Deuce"
        }
        
        if .adv == playerOne.gameScore {
            return "Advantage \(playerOne.name)"
        }
        
        if .adv == playerTwo.gameScore {
            return "Advantage \(playerTwo.name)"
        }
        
        return "\(playerOne.currentGameScore(isTiebreak))-\(playerTwo.currentGameScore(isTiebreak))"
    }
}
