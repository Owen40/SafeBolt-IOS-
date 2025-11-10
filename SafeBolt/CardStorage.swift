//
//  CardStorage.swift
//  SafeBolt
//
//  Created by mac on 11/11/25.
//
import SwiftUI

class CardStorage {
    static let shared = CardStorage()
    private let cardsKey = "SafeBolt_Cards"
    
    private init() {}
    
    func saveCards(_ cards: [Card]) {
        do {
            let data = try JSONEncoder().encode(cards)
            UserDefaults.standard.set(data, forKey: cardsKey)
        } catch {
            print("Error saving cards: \(error.localizedDescription)")
        }
    }
    
    func loadCards() -> [Card] {
        guard let data = UserDefaults.standard.data(forKey: cardsKey) else { return [] }
        
        do {
            let cards = try JSONDecoder().decode([Card].self, from: data)
            return cards
        } catch {
            print("Error loading cards: \(error.localizedDescription)")
            return []
        }
    }
}
