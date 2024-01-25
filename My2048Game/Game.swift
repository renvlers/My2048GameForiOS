//
//  Game.swift
//  My2048Game
//
//  Created by Renvle RS on 1/24/24.
//

import SwiftUI
import Foundation

struct Game {
    var gameStatus: GameStatus
    var gameMode: GameMode
    var time: Time
    var board: [Int]
    
    init(gameMode: GameMode) {
        self.gameMode = gameMode
        self.board = Array<Int>(repeating: 0, count: 16)
        self.gameStatus = .initStatus
        self.time = Time(tolSeconds: 0)
        
        self.addRandomTile();
        self.addRandomTile();
    }
    
    mutating func resetGame() {
        self.board = Array<Int>(repeating: 0, count: 16)
        self.gameStatus = .initStatus
        self.time = Time(tolSeconds: 0)
        
        self.addRandomTile();
        self.addRandomTile();
    }
    
    mutating func addRandomTile() {
        var avaliableSpots: [Int] = []
        
        for i in 0..<self.board.count {
            if self.board[i] == 0 {
                avaliableSpots.append(i)
            }
        }
        
        if avaliableSpots.count > 0 {
            let spot = avaliableSpots[Int.random(in: 0..<avaliableSpots.count)]
            self.board[spot] = Double.random(in: 0.0...1.0) > 0.9 ? 4 : 2
        }
    }
    
    mutating func merge(_ column: [Int]) -> [Int] {
        var newColumn = column.filter { $0 != 0 }
        var flag = false
        
        if newColumn.count > 0 {
            for i in 0..<newColumn.count - 1 {
                if newColumn[i] == newColumn[i + 1] {
                    newColumn[i] *= 2
                    newColumn[i + 1] = 0
                    if newColumn[i] == 2048 {
                        flag = true
                    }
                }
            }
        }
        
        
        newColumn = newColumn.filter { $0 != 0 }
        
        while newColumn.count < 4 {
            newColumn.append(0)
        }
        
        if flag {
            self.endGame(status: .wonStatus)
        }
        
        return newColumn
    }
    
    mutating func slideUp() {
        if self.gameStatus == .initStatus {
            self.gameStatus = .inProcessStatus
            self.time.startTiming()
        }
        
        if self.gameStatus == .inProcessStatus {
            let size = 4
            var newBoard = Array<Int>(repeating: 0, count: 16)
            
            for i in 0..<size {
                var column: [Int] = []
                for j in 0..<size {
                    column.append(self.board[i + j * size])
                }
                column = self.merge(column)
                
                for j in 0..<size {
                    newBoard[i + j * size] = column[j]
                }
            }
            
            var flag = false
            for i in 0..<self.board.count {
                if self.board[i] != newBoard[i] {
                    flag = true
                }
            }
            
            self.board = newBoard
            
            if flag {
                self.addRandomTile()
            }
            
            if self.isGameOver() {
                self.endGame(status: .lostStatus)
            }
        }
    }
    
    mutating func slideDown() {
        if self.gameStatus == .initStatus {
            self.gameStatus = .inProcessStatus
            self.time.startTiming()
        }
        
        if self.gameStatus == .inProcessStatus {
            let size = 4
            var newBoard = Array<Int>(repeating: 0, count: 16)
            
            for i in 0..<size {
                var column: [Int] = []
                for j in 0..<size {
                    column.insert(self.board[i + j * size], at: 0)
                }
                column = self.merge(column)
                
                for j in 0..<size {
                    newBoard[i + j * size] = column[size - 1 - j]
                }
            }
            
            var flag = false
            for i in 0..<self.board.count {
                if self.board[i] != newBoard[i] {
                    flag = true
                }
            }
            
            self.board = newBoard
            
            if flag {
                self.addRandomTile()
            }
            
            if self.isGameOver() {
                self.endGame(status: .lostStatus)
            }
        }
    }
    
    mutating func slideLeft() {
        if self.gameStatus == .initStatus {
            self.gameStatus = .inProcessStatus
            self.time.startTiming()
        }
        
        if self.gameStatus == .inProcessStatus {
            let size = 4
            var newBoard = Array<Int>(repeating: 0, count: 16)
            
            for i in 0..<size {
                var row: [Int] = []
                for j in 0..<size {
                    row.append(self.board[i * size + j])
                }
                row = self.merge(row)
                
                for j in 0..<size {
                    newBoard[i * size + j] = row[j]
                }
            }
            
            var flag = false
            for i in 0..<self.board.count {
                if self.board[i] != newBoard[i] {
                    flag = true
                }
            }
            
            self.board = newBoard
            
            if flag {
                self.addRandomTile()
            }
            
            if self.isGameOver() {
                self.endGame(status: .lostStatus)
            }
        }
    }
    
