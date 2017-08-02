//
//  TennisScoreSimulatorMatchTests.swift
//  TennisScoreSimulator
//
//  Created by Alexey on 1/8/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import TennisScoreSimulator

class TennisScoreSimulatorMatchTests: XCTestCase {
    
    let playerOneName = "Player 1"
    let playerTwoName = "Player 2"
    
    var match: Match!
    var score: String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        match = Match(playerOneName: playerOneName, playerTwoName: playerTwoName)
        score = ""
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMatchInit() {
        XCTAssertEqual(match.playerOne.name, playerOneName)
        XCTAssertEqual(match.playerTwo.name, playerTwoName)
    }
    
    func testMatchOneGame() {
        score = match.score()
        XCTAssertEqual(score, "0-0")
        
        match.pointWonBy(match.playerOne)
        score = match.score()
        XCTAssertEqual(score, "0-0, 15-0")
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        score = match.score()
        XCTAssertEqual(score, "0-0, 15-30")
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        score = match.score()
        XCTAssertEqual(score, "0-1")
        
        XCTAssertEqual(match.playerOne.gameScore, .zero)
        XCTAssertEqual(match.playerTwo.gameScore, .zero)
    }
    
    func testMatchDeuce() {
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        score = match.score()
        XCTAssertEqual(score, "0-0, Deuce")
        
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerTwo)
        
        score = match.score()
        XCTAssertEqual(score, "0-0, Deuce")
    }
    
    func testMatchAdvantagePlayerOne() {
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        match.pointWonBy(match.playerOne)
        
        score = match.score()
        XCTAssertEqual(score, "0-0, Advantage \(match.playerOne.name)")
    }
    
    func testMatchAdvantagePlayerTwo() {
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        match.pointWonBy(match.playerTwo)
        
        score = match.score()
        XCTAssertEqual(score, "0-0, Advantage \(match.playerTwo.name)")
    }
    
    func testMatchPlayerOneWonGameAfterDeuce() {
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        
        score = match.score()
        XCTAssertEqual(score, "1-0")
        
        match.pointWonBy(match.playerTwo)
        
        score = match.score()
        XCTAssertEqual(score, "1-0, 0-15")
    }
    
    func testMatchPlayerTwoWonGameAfterDeuce() {
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        score = match.score()
        XCTAssertEqual(score, "0-1")
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        score = match.score()
        XCTAssertEqual(score, "0-1, 0-30")
    }
    
    func testMatchPlayerOneWonSet() {
        for _ in 1...4 {
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
        }
        
        for _ in 1...MatchScore.maximumSetScore {
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
        }
        
        score = match.score()
        XCTAssertEqual(score, "4-6")
        XCTAssertTrue(match.isMatchOver)
    }
    
    func testMatchPlayerTwoWonSet() {
        for set in 1...MatchScore.maximumSetScore {
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            
            score = match.score()
            XCTAssertEqual(score, "\(set)-0")
        }
        XCTAssertTrue(match.isMatchOver)
    }
    
    func testMatchPlayerTwoWonTiebreak() {
        for _ in 1...5 {
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
        }
        
        for _ in 1...5 {
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
        }
        
        score = match.score()
        XCTAssertEqual(score, "5-5")
        
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        match.pointWonBy(match.playerOne)
        
        score = match.score()
        XCTAssertEqual(score, "6-5")
        XCTAssertFalse(match.isMatchOver)
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        
        XCTAssertEqual(match.score(), "6-6")
        
        match.pointWonBy(match.playerTwo)
        match.pointWonBy(match.playerTwo)
        XCTAssertEqual(match.score(), "6-6, 0-2")
        XCTAssertFalse(match.isMatchOver)
        
        for _ in 1...6 {
            match.pointWonBy(match.playerOne)
        }
        
        XCTAssertEqual(match.score(), "6-6, 6-2")
        XCTAssertFalse(match.isMatchOver)
        
        for _ in 1...5 {
            match.pointWonBy(match.playerTwo)
        }
        
        XCTAssertEqual(match.score(), "6-6, 6-7")
        XCTAssertFalse(match.isMatchOver)
        
        match.pointWonBy(match.playerTwo)
        XCTAssertEqual(match.score(), "6-7")
        XCTAssertTrue(match.isMatchOver)
    }
    
    func testMatchPlayerOneWonExtraSet() {
        for _ in 1...5 {
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
        }
        
        for _ in 1...5 {
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
            match.pointWonBy(match.playerTwo)
        }
        
        for _ in 1...2 {
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
            match.pointWonBy(match.playerOne)
        }
        
        XCTAssertEqual(match.score(), "7-5")
        XCTAssertTrue(match.isMatchOver)
    }
}
