//
//  WordLists.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-26.
//

import Foundation

class WordLists {
    // Singleton.
    static let shared = WordLists()
    
    // Initialise default lists for different difficulty levels.
    private init() {
        easyWordPairList.append(WordPair(english: "cat", swedish: "katt"))
        easyWordPairList.append(WordPair(english: "dog", swedish: "hund"))
        easyWordPairList.append(WordPair(english: "mouse", swedish: "mus"))
        easyWordPairList.append(WordPair(english: "horse", swedish: "häst"))
        easyWordPairList.append(WordPair(english: "goat", swedish: "get"))
        easyWordPairList.append(WordPair(english: "shark", swedish: "haj"))
        easyWordPairList.append(WordPair(english: "cow", swedish: "ko"))
        easyWordPairList.append(WordPair(english: "rat", swedish: "råtta"))
        easyWordPairList.append(WordPair(english: "sheep", swedish: "får"))
        easyWordPairList.append(WordPair(english: "guinea pig", swedish: "marsvin"))
        
        mediumWordPairList.append(WordPair(english: "faucet", swedish: "kran"))
        mediumWordPairList.append(WordPair(english: "bookshelf", swedish: "bokhylla"))
        mediumWordPairList.append(WordPair(english: "question", swedish: "fråga"))
        mediumWordPairList.append(WordPair(english: "parcel", swedish: "paket"))
        mediumWordPairList.append(WordPair(english: "query", swedish: "förfrågan"))
        mediumWordPairList.append(WordPair(english: "toaster", swedish: "brödrost"))
        mediumWordPairList.append(WordPair(english: "charger", swedish: "laddare"))
        mediumWordPairList.append(WordPair(english: "computer", swedish: "dator"))
        mediumWordPairList.append(WordPair(english: "chair", swedish: "stol"))
        mediumWordPairList.append(WordPair(english: "sheets", swedish: "lakan"))
        
        hardWordPairList.append(WordPair(english: "precipice", swedish: "stup"))
        hardWordPairList.append(WordPair(english: "accountant", swedish: "revisor"))
        hardWordPairList.append(WordPair(english: "solicitor", swedish: "jurist"))
        hardWordPairList.append(WordPair(english: "subpoena", swedish: "stämning"))
        hardWordPairList.append(WordPair(english: "associate", swedish: "kollega"))
        hardWordPairList.append(WordPair(english: "evaluate", swedish: "utvärdera"))
        hardWordPairList.append(WordPair(english: "constitute", swedish: "utgöra"))
        hardWordPairList.append(WordPair(english: "distinguish", swedish: "skilja"))
        hardWordPairList.append(WordPair(english: "liberty", swedish: "frihet"))
        hardWordPairList.append(WordPair(english: "heresy", swedish: "kätteri"))
    }
    
    // Lists for different difficulty levels.
    var easyWordPairList: [WordPair] = []
    var mediumWordPairList: [WordPair] = []
    var hardWordPairList: [WordPair] = []
}
