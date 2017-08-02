//
//  TennisScoreSimulatorPlayerTests.swift
//  TennisScoreSimulator
//
//  Created by Alexey on 1/8/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import TennisScoreSimulator

class TennisScoreSimulatorPlayerTests: XCTestCase {
    
    let playerName = "Player"
    let opponentName = "Opponent"
    
    var player: Player!
    var opponent: Player!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        player = Player(name: playerName)
        opponent = Player(name: opponentName)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlayerInit() {
        XCTAssertEqual(player.name, playerName)
        XCTAssertEqual(player.gameScore, .zero)
        XCTAssertEqual(player.setScore, 0)
        XCTAssertEqual(player.tiebreakScore, 0)
    }
    
    func testPlayerWonGamePoint() {
        // 0-0
        XCTAssertEqual(player.gameScore, .zero)
        
        // 15-0
        player.wonPoint(opponent: opponent, isTiebreak: false)
        XCTAssertEqual(player.gameScore, .fifteen)
    }
    
    func testPlayerWonGame() {
        // 0-0
        XCTAssertEqual(player.gameScore, .zero)
        
        // 15-0
        player.wonPoint(opponent: opponent, isTiebreak: false)
        XCTAssertEqual(player.gameScore, .fifteen)
        
        // 30-0
        player.wonPoint(opponent: opponent, isTiebreak: false)
        XCTAssertEqual(player.gameScore, .thirty)
        
        // 40-0
        player.wonPoint(opponent: opponent, isTiebreak: false)
        XCTAssertEqual(player.gameScore, .forty)
        
        // game
        player.wonPoint(opponent: opponent, isTiebreak: false)
        XCTAssertEqual(player.gameScore, .game)
        
        // 0-0
        player.newGame()
        XCTAssertEqual(player.gameScore, .zero)
    }
}
