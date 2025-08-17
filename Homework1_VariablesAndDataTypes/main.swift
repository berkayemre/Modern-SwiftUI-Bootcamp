//
//  main.swift
//  Homework1_VariablesAndDataTypes
//
//  Created by Berkay Emre Aslan on 17.08.2025.
//

import Foundation

let name: String = "Berkay Emre Aslan"
let age: Int = 23
let height: Double = 1.81
let weight: Double = 72.5
let isGraduate: Bool = true
let isMilitaryServiceCompleted: Bool = true
let isMarried: Bool = false


var phoneNumber: String? = "0555 xxx xx xx"
var email: String?

if let safePhone = phoneNumber {
    print("Telefon: \(safePhone)")
} else {
    print("Telefon numarası yok")
}

if let safeEmail = email {
    print("E-posta: \(safeEmail)")
} else {
    print("E-posta adresi girilmemiş")
}

print("Ad Soyad: \(name)")
print("Yaş : \(age)")
print("Boy : \(height)")
print("Kilo : \(weight)")
print("Mezun mu? : \(isGraduate)")
print("Askerlik yapıldı mı? : \(isMilitaryServiceCompleted)")
print("Evli mi? : \(isMarried)")

