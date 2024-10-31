import SwiftUI

struct TaskCardSuccess: View {
    @State var task: TaskModel
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            renderTittle()
            renderImage()
            renderDescriptionWithTag()
            
        }
        .padding(24)
        .frame(width: 272, height: 304, alignment: .top)
        .background(Color("CardBG"))
        .cornerRadius(40)
        .shadow(color: Color("CardShadowBG"), radius: 0, x: 0, y: 4)
        
    }
    
    @ViewBuilder
    func renderTag() -> some View {
        HStack(alignment: .center, spacing: 6) {
            Text("+")
              .font(
                Font.custom("Pally Variable", size: 17)
                  .weight(.medium)
              )
              .foregroundColor(Color("CardTextTP"))
            Image("EffortCoinDark")
                .frame(width: 20, height: 20)
            Text("\(task.value.formatted(.number))")
              .font(
                Font.custom("Pally Variable", size: 17)
                  .weight(.medium)
              )
              .foregroundColor(Color("CardTextTP"))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color("DescriptionTagBG"))
        .cornerRadius(24)
        .overlay(
          RoundedRectangle(cornerRadius: 24)
            .inset(by: 0.5)
            .stroke(Color("DescriptionTagST"), lineWidth: 1)
        )
    }
    
    @ViewBuilder
    func renderTittle() -> some View {
        Text("Congratulations!")
          .font(
            Font.custom("Pally Variable", size: 28)
              .weight(.medium)
          )
          .multilineTextAlignment(.center)
          .foregroundColor(Color("CardTextTP"))
          .frame(width: 241, alignment: .center)
    }
    
    @ViewBuilder
    func renderImage() -> some View {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 172, height: 112)
          .background(
            Image("PigTest")
              .resizable()
              .aspectRatio(contentMode: .fit)
          )
    }
    
    @ViewBuilder
    func renderDescriptionWithTag() -> some View {
        VStack(alignment: .center, spacing: 8) {
            Text("You earned")
              .font(
                Font.custom("Pally Variable", size: 17)
                  .weight(.medium)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(Color("CardTextTP"))
              .frame(maxWidth: .infinity, alignment: .center)
            renderTag()
        }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .top)
    }
}

//#Preview{
//    TaskCardSuccess()
//}
