//
//  MainView.swift
//  Nywordle
//
//  Created by Mohamed Alwakil on 2025-02-27.
//

import SwiftUI

enum CellState {
    case filled
    case empty
    case wrong
    case correct
    case almostCorrect
}

struct CellValue: Identifiable, Hashable {
    var id = UUID.init().uuidString
    var value: String
    var state: CellState = .empty
}

struct MainView: View {

    @Environment(AppState.self) var appState

    var answer = ["F","I","N","C","H"]

    @State var row: Int = 0
    @State var column: Int = 0
    @State var words = createCells()

    var body: some View {

        GeometryReader { proxy in
            ZStack {
                appState.theme.background
                    .ignoresSafeArea()

                VStack {

                    headerView()

                    LazyVGrid(columns: [GridItem(),GridItem(),GridItem(),GridItem(),GridItem()], alignment: .center, spacing: 0) {

                        ForEach(words, id: \.self) { word in

                            ForEach(word, id: \.id) {cellValue in
                                let width = proxy.size.width / 5
                                cellView(cell: cellValue ,width: width)
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
    func cellView(cell: CellValue, width: CGFloat) -> some View {

        cellColor(cell.state)
            .font(.system(size: 60))
            .padding(8)
            .foregroundStyle(.black)
            .frame(width: width, height: 80)
            .overlay {
                Text(cell.value)
                    .font(.system(size: 36))
            }
    }

    func cellColor(_ state: CellState) -> Color {
        switch state {
        case .correct:
            return .green
        case .wrong:
            return .gray
        case .almostCorrect:
            return .yellow
        case .empty:
            return appState.theme.accentColor
        case .filled:
            return appState.theme.accentColor
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
        LazyVGrid(columns: Array.init(repeating: GridItem(.flexible(minimum: 10, maximum: 200)), count: 8),spacing: 5) {

            ForEach(alphabets, id: \.self) { char in
                key(char: char)
            }
        }
    }

    @ViewBuilder
    func key(char: String) -> some View {
        Text("\(char)")
            .padding()
            .background(appState.theme.tileBody)
            .foregroundStyle(.white)
            .bold()
            .frame(width: 100)
            .onTapGesture {

                guard row < 6
                else { return }

                if char == "🔙" , column > 0{
                    column -= 1
                    words[row][column].value = ""
                    words[row][column].state = .empty
                }
                if column < 5{
                    if (char != "🔙" && char != "Enter") {

                        words[row][column].value = char
                        words[row][column].state = .filled

                        column += 1
                    }
                }

                else if char == "Enter" {

                    // check the entered word is a valid word
                    let enteredWord = words[row].reduce("") { $0 + $1.value }
                    guard validWords.contains(enteredWord.lowercased())
                    else { return }

                    words[row].enumerated().forEach { index, cellValue  in
                        print(index,cellValue.value)
                        if let answerIndex = answer.firstIndex(of: cellValue.value) {

                            words[row][index].state = answerIndex == index ? .correct : .almostCorrect
                        }
                        else {
                            words[row][index].state = .wrong
                        }
                    }

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

    @ViewBuilder
    private func headerView() -> some View {

        HStack {
            Spacer()

            Menu.init(content: {
                Section("Select a theme") {
                    Button("Green") {
                        withAnimation {
                            appState.theme = .green
                        }
                    }

                    Button("Indigo") {
                        withAnimation {
                            appState.theme = .indigo
                        }
                    }

                    Button("Gray") {
                        withAnimation {
                            appState.theme = .gray
                        }
                    }

                    Button("Earth") {
                        withAnimation {
                            appState.theme = .earth
                        }
                    }
                }
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .frame(width: 44, height: 44)
            })
            .buttonStyle(.plain)

        }
    }
}

#Preview {
    MainView()
}
