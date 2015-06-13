//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Elton Nix on 6/13/15.
//  Copyright (c) 2015 Elton Nix. All rights reserved.
//

import Foundation
import UIKit

class SlotBrain {
    
    class func unpackSlotIntoSlotRows(slots: [[Slot]]) -> [[Slot]] {
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow.append(slot)
                } else if index == 1 {
                    slotRow2.append(slot)
                } else if index == 2 {
                    slotRow3.append(slot)
                } else {
                    println("Error in SlotBrain class")
                }
            }
        }
        var slotsInRows: [[Slot]] = [slotRow, slotRow2, slotRow3]
        return slotsInRows
    }
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotIntoSlotRows(slots)
        var winnings = 0
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        var won = false
        
        for slotRow in slotsInRows {
            if checkFlush(slotRow) {
                winnings++
                flushWinCount++
                println("flush: \(flushWinCount)")
                won = true
            }
            if checkThreeOfAKind(slotRow) {
                winnings += 3
                threeOfAKindWinCount++
                println("three of a kind: \(threeOfAKindWinCount)")
                won = true
            }
            if checkThreeInARow(slotRow) {
                winnings++
                straightWinCount++
                println("straight: \(straightWinCount)")
                won = true
            }
        }
        
        if flushWinCount == 3 {
            println("Royal Flush")
            winnings += 15
        }
        
        if threeOfAKindWinCount == 3 {
            println("Threes all around")
            winnings += 50
        }
        
        if straightWinCount == 3 {
            println("Epic Straight")
            winnings += 1000
        }
        
        if !won {
            println("Didn't win")
        }
        
        return winnings
    }
    
    class func checkFlush(slotRow: [Slot]) -> Bool {
        var redCount = 0
        var blackCount = 0
        var result = false
        
        for slot in slotRow {
            if slot.isRed {
                redCount++
            } else {
                blackCount++
            }
        }
        
        if blackCount == slotRow.count || redCount == slotRow.count {
            result = true
        } else if blackCount > slotRow.count || redCount > slotRow.count {
            println("checkFlush func error in SlotBrain class")
        }
        return result
    }
    
    class func checkThreeOfAKind(slotRow: [Slot]) -> Bool {
        var result = false
        var slotValues: [Int] = []
        var matchesCount = 1
        
        for slot in slotRow {
            slotValues.append(slot.value)
        }
        for var index = 1; (slotRow.count - index) > 0; index++ {
            if slotValues[0] == slotValues[index] {
                matchesCount++
            }
        }
        if matchesCount == 3 {
            result = true
        }
        
        return result
    }
    
    class func checkThreeInARow(slotRow: [Slot]) -> Bool {
        var result = false
        var slotValues: [Int] = []
        
        for slot in slotRow {
            slotValues.append(slot.value)
        }
        for var index = 0; (slotRow.count - index) > 2; index++ {
            if slotValues[index] == slotValues[index + 1] - 1 && slotValues[index + 1] == slotValues[index + 2] - 1 {
                result = true
            } else if slotValues[index] == slotValues[index + 1] + 1 && slotValues[index + 1] == slotValues[index + 2] + 1 {
                result = true
            }
        }
        
        return result
    }
}