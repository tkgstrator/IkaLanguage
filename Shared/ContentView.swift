//
//  ContentView.swift
//  Shared
//
//  Created by devonly on 2021/08/07.
//

import SwiftUI
import Punycode

struct ContentView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State var text: String = "えむいーさん!のコードはUNCODE!"
    @State var encodedMode: Bool = true
    @State var encodedText: String = ""
    var body: some View {
        Form {
            TextField("Hello, World!", text: $text)
            Toggle(isOn: $encodedMode, label: { Text("Encode") })
            Toggle(isOn: $isDarkMode, label: { Text("DarkMode") })
            Button(action: { encodedText = encoded(encodedMode, text) }, label: { Text(encodedMode ? "Encode" : "Decode") })
            Text(encodedText)
                .foregroundColor(.secondary)
        }
    }
    
    @discardableResult
    private func encoded(_ encodedMode: Bool, _ text: String) -> String {
        // 先頭及び末尾の空白文字などを削除
        let replacedText: String = text.trimmingCharacters(in: .whitespacesAndNewlines)
        // Punycode化
        let punycodeText: String = replacedText.components(separatedBy: "!").compactMap({ $0.punycodeEncoded() }).joined(separator: "!")
        return encodeFromJa(from: punycodeText)
    }

    // 一行しかないときはReturnを省略できる
    // 先頭から4行を見て判断
    private func ikaEncode(text: String) -> String {
        text.prefix(4) == "xn--" ? "\(text.prefix(4))" : text
    }
    
    private func encodeFromJa(from text: String) -> String {
        encodedDictionary.reduce(text) { $0.lowercased().replacingOccurrences(of: $1.key, with: $1.value) }
    }
    
    // 英語から日本語への変換用の辞書
    private var encodedDictionary: Dictionary<String, String> = [
        "a": "あ",
        "b": "ん",
        "c": "ま",
        "d": "め",
        "e": "み",
        "f": "うぇ",
        "g": "む",
        "h": "え",
        "i": "い",
        "j": "お",
        "k": "う",
        "l": "な",
        "m": "ぬ",
        "n": "にゅ",
        "o": "の",
        "p": "ぬ",
        "q": "か",
        "r": "け",
        "s": "き",
        "t": "し",
        "u": "そ",
        "v": "る",
        "w": "にゃ",
        "x": "ちぇ",
        "y": "ひ",
        "z": "に",
        "0": "れぃ",
        "1": "とぅ",
        "2": "ら",
        "3": "ぴ",
        "4": "れ",
        "5": "り",
        "6": "わ",
        "7": "て",
        "8": "や",
        "9": "ゆ",
        "-": "っ"
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
