//
//  Cat.swift
//  NetworkService
//
//  Created by Daria Shevchenko on 17.06.2022.
//

import Foundation
import SwiftUI

public struct Animal: Identifiable, Codable {
    public let id: String
    public let url: String
    public let width: Int?
    public let height: Int?
}
