//
//  NotificationsView.swift
//  SafeBolt
//
//  Created by mac on 11/9/25.
//
import SwiftUI

struct WalletView: View {
    @State private var cards: [Card] = []
    @State private var selectedCardIndex = 0
    
    @State private var isAddingCard = false
    @State private var isCustomizingCard = false
    @State private var isAddingMoney = false
    
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                            // Header
                            HStack {
                                Text("My Wallet")
                                    .font(.title2.bold())
                                Spacer()
                                // This button opens the Add Card sheet
                                Button(action: { isAddingCard = true }) {
                                    Image(systemName: "plus")
                                        .font(.title2.bold())
                                        .foregroundColor(themeBrown)
                                }
                            }
                            .padding(.horizontal)
                            
                            // --- Card Carousel ---
                            if cards.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("No cards found.")
                                        .font(.headline)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text("Tap the '+' to add your first card.")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.5))
                                    Spacer()
                                }
                            } else {
                                TabView(selection: $selectedCardIndex) {
                                    ForEach(cards.indices, id: \.self) { index in
                                        CardView(card: cards[index])
                                            .padding(.horizontal, 20)
                                            .tag(index)
                                            .onTapGesture {
                                                // Open customize sheet
                                                selectedCardIndex = index
                                                isCustomizingCard = true
                                            }
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                .frame(height: 250) // Set a fixed height for the carousel
                            }

                            // --- Action Buttons ---
                            VStack(spacing: 15) {
                                HStack(spacing: 15) {
                                    CardActionButton(title: "Settings", icon: "slider.horizontal.3", enabled: !cards.isEmpty)
                                    CardActionButton(title: "Add Money", icon: "plus.circle.fill", enabled: !cards.isEmpty)
                                }
                                HStack(spacing: 15) {
                                    CardActionButton(title: "View PIN", icon: "eye.fill", enabled: !cards.isEmpty)
                                    CardActionButton(title: "Freeze", icon: "snow", enabled: !cards.isEmpty)
                                }
                            }
                            .padding(.horizontal)
                            
                            Spacer() // Pushes content up
                        }
                        .padding(.top, 20)
                        .foregroundColor(.white)
        }
        .onAppear {
            loadCards()
        }
        .sheet(isPresented: $isAddingCard) {
            AddCardView { newCard in
                            // This is the callback when a new card is created
                            cards.append(newCard)
                            CardStorage.shared.saveCards(cards)
                            selectedCardIndex = cards.count - 1 // Select the new card
                        }
            
        }
        .sheet(isPresented: $isCustomizingCard) {
                    // We pass a binding to the selected card
            if selectedCardIndex < cards.count {
                CustomizeCardView(
                    card: $cards[selectedCardIndex],
                    onSave: { updatedCard in
                        cards[selectedCardIndex] = updatedCard
                        CardStorage.shared.saveCards(cards)
                    },
                    onDelete: {
                        deleteCard()
                    }
                )
                }
            }
        
        .sheet(isPresented: $isAddingMoney) {
            if selectedCardIndex < cards.count {
                AddMoneyView(card: $cards[selectedCardIndex]) {
                    saveCards()
                }
            }
        }
    }
    
    func loadCards() {
        self.cards = CardStorage.shared.loadCards()
    }
    
    func deleteCard() {
        guard selectedCardIndex < cards.count else { return }
        
        cards.remove(at: selectedCardIndex)
//        CardStorage.shared.saveCards(cards)
        saveCards()
        
        if selectedCardIndex >= cards.count && !cards.isEmpty {
            selectedCardIndex = cards.count - 1
        }
    }
    func saveCards() {
        CardStorage.shared.saveCards(cards)
    }
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(card.purpose.rawValue)
                    .font(.caption.bold())
                    .textCase(.uppercase)
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                Text(card.cardType.rawValue)
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .italic()
//                Image(systemName: "bolt.shield.fill") // App Logo
//                    .font(.title2)
            }
            
            Spacer()
            
            Text(card.balance, format: .currency(code: "KES"))
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, -10)
            
            Text(card.cardNumber)
                .font(.system(size: card.cardType == .amex ? 20 : 22, weight: .bold, design: .monospaced))
                .shadow(radius: 1, y: 1)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("CARD HOLDER")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(.white.opacity(0.7))
                    Text(card.cardholderName)
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("EXPIRES")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(.white.opacity(0.7))
                    Text(card.expiryDate)
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                }
                VStack(alignment: .leading) {
                    Text("CVV")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(.white.opacity(0.7))
                    Text(card.cvv)
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                }
            }
        }
        .foregroundColor(.white)
        .padding(20)
        .frame(height: 220)
        .background(card.gradient)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 10, y: 10)
    }
}

struct CardActionButton: View {
    var title: String
    var icon: String
    var enabled: Bool = true
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white.opacity(0.05))
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white.opacity(0.1), lineWidth: 1))
            .cornerRadius(12)
        }
        .disabled(!enabled)
        .foregroundColor(enabled ? .white : .gray.opacity(0.5))
    }
}
