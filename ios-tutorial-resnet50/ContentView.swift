import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("柴犬です")
                .padding()
                .font(.title)
            Image("shiba")
                .resizable()
                .frame(width: 300, height: 200)
            Button(action: {
            }, label: {
                Text("この画像は何だろう？")
                    .padding()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
