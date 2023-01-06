//
//  UsersListViewProtocol.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 25/09/2022.
//

protocol UsersListViewProtocol: AnyObject {
    func setup(with data: UserListViewData.Setup)
    func configure(with data: UserListViewData.Configure)
    func refresh(with users: [User])
    func appendNewUsers(_ users: [User])
    func startRefreshing()
    func endRefreshing()
}
