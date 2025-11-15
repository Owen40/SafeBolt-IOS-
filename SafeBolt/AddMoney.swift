//
//  AddMoney.swift
//  SafeBolt
//
//  Created by mac on 11/15/25.
//
import SwiftUI

struct AddMoneyView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var card: Card
    var onSave: () -> Void
    
    @State private var amountString: String = ""
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Text("Add Money to Card")
                        .font(.title2.bold())
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Current Balance")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(formatter.string(from: NSNumber(value: card.balance)) ?? "$0.00")
                        .font(.title.bold())
                    Text("Card: ...\(card.cardNumber.suffix(4))")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 20) {
                    GlassTextField(title: "Amount to Add", text: $amountString)
                        .keyboardType(.decimalPad)
                }
                
                Spacer()
                
                AppButton(title: "Confirm Deposit") {
                    if let amount = Double(amountString) {
                        card.balance += amount
                        onSave()
                        dismiss()
                    }
                }
                .disabled(Double(amountString) == nil || (Double(amountString) ?? 0) <= 0)
                .opacity(Double(amountString) == nil || (Double(amountString) ?? 0) <= 0 ? 0.6 : 1.0)
            }
            .padding(25)
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
        }
    }
}
