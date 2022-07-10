//
//  FullImage.swift
//  NetworkService
//
//  Created by Daria Shevchenko on 17.06.2022.
//

import Foundation
import SwiftUI

public struct FullImage: View {
    var url: String

    public init(url: String) {
        self.url = url
    }

    public var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
}
