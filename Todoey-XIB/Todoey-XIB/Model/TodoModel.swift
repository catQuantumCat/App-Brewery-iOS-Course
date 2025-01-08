//
//  TodoModel.swift
//  Todoey-XIB
//
//  Created by Huy on 8/1/25.
//

import Foundation

struct TodoModel{
    private(set) var title: String
    private(set) var status: Bool

    init(title: String, _ status: Bool?) {
        self.title = title
        self.status = status ?? false
    }
}

extension TodoModel{
    public mutating func toggleStatus(with newStatus: Bool) {
        self.status = newStatus
    }
}
