//
//  AddCardView.swift
//  SafeBolt
//
//  Created by mac on 11/11/25.
//
import SwiftUI

struct AddCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var cardholderName: String = ""
    @State private var purpose: CardPurpose = .personal
    
    var onAdd: (Card) -> Void // Callback to pass the new card back
    
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                HStack {
                    Text("Create New Card")
                        .font(.title2.bold())
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                
                // Form
                VStack(spacing: 20) {
                    GlassTextField(title: "Cardholder Name", text: $cardholderName)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Card Purpose")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Picker("Card Purpose", selection: $purpose) {
                            ForEach(CardPurpose.allCases) { purpose in
                                Text(purpose.rawValue).tag(purpose)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(.white.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                
                Spacer()
                
                // Create Button
                AppButton(title: "Create Card") {
                    let newCard = Card(
                        cardholderName: cardholderName,
                        purpose: purpose
                    )
                    onAdd(newCard) // Pass the new card back
                    dismiss()
                }
                .disabled(cardholderName.isEmpty)
                .opacity(cardholderName.isEmpty ? 0.6 : 1.0)
            }
            .padding(25)
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
        }
    }
}
