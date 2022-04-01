//
//  ContentView.swift
//  BTCConverter
//
//  Created by Stanislav Rassolenko on 4/1/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var manager = APIManager()
    @State var currency: String = "CAD"

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Color.mint

                VStack(alignment: .center) {
                    Image(Constants().appLogo)
                        .resizable()
                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5, alignment: .center)
                    Text(Constants().selectCurrencyText)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Picker(Constants().pickerText, selection: $currency) {
                        ForEach(manager.currencies, id: \.self) {
                            Text($0)
                                .foregroundColor(.white)
                        }
                        .onAppear {
                            manager.getCoinValue(for: currency)
                        }
                        .onChange(of: currency) { newValue in
                            manager.getCoinValue(for: newValue)
                        }
                    }
                    .pickerStyle(.wheel)
                    Spacer()
                        .frame(width: 0, height: geometry.size.height / 15)
                    Text("\(Constants().btcEqualsText) \(self.manager.stringPrice ?? "0") \(currency)")
                        .background(RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundColor(.gray
                                                            .opacity(0.5))
                                        .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
                                        .frame(height: geometry.size.height / 15, alignment: .center))

                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
