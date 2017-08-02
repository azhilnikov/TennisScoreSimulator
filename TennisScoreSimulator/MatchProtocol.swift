//
//  MatchProtocol.swift
//  TennisScoreSimulator
//
//  Created by Alexey on 1/8/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol MatchProtocol {
    func score() -> String
    func pointWonBy(_ player: Player)
}
