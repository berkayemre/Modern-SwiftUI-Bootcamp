//
//  main.swift
//  Homework2_FunctionsAndClosures
//
//  Created by Berkay Emre Aslan on 19.08.2025.
//

import Foundation


/// BASIC CALCULATOR

func calculator(_ a: Int, _ b: Int, op: String) -> Int {
    switch op {
        case "topla":
            return a + b
        case "cikar":
            return a - b
        case "carp":
            return a * b
        case "bol":
            return a / b
        default:
            return 0
    }
}

print(calculator(10, 20, op: "topla"))
print(calculator(20, 10, op: "cikar"))
print(calculator(10, 20, op: "carp"))
print(calculator(20, 2, op: "bol"))


/// FILTERING AND SORTING ARRAYS WITH CLOSURE

let numbers = [1, 2, 3, 5, 10, 1020, 164, 201, 302, 10000, 230, 503]

let filtered = numbers.filter { $0 > 300 }
print("300'den büyük sayılar: \(filtered)")

let sortedAsc = filtered.sorted { $0 < $1 }
print("Küçükten büyüğe sırala: \(sortedAsc)")

let sortedDesc = filtered.sorted { $0 > $1 }
print("Büyükten küçüğe sırala: \(sortedDesc)")

let filteredAndSorted = numbers.filter { $0 > 300 }.sorted { $0 < $1 }
print("300'den büyük sayıları küçükten büyüğe sırala:\(filteredAndSorted)")
