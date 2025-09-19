//
//  DateFormatter+Ext.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 19.09.2025.
//

import Foundation

enum DF {
    static let note: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "tr_TR")
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
}
