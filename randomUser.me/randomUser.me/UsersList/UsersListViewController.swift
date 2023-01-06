//
//  UsersListViewController.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 24/09/2022.
//

import UIKit

final class UsersListViewController: UIViewController, UsersListViewProtocol {
    static func create() -> UsersListViewController {
        let usersListViewController = UsersListViewController()
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        usersListViewController.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        usersListViewController.presenter = UsersListPresenter(view: usersListViewController)
        return usersListViewController
    }

    private enum Constants {
        static let userCellHeight: CGFloat = 60
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, User>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, User>

    private enum Section: Hashable {
        case main
    }

    private var usersData: [User] = [] {
        didSet {
            applySnapshot(animatingDifferences: !oldValue.isEmpty)
        }
    }

    private lazy var diffableDataSource: DataSource = {
        DataSource(collectionView: self.collectionView,
                   cellProvider: { [weak self] (collectionView, indexPath, _) in
            self?.collectionView(collectionView, cellForItemAt: indexPath)
        })
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()

    private let headerView = HeaderView().prepareForAutoLayout()
    private var collectionView: UICollectionView!

    private var presenter: UsersListPresenter!
    private var isLoading = false

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white
        view.addSubview(headerView)
        headerView.autoSetTopSpace(useSafeAreas: true)
        headerView.autoFitHorizontally()

        view.addSubview(collectionView)
        collectionView.autoSetTopSpace(12, toView: headerView)
        collectionView.autoFitHorizontally()
        collectionView.autoSetBottomSpace(8, useSafeAreas: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCellFromClass(UserCollectionViewCell.self)
        collectionView.addSubview(refreshControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    private func applySnapshot(animatingDifferences: Bool) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(usersData)
        diffableDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    // MARK: UsersListViewProtocol
    func setup(with data: UserListViewData.Setup) {
        headerView.setup(title: data.headerTitle)
    }

    func configure(with data: UserListViewData.Configure) {
        headerView.configure(subtitle: data.headerSubtitle)
    }

    func refresh(with users: [User]) {
        usersData = users
    }

    func appendNewUsers(_ newUsers: [User]) {
        usersData = usersData + newUsers
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.isLoading = false
        }
    }

    func startRefreshing() {
        refreshControl.beginRefreshing()
        collectionView.setContentOffset(CGPoint(x: 0,
                                                y: collectionView.contentOffset.y - (refreshControl.frame.size.height)),
                                        animated: true)
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }

    // MARK: Pull to refresh
    @objc private func pullToRefreshAction() {
        presenter.refreshRandomUsers()
    }
}

// MARK: UICollectionViewDataSource
extension UsersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        usersData.count
    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserCollectionViewCell = collectionView.dequeueReusable(for: indexPath)

        cell.configure(with: usersData[indexPath.row])
        return cell
    }


    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == usersData.count - 5, !isLoading {
            isLoading = true
            presenter.fetchMoreRandomUsers()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension UsersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width, height: Constants.userCellHeight)
    }
}
