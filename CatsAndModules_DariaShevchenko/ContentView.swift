//
//  ContentView.swift
//  CatsAndModules_DariaShevchenko
//
//  Created by Daria Shevchenko on 17.06.2022.
//

import NetworkService
import SwiftUI

struct ContentView: View {
    @StateObject var downloadData = DownloadingData()

    var body: some View {
        NavigationView {
            List {
                ForEach(downloadData.animals, id: \.id) { animal in
                    NavigationLink {
                        FullImage(url: animal.url)
                    } label: {
                        ListItem(url: animal.url)
                    }
                }
            }
            .navigationTitle("Animals")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListItem: View {
    var url: String

    var body: some View {
        HStack {
            FullImage(url: url)
                .frame(width: 128, height: 128)
                .padding()
            Text("\(Randoms.randomFakeName())")
        }
    }
}
