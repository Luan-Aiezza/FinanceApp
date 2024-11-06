//
//  GoalCardView.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 28/10/24.
//

import SwiftUI

struct GoalCardView: View {
    var goalName: String
    var goalAmount: Float
    var savedAmount: Float

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Goal Name and Icon
            HStack {
                Text(goalName)
                    .font(Font.custom("Pally-Bold", size: 24).weight(.medium))
                    .foregroundColor(.cardTextTP)

                
                Spacer()
                
                Text(String(format: NSLocalizedString("Price %@ coincs", comment: ""), String(format: "%.2f", goalAmount)))
                    .font(Font.custom("Pally-Bold", size: 24).weight(.medium))
                    .foregroundColor(.cardTextTP)

            }

            // Coins Needed Status
            HStack {
                Image("CoinsImage")
                    .accessibilityHidden(true) // Decorative image
                
 
            }
            
            Spacer()
            
            // Progress percentage
            HStack {
                Spacer()
                Text(String(format: NSLocalizedString("%@ Progress", comment: ""), "\(Int((savedAmount / goalAmount) * 100))"))
                    .font(Font.custom("Pally-Regular", size: 20).weight(.medium))
                    .foregroundColor(.cardTextTP)
                    
                    
            }
            
            // Progress Bar
            ProgressView(value: savedAmount, total: goalAmount)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
            
            // Saved Amount and Remaining Amount Status
            HStack {
                if savedAmount >= goalAmount {
                    Image(systemName: "checkmark")
                        .accessibilityHidden(true) // Decorative when goal is achieved
                    
                    Text(NSLocalizedString("Congratulations! Goal achieved!", comment: ""))
                        .font(Font.custom("Pally-Bold", size: 20).weight(.medium))
                        .foregroundColor(.cardTextTP)
                        .accessibilityElement() // Treat this Text as a separate accessibility element

                } else {
                    Image("CheckMARK")
                        .accessibilityHidden(true) // Decorative
                    
                    Text(String(format: NSLocalizedString("You have saved %@ coincs by now", comment: ""), String(format: "%.2f", savedAmount)))
                        .font(Font.custom("Pally-Regular", size: 20).weight(.medium))
                        .foregroundColor(.cardTextTP)
                        .accessibilityElement() // Separate this Text for individual reading
                    
                    Spacer()
                    
                    if savedAmount < goalAmount {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .accessibilityHidden(true) // Decorative
                            
                            Text(String(format: NSLocalizedString("You still need %@ coincs to complete", comment: ""), String(format: "%.2f", goalAmount - savedAmount)))
                                .font(Font.custom("Pally-Regular", size: 20).weight(.medium))
                                .foregroundColor(.cardTextTP)
                                .accessibilityElement() // Separate this Text as an individual accessibility element
                        }
                        .accessibilityElement(children: .combine) // Group nested HStack contents if needed
                    }
                }
            }
            .accessibilityElement(children: .ignore) // Prevent VoiceOver from grouping the main HStack

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.94, green: 0.9, blue: 0.95))
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.85, green: 0.76, blue: 0.89))
                .offset(x:0, y: 6)
        )
    }
}
