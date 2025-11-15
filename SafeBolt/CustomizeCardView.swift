//
//  CustomizeCardView.swift
//  SafeBolt
//
//  Created by mac on 11/11/25.
//
import SwiftUI

// MARK: - 14. Customize Card View (Modal Sheet)
struct CustomizeCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var card: Card // Use a Binding to edit the card directly
    
    var onSave: (Card) -> Void // Callback to save changes
    var onDelete: () -> Void
    
    @State private var isShowingDeleteAlert = false
    
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Personalise Your Card")
                        .font(.title2.bold())
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                Text("Give your card a personal touch by changing its color or name.")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                
                // Card Preview
                CardView(card: card)
                    .padding(.vertical)
                
                // Color Picker
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(cardGradients.indices, id: \.self) { index in
                            Button(action: {
                                card.gradientIndex = index
                            }) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(cardGradients[index])
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(card.gradientIndex == index ? themeBrown : .clear, lineWidth: 3)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Form
                GlassTextField(title: "Cardholder Name", text: $card.cardholderName)
                
                Spacer()
                
                // Confirm Button
                AppButton(title: "Confirm Changes") {
                    onSave(card) // Pass the updated card back
                    dismiss()
                }
//                .disabled(card.cardholderName.isEmpty)
//                .opacity(card.cardholderName.isEmpty ? 0.6 : 1.0)
                Button(action: {
                    isShowingDeleteAlert = true
                }) {
                    Text("Delete Card")
                        .font(.headline.bold())
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0.05))
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white.opacity(0.1), lineWidth: 1))
                }
                .padding(.top, 10)
            }
            .padding(25)
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
            .alert("Delete Card?", isPresented: $isShowingDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    onDelete()
                    dismiss()
                }
            } message: {
                Text("Are you sure you want to permanently delete this card? This action cannot be undone.")
            }
        }
    }
}
