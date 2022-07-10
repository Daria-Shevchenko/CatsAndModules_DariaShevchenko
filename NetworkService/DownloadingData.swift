//
//  DownloadingData.swift
//  CatsAndModules_DariaShevchenko
//
//  Created by Daria Shevchenko on 17.06.2022.
//

import Combine
import Foundation

public final class DownloadingData: ObservableObject {
    var url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=50")
    var cancellables = Set<AnyCancellable>()
    
    @Published public var animals: [Animal] = []
    
    public init() {
        url = getUrl()
        getData()
    }
    
    func getData() {
        Task {
            try await fetch(url!)
                .sink(
                    receiveCompletion: { print($0) },
                    receiveValue: { [weak self] data in
                        self?.animals = data
                    })
                .store(in: &cancellables)
        }
    }

    func getUrl() -> URL {
        let animalType = readPropertyList() == "CATS" ? "cat" : "dog"
        return URL(string: "https://api.the\(animalType)api.com/v1/images/search?limit=50")!
    }
    
    func request() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return config
    }
//    exportOptions
    func readPropertyList() -> String {
        var format = PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        let plistPath: String? = Bundle.main.path(forResource: "CatsAndModules-DariaShevchenko-Info", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML,
                                                                   options: .mutableContainersAndLeaves,
                                                                   format: &format)
                as! [String: AnyObject]
        } catch {
            print("Error reading plist: \(error), format: \(format)")
        }
        return plistData["Data"] as? String ?? "CATS"
    }
    
    func fetch(_ url: URL) async throws -> AnyPublisher<[Animal], NetworkError> {
        return URLSession(configuration: request())
            .dataTaskPublisher(for: url)
            .mapError { NetworkError.request(requestError: $0) }
            .map(\.data)
            .flatMap {
                Just($0)
                    .decode(type: [Animal].self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .mapError { NetworkError.unableToDecode(underlyingError: $0) }
            }
            .eraseToAnyPublisher()
    }
}
