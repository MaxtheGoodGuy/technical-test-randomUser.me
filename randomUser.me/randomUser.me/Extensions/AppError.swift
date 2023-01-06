//
//  AppError.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

enum AppError: Error {
    case networkError(String)
    case cannotCreateURLPath(String)
    case cannotCreateURL(String)
}
