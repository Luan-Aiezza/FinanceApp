import SwiftUI
struct CashBoxCardView: View {
    var goalName: String
    var goalAmount: Float = 0
    var savedAmount: Float
    
    var body: some View {
        VStack(alignment: .center) {
            if savedAmount >= goalAmount {
                Text("Congratulations!")
                    .padding(.bottom, 10)
                    .font(
                        Font.custom("Pally-Bold", size: 22)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                    //.lineSpacing(10)
                
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
                        .cornerRadius(30)
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
                .padding(.bottom, 10) // Add padding to avoid inconsistency in height
                Image("PiggyBankCompleted")
            } else {
                Text(goalName)
                    .font(
                        Font.custom("Pally-Bold", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                HStack {
                    //Image("blackIconCoin")
                    Text("It costs  ")
                        .font(
                            Font.custom("Pally-Regular", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(.cardTextTP)
                    
                    Image("blackIconCoin")
                    
                    Text("\(String(format: "%.0f", goalAmount))")
                        .font(
                            Font.custom("Pally-Regular", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(.cardTextTP)
                    
                    //Image("blackIconCoin")
                }
                
                ProgressView(value: savedAmount, total: goalAmount)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
                
                HStack {
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
                }
                .padding(.bottom, 10) // Uniform bottom padding
                
                Text("You need \(Int(goalAmount - savedAmount)) more coins")
                    .font(
                        Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.cardTextTP)
                
                Image("PiggyBankIncompleted")
            }
        }
        .padding(20)
        .frame(width: 250) // Enforce consistent width
        .background(savedAmount >= goalAmount ? Color("CardPiggybankBackground") : Color(red: 0.94, green: 0.9, blue: 0.95))
        .cornerRadius(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                .offset(x: 0, y: 6)
        )
        .padding(.bottom, 4)
    }
}

