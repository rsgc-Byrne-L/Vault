//
//  Vigenere.swift
//  Vault
//
//  Created by Liam Byrne on 2017-04-05.
//  Copyright © 2017 Liam Byrne. All rights reserved.
//

import Foundation

fileprivate extension String {
    subscript(i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var key = "hey"
var keySize = key.characters.count
var encryptedText = ""
var index = 0

    func vEncrypt(plainText: String) -> String {
        
        for character in plainText.uppercased().characters {
            let indexInAlphabet = indexOfAlphabet(forCharacter: character)
            
            if indexInAlphabet == -1 {
                encryptedText.append(character)
                continue
            }
            
            let keyToEncryptWith = key[index % keySize]
            let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
            let encryptedLetterIndex = (indexInAlphabet + keyIndexInAlphabet + 25) % 25
            encryptedText.append(alphabet[encryptedLetterIndex])
            index += 1
        }
        
        return encryptedText
    }
    
    private func indexOfAlphabet(forCharacter character: Character) -> Int {
        var index = 0
        
        for chr in alphabet.characters {
            if chr == character {
                return index
            }
            index += 1
        }
        
        return -1
    }
