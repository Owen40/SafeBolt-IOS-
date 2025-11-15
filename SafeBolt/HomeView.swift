//
//  NotificationsView.swift
//  SafeBolt
//
//  Created by mac on 11/9/25.
//
import SwiftUI

struct HomeView: View {
    @State private var cards: [Card] = []
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
    private var totalBalance: Double {
        cards.reduce(0) { $0 + $1.balance}
    }
    private var formattedTotalBalance: String {
        formatter.string(from: NSNumber(value: totalBalance)) ?? "0.00"
    }
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        Text("Good Morning!")
                            .font(.title2.bold())
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2.bold())
                                .foregroundColor(themeBrown)
                        }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Total Balance")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.7))
                        Text(formattedTotalBalance)
                            .font(.system(size: 40, weight: .bold))
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 15) {
                            if cards.isEmpty {
                                VStack {
                                    Text("No Cards Found.")
                                        .font(.caption)
                                    Text("Add a card in the wallet tab.")
                                        .font(.caption)
                                }
                                .padding(20)
                                .frame(width: 250, height: 180)
								.background(.white.opacity(0.05))
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.1), lineWidth: 1))
                                .cornerRadius(20)
                            } else {
                                ForEach(cards) { card in
                                    HomeCardView(card: card)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .frame(height: 200)
                    
                    Text("Quick Access")
                        .font(.title2.bold())
                    
                    Spacer()
                }
                .padding(20)
            }
            .foregroundColor(.white)
//            Text("Home View")
//                .font(.title)
//                .foregroundColor(.white)
        }
        .onAppear {
            loadCards()
        }
    }
    
    func loadCards() {
        self.cards = CardStorage.shared.loadCards()
    }
}
