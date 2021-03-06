//
//  ExampleData.swift
//  Team Sports
//
//  Created by Stewart Lynch on 2022-01-01.
//

import Foundation

struct ExampleData: Encodable, Identifiable {
    let id = UUID()
    let name: String
    let image: String
    
    static var examples: [ExampleData] {
        [
            ExampleData(name: "Basketball", image: "π"),
            ExampleData(name: "Soccer", image: "β½οΈ"),
            ExampleData(name: "Rugby", image: "π"),
            ExampleData(name: "Football", image: "π"),
            ExampleData(name: "Tennis", image: "πΎ"),
            ExampleData(name: "Baseball", image: "βΎοΈ"),
            ExampleData(name: "Volleyball", image: "π"),
            ExampleData(name: "Pool", image: "π±")
        ]
    }
    
    static var data: Data? {
        try? JSONEncoder().encode(examples)
    }
}
