//
//  CEffortTag.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 28/10/24.
//

import SwiftUI

struct CEffortTag: View {
    
    var effortType: EffortTypes
    @State var effortColor: Color = Color("EffortLow")
    @State var effortStroke: Color = Color("EffortLowStroke")
    @State var effortColorText: Color = Color("EffortAnyText")
    @State var effortText: String = "LOW EFFORT"
    @State var taskValue: Int
    @State var effortCoinImage: String = ""

    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(effortText)
                .font(
                    Font.custom("Pally-Bold", size: 14)
                        .weight(.medium)
                        .bold()
                )
                .multilineTextAlignment(.center)
                .foregroundColor(effortColorText)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 1, height: 20)
              .background(effortStroke)
            HStack(spacing: 4) {
                Image(effortCoinImage)
                  .frame(width: 16, height: 16)
                Text("\(taskValue)")
                  .font(
                    Font.custom("Pally-Bold", size: 15)
                      .weight(.medium)
                  )
                  .foregroundColor(effortColorText)
            }
            
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(effortColor)
        .cornerRadius(16)
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .inset(by: 0.5)
            .stroke(effortStroke, lineWidth: 1)
        )
        .onAppear(){
            setColorsAndText()
        }
    }
}

#Preview {
    CEffortTag(effortType: .easy, taskValue: 2)
    CEffortTag(effortType: .medium, taskValue: 2)
    CEffortTag(effortType: .hard, taskValue: 2)
}

extension CEffortTag{
    private func setColorsAndText(){
        switch effortType{
        case .easy:
            effortColor = Color("EffortLow")
            effortStroke = Color("EffortLowStroke")
            effortColorText = Color("EffortAnyText")
            effortText = "LOW EFFORT"
            effortCoinImage = "whiteIconCoin"
        case .medium:
            effortColor = Color("EffortMedium")
            effortStroke = Color("EffortMediumStroke")
            effortColorText = Color("EffortMediumText")
            effortText = "MEDIUM EFFORT"
            effortCoinImage = "blackIconCoin2"
        case .hard:
            effortColor = Color("EffortHigh")
            effortStroke = Color("EffortHighStroke")
            effortColorText = Color("EffortAnyText")
            effortText = "HIGH EFFORT"
            effortCoinImage = "whiteIconCoin"
        }
    }
}
