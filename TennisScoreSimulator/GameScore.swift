//
//  GameScore.swift
//  TennisScoreSimulator
//
//  Created by Alexey on 1/8/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum GameScore: Int, Comparable {
    
    case zero       = 0
    case fifteen    = 15
    case thirty     = 30
    case forty      = 40
    case adv        = 45
    case game       = 50
    case set        = 55
    
    // Updated game score of won player
    mutating func updateWonPoint(opponentGameScore: GameScore) {
        switch self {
        case .zero:
            self = .fifteen
            
        case .fifteen:
            self = .thirty
            
        case .thirty:
            self = .forty
            
        case .forty:
            switch opponentGameScore {
            case .forty:
                self = .adv
                
            case .adv:
                break
                
            default:
                self = .game
            }
            
        case .adv:
            self = .game
            
        case .game, .set:
            assertionFailure("Wrong game score!")
        }
    }
    
    // Update game score of lost player
    mutating func updateLostPoint(_ point: GameScore) {
        switch point {
        case .zero, .fifteen, .thirty:
            break
            
        case .forty:
            if self == .adv {
                self = .forty
            }
            
        case .adv:
            break
            
        case .game, .set:
            break
        }
    }
}

// MARK: - Comparable protocol methods

func ==(lhs: GameScore, rhs: GameScore) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func <(lhs: GameScore, rhs: GameScore) -> Bool {
    return lhs.rawValue < rhs.rawValue
}
