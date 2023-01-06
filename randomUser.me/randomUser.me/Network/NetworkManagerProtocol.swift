//
//  NetworkProtocol.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 25/09/2022.
//

import RxSwift

protocol NetworkManagerProtocol: AnyObject {
    func requestRandomUsers(amount: Int) -> Single<[User]>
}
