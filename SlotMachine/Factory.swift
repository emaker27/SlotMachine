//
//  Factory.swift
//  SlotMachine
//
//  Created by Elton Nix on 6/10/15.
//  Copyright (c) 2015 Elton Nix. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    class func createSlots() -> [[Slot]] {
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        var slots:[[Slot]] = []
        // slots = [   [slot1, slot2], [slot3, slot4, slot5], [slot6]   ]
        // var mySlotArray = slot[0] = [slot1, slot2]
        // var slot = mySlotArray[1] = slot2
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            var slotArray:[Slot] = []
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                var slot = Slot(value: 0, image: UIImage(named: ""), isRed: true)
                slotArray.append(slot)
            }
            slots.append(slotArray)
        }
        
        return slots
    }
    
    class func createSlot(currentCards: [Slot]) -> Slot {
        var currentCardValues:[Int] = []
        
        for slot in currentCards {
            currentCardValues.append(slot.value)
        }
        
        var randomNumber = Int(arc4random_uniform(UInt32(13)))
        while contains(currentCardValues, randomNumber + 1) {
            randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
        
        let cards = [["Ace", true], ["Two", true], ["Three", true], ["Four", true], ["Five", false], ["Six", false], ["Seven", true], ["Eight", false], ["Nine", false], ["Ten", true], ["Jack", false], ["Queen", false], ["King", true]]
        let slot = Slot(value: randomNumber + 1, image: UIImage(named: cards[randomNumber, 0]), isRed: cards[randomNumber, 1])
        
        return slot
    }
}