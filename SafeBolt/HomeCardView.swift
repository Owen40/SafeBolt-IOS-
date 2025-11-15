//
//  HomeCardView.swift
//  SafeBolt
//
//  Created by mac on 11/15/25.
//
import SwiftUI

struct HomeCardView: View {
    let card: Card
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    private var formattedBalance: String {
        formatter.string(from: NSNumber(value: card.balance)) ?? "0.00"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Available balance")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    Text("Kes\(formattedBalance)")
                        .font(.system(size: 28, weight: .bold))
                }
                Spacer()
                Image(systemName: "creditcard.fill")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.3))
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Card Number")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))
                Text("**** \(card.cardNumber.suffix(4))")
                    .font(.headline.monospaced())
            }
            Text(card.cardType.rawValue)
                .font(.caption.bold())
                .foregroundColor(.white)
        }
        .padding(20)
        .frame(width: 250, height: 180)
        .background(card.gradient)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
        .foregroundColor(.white)
        
    }
    
}
