//
//  Network.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 25/09/2022.
//

import RxSwift
import RxCocoa

final class NetworkManager: NetworkManagerProtocol {
    static let shared: NetworkManager = .create()

    private static func create(urlSession: URLSession = URLSession.shared) -> NetworkManager {
        .init(urlSession: urlSession)
    }

    private let urlSession: URLSession
    private let baseURL = URL(string: "https://randomuser.me/")!
    private let endpoint = "api"

    private init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    // MARK: NetworkProtocol
    func requestRandomUsers(amount: Int) -> Single<[User]> {
        guard let pathUrl = URL(string: endpoint, relativeTo: baseURL) else {
            return .error(AppError.cannotCreateURLPath("\(baseURL)\(endpoint)"))
        }

        let queryItems = [URLQueryItem(name: "results", value: String(amount))]
        guard var components = URLComponents(url: pathUrl, resolvingAgainstBaseURL: true) else {
            return .error(AppError.cannotCreateURL(pathUrl.absoluteString))
        }
        components.queryItems = queryItems
        guard let url = components.url else { return .error(AppError.cannotCreateURL("\(pathUrl.absoluteString) \(pathUrl)")) }

        return urlSession
            .rx.data(request: URLRequest(url: url))
            .map(decodedUsers).asSingle()
    }

    // MARK: Private
    private func decodedUsers(data: Data) throws -> [User] {
        let users = try JSONDecoder().decode(UsersModel.self, from: data)
        return users.results
    }
}
