import SwiftUI

struct CashBoxCardView: View {
    var goalName: String
    var goalAmount: Float = 0
    var savedAmount: Float
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            if savedAmount >= goalAmount {
                // Completed View
                Text("Congratulations!")
                    .font(
                        Font.custom("Pally-Bold", size: 22)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                Text("You completed a piggy bank:")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                Text("'\(goalName)'")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(width: 100, height: 40)
                        .overlay(
                            HStack(spacing: 6) {
                                Image("blackIconCoin")
                                Text("\(String(format: "%.0f", goalAmount))")
                                    .font(
                                        Font.custom("Pally-Bold", size: 20)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.cardTextTP)
                            }
                        )
                }
                
                Image("PiggyBankCompleted")
            } else {
                // In Progress View
                Text(goalName)
                    .font(
                        Font.custom("Pally-Bold", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                HStack(spacing: 6) {
                    
                    Text("It costs   \(String(format: "%.0f", goalAmount))")
                        .font(
                            Font.custom("Pally-Regular", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(.cardTextTP)
                    
                    Image("blackIconCoin")
                }
                
                ProgressView(value: savedAmount, total: goalAmount)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
                
                HStack{
                    Text("\(Int(savedAmount))/\(Int(goalAmount)) coins saved")
                        .font(
                            Font.custom("Pally-Regular", size: 17)
                                .weight(.medium)
                        )
                        .foregroundColor(.cardTextTP)
                    Spacer()
                    Text("\(Int((savedAmount / goalAmount) * 100))%")
                        .font(
                            Font.custom("Pally-Regular", size: 17)
                                .weight(.medium)
                        )
                        .foregroundColor(.cardTextTP)
                }.padding(.bottom)
                
                Text("You need \(Int(goalAmount - savedAmount)) more coins")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                Image("PiggyBankIncompleted")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(savedAmount >= goalAmount ? Color("CardPiggybankBackground") : Color(red: 0.94, green: 0.9, blue: 0.95))
        .cornerRadius(24)
        //.shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 8)
    }
}
