//
//  AutoPasswordManager.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import Foundation

class AutoPasswordManager {
    
    static let shared = AutoPasswordManager()
    
    func generateRandomPassword(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+{}[]|\\:;\"',.<>?/~`"
        let password = String((0..<length).map { _ in characters.randomElement()! })
        return password
    }
}
