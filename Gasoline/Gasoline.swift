//
//  Gasoline.swift
//  BusApp
//
//  Created by REEMOTTO on 25.08.22.
//

import UIKit

// MARK: - Gasoline
struct Gasoline: Codable {
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let gasoline: String
    let currency: String
}

