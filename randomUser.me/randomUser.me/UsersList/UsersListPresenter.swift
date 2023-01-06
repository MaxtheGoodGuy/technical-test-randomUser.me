//
//  UsersListPresenter.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 25/09/2022.
//

import RxSwift

final class UsersListPresenter {
    private enum Constants {
        static let usersBaseAmount: Int = 30
        static let usersPreDownloadAmount: Int = 20
    }

    @Inject private var networkManager: NetworkManagerProtocol
    @Inject private var coreDataManager: CoreDataManagerProtocol

    weak var view: UsersListViewProtocol!
    private var usersData: [User] = []

    private let disposeBag = DisposeBag()

    init(view: UsersListViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        view.setup(with: .init(headerTitle: "randomUser.me"))
        refreshRandomUsers()
    }

    func refreshRandomUsers() {
        fetchRandomUsers(amount: Constants.usersBaseAmount)
    }

    func fetchMoreRandomUsers() {
        fetchRandomUsers(amount: Constants.usersPreDownloadAmount, overwriteCurrentUsers: false)
    }

    private func fetchRandomUsers(amount: Int, overwriteCurrentUsers: Bool = true) {
        networkManager.requestRandomUsers(amount: amount)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .observe(on: MainScheduler.instance)
            .do(
                onSubscribe: { [weak self] in
                    self?.view.startRefreshing()
                },
                onDispose: { [weak self] in
                    guard let self = self else { return }
                    self.view.configure(with: .init(headerSubtitle: "Amount of users loaded: \(self.usersData.count)"))
                    self.view.endRefreshing()
                })
                .subscribe(
                    onSuccess: { [weak self] users in
                        guard let self = self else { return }

                        if overwriteCurrentUsers {
                            self.usersData = users
                            self.view.refresh(with: users)
                        } else {
                            self.usersData = self.usersData + users
                            self.view.appendNewUsers(users)
                        }
                        self.coreDataManager.saveUsers(users: self.usersData)
                    },
                    onFailure: { [weak self] error in
                        guard let self = self else { return }

                        if overwriteCurrentUsers {
                            self.usersData = self.coreDataManager.loadUsers()
                            self.view.refresh(with: self.usersData)
                        }
                    })
                .disposed(by: disposeBag)
    }
}
