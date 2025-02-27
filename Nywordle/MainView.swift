//
//  MainView.swift
//  Nywordle
//
//  Created by Mohamed Alwakil on 2025-02-27.
//

import SwiftUI

struct CellValue: Identifiable, Hashable {
    var id = UUID.init().uuidString
    var value: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MainView: View {

    @State var row: Int = 0
    @State var column: Int = 0
    @State var words = createCells()

    var body: some View {

        GeometryReader { proxy in
            ZStack {
                Color.black.opacity(0.7).mix(with: .blue, by: 0.3)
                    .ignoresSafeArea()

                VStack {
                    LazyVGrid(columns: [GridItem(),GridItem(),GridItem(),GridItem(),GridItem()], alignment: .center, spacing: 0) {

                        ForEach(words, id: \.self) { word in

                            ForEach(word, id: \.id) {cellValue in
                                let width = proxy.size.width / 5
                                cellView(char: String(cellValue.value),width: width)

                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    keyboard()
                }
            }
        }

    }

    @ViewBuilder
    func cellView(char: String, width: CGFloat) -> some View {
        Color.white
            .font(.system(size: 60))
            .padding(10)
            .foregroundStyle(.white)
            .background(Rectangle().fill(.black).border(.blue, width: 1))
            .frame(width: width, height: 80)
            .overlay {
                Text(char)
                    .font(.system(size: 36))
            }

    }

    let alphabets: [String] = ["A","B","C","D","E",
                     "F","G","H","I","J",
                     "K","L","M","N","O",
                     "P","Q","R","S","T",
                     "U","V","W","X","Y",
                     "Z","Enter","🔙"]

    @ViewBuilder
    func keyboard() -> some View {
        LazyVGrid(columns: Array.init(repeating: GridItem(), count: 10),spacing: 10) {

            ForEach(alphabets, id: \.self) { char in
                key(char: char)
            }
        }
    }

    @ViewBuilder
    func key(char: String) -> some View {
        Text("\(char)")
            .padding()
            .background(.gray.opacity(0.5))
            .foregroundStyle(.white)
            .bold()
            .frame(width: 100)
            .onTapGesture {

                guard row < 6
                else { return }

                if char == "🔙" , column > 0{
                    column -= 1
                    words[row][column].value = ""

                }
                if column < 5{
                    if (char != "🔙" && char != "Enter") {
                        words[row][column].value = char
                        column += 1
                    }
                }

                else if char == "Enter" {
                    row += 1
                    column = 0
                }

            }
    }

    static func createCells() -> [[CellValue]] {

        return (0..<6).map { _ in
            (0..<5).map { _ in CellValue(value: "") }
        }
    }
}

#Preview {
    MainView()
}