    mutating func slideRight() {
        if self.gameStatus == .initStatus {
            self.gameStatus = .inProcessStatus
            self.time.startTiming()
        }
        
        if self.gameStatus == .inProcessStatus {
            let size = 4
            var newBoard = Array<Int>(repeating: 0, count: 16)
            
            for i in 0..<size {
                var row: [Int] = []
                for j in 0..<size {
                    row.insert(self.board[i * size + j], at: 0)
                }
                row = self.merge(row)
                
                for j in 0..<size {
                    newBoard[i * size + j] = row[size - 1 - j]
                }
            }
            
            var flag = false
            for i in 0..<self.board.count {
                if self.board[i] != newBoard[i] {
                    flag = true
                }
            }
            
            self.board = newBoard
            
            if flag {
                self.addRandomTile()
            }
            
            if self.isGameOver() {
                self.endGame(status: .lostStatus)
            }
        }
    }
    
    func isGameOver() -> Bool {
        let size = 4
        
        if self.board.contains(0) {
            return false
        }
        
        for i in 0..<size {
            for j in 0..<size - 1 {
                if self.board[i * size + j] == self.board[i * size + j + 1] {
                    return false
                }
            }
        }
        
        for i in 0..<size - 1 {
            for j in 0..<size {
                if self.board[i * size + j] == self.board[(i + 1) * size + j] {
                    return false
                }
            }
        }
        
        return true
    }
    
    mutating func endGame(status: GameStatus) {
        if self.gameStatus == .inProcessStatus {
            self.gameStatus = status
            self.time.stopTiming()
        }
    }
    
    func getOverTitle() -> String? {
        if self.gameStatus == .wonStatus {
            return "游戏胜利"
        } else if self.gameStatus == .lostStatus {
            return "游戏失败"
        } else {
            return nil
        }
    }
    
    func getOverMessage() -> String {
        var maxNum = -1
        
        for i in self.board {
            maxNum = maxNum > i ? maxNum : i
        }
        
        if self.gameMode == .dynastyMode {
            if maxNum == 4 {
                return "连秦始皇都见不到了T.T"
            } else if maxNum == 8 {
                return "都是赵高害得我！"
            } else if maxNum == 16 {
                return "曹贼你还我大汉江山！"
            } else if maxNum == 32 {
                return "安史之乱亡我大唐……"
            } else if maxNum == 64 {
                return "元人铁蹄果然厉害！"
            } else if maxNum == 128 {
                return "还是朱元璋厉害……"
            } else if maxNum == 256 {
                return "天地会的弟兄们，反清复明啊！"
            } else if maxNum == 512 {
                return "连辛亥革命的黎明都没等到……"
            } else if maxNum == 1024 {
                return "看不到天朝的太阳了 = ="
            } else if maxNum == 2048 {
                return "中华人民共和国万岁！"
            } else {
                return "你获得了\"\(self.getDisplayMessage(value: maxNum))\"方块"
            }
        } else {
            return "你获得了\"\(self.getDisplayMessage(value: maxNum))\"方块"
        }
    }
    
    func getDisplayMessage(value: Int) -> String {
        if self.gameMode == .classicMode {
            return value == 0 ? "" : String(value)
        } else if self.gameMode == .dynastyMode {
            switch value {
            case 2:
                return "商"
            case 4:
                return "周"
            case 8:
                return "秦"
            case 16:
                return "汉"
            case 32:
                return "唐"
            case 64:
                return "宋"
            case 128:
                return "元"
            case 256:
                return "明"
            case 512:
                return "清"
            case 1024:
                return "ROC"
            case 2048:
                return "PRC"
            default:
                return ""
            }
        } else if self.gameMode == .jiaYiBingDingMode {
            switch value {
            case 2:
                return "甲"
            case 4:
                return "乙"
            case 8:
                return "丙"
            case 16:
                return "丁"
            case 32:
                return "戊"
            case 64:
                return "己"
            case 128:
                return "庚"
            case 256:
                return "辛"
            case 512:
                return "壬"
            case 1024:
                return "癸"
            case 2048:
                return "终"
            default:
                return ""
            }
        } else {
            return ""
        }
    }
    
    func getColor(value: Int) -> Color {
        switch value {
        case 2:
            return Color(red: 0xee/0xff, green: 0xe4/0xff, blue: 0xda/0xff)
        case 4:
            return Color(red: 0xed/0xff, green: 0xe0/0xff, blue: 0xc8/0xff)
        case 8:
            return Color(red: 0xf2/0xff, green: 0xb1/0xff, blue: 0x79/0xff)
        case 16:
            return Color(red: 0xf5/0xff, green: 0x95/0xff, blue: 0x63/0xff)
        case 32:
            return Color(red: 0xf6/0xff, green: 0x7c/0xff, blue: 0x5f/0xff)
        case 64:
            return Color(red: 0xf6/0xff, green: 0x5e/0xff, blue: 0x3b/0xff)
        case 128:
            return Color(red: 0xed/0xff, green: 0xcf/0xff, blue: 0x72/0xff)
        case 256:
            return Color(red: 0xed/0xff, green: 0xcc/0xff, blue: 0x61/0xff)
        case 512:
            return Color(red: 0xed/0xff, green: 0xc8/0xff, blue: 0x50/0xff)
        case 1024:
            return Color(red: 0xed/0xff, green: 0xc5/0xff, blue: 0x3f/0xff)
        case 2048:
            return Color(red: 0xed/0xff, green: 0xc2/0xff, blue: 0x2e/0xff)
        default:
            return Color(red: 0xec/0xff, green: 0xec/0xff, blue: 0xec/0xff)
        }
    }
}
