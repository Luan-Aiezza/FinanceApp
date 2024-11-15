import SwiftUI

struct ProfileChildPicker: View {
    // Estado de seleção do Picker
    @ObservedObject var viewModel: ProfileChildViewModel

    var body: some View {
//        VStack {
            HStack(spacing: 20) {
                ForEach(PickerOptions.allCases) { option in
                    Text(option.rawValue)
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                        .padding(.vertical, 4)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(viewModel.actualView == option ? Color.white : Color.clear)
                        .foregroundColor(viewModel.actualView == option ? Color.black : Color.white)
                        .clipShape(Capsule())
                        .onTapGesture {
                            viewModel.actualView = option
                            viewModel.fetch()
                        }
                }
            }
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color(red: 0.36, green: 0, blue: 0.55))
            .clipShape(.rect(cornerRadius: 24.0))
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.25, green: 0, blue: 0.39))
                    .offset(x:0, y: 6)
                )
//            .padding(.top, 16)
        }
//    }
}
