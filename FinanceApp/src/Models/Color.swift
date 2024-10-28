import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "B991CD"))
            .ignoresSafeArea()
    }
}
