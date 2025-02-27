//
//  MainView.swift
//  Nywordle
//
//  Created by Mohamed Alwakil on 2025-02-27.
//

import SwiftUI

struct MainView: View {

    var body: some View {

        GeometryReader { proxy in
            ZStack {
                Color.black.opacity(0.7).mix(with: .blue, by: 0.3)
                    .ignoresSafeArea()
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem(),GridItem()], alignment: .center, spacing: 0) {

                    ForEach(0..<6) { _ in
                        ForEach(0..<4) { _ in
                            let width = proxy.size.width / 4
                            cellView(width: width)

                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
        }

    }

    @ViewBuilder
    func cellView(width: CGFloat) -> some View {
        Color.white
            .font(.system(size: 60))
            .padding(10)
            .foregroundStyle(.white)
            .background(Rectangle().fill(.black).border(.blue, width: 1))
            .frame(width: width, height: 80)

    }


    @ViewBuilder
    func key() -> some View {
        Text("A")
            .background(.gray.opacity(0.5))
            .foregroundStyle(.white)
            .bold()
            .frame(width: 50, height: 50)
    }
}

#Preview {
    MainView()
}
