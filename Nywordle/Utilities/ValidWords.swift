//
//  ValidWords.swift
//  Nywordle
//
//  Created by Mohamed Alwakil on 2025-02-28.
//

import Foundation

func ValidWords() -> [String] {

    do {
        let js = JSONDecoder()
        guard let path = Bundle.main.path(forResource: "WordsList", ofType: "json")
        else { fatalError("failed to load words list") }
        let pathUrl = URL.init(filePath: path)
        let data = try Data.init(contentsOf: pathUrl)
        let list = try js.decode([String].self, from: data)
        return list
    }
    catch {
        fatalError("failed to load words list")
    }
}
