//
//  ContentView.swift
//  API
//
//  Created by Fatima Aljaber on 05/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State var TodayAdvice: String = ""
    var body: some View {
        
        VStack{
            Image("logo").resizable().frame(width: 400,height: 200)
            Text("\(TodayAdvice)").fontWeight(.semibold).foregroundColor(Color.black).multilineTextAlignment(.center).padding([.leading, .bottom, .trailing], 30.0)
            Spacer()
            Button {
                Task {
                    await loadData()
                }
            } label: {
                Text("Today's Advice").bold()
                    .frame(maxWidth: 250,maxHeight: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(.green)
                            .padding(1.8)
                    )
                    .foregroundColor(.white)
            }.padding(.top)
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://api.adviceslip.com/advice") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(adviceAPI.self, from: data) {
                TodayAdvice = decodedResponse.slip.advice
            }
        } catch {
            print("Invalid data")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct adviceAPI: Codable {
    let slip: Slip
}

struct Slip: Codable {
    let id: Int
    let advice: String
}



