//
//  AlbumsViewController.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private(set) weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private(set) weak var albumsTableView: UITableView!
    @IBOutlet private(set) weak var tableViewTitleLabel: UILabel!
    @IBOutlet private(set) weak var userAddressLabel: UILabel!
    @IBOutlet private(set) weak var userNameLabel: UILabel!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    private var viewModel: AlbumsViewModelType
    
    // MARK: Init
    
    init(viewModel: AlbumsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Configurations

extension AlbumsViewController {
    
    func bindUserInfo(_ user: UserVM) {
        userNameLabel.text = user.name
        userAddressLabel.text = "\(user.street), \(user.suite), \(user.city), \(user.zipcode)"
        tableViewTitleLabel.text = "My Albums"
    }
    
    func setupTableView() {
        albumsTableView.rowHeight = UITableView.automaticDimension
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        albumsTableView.register(AlbumsTableViewCell.self)
    }
}

// MARK: - TableView

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAlbumsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(with: viewModel.getAlbum(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlbumDetailsViewController(viewModel: AlbumDetailsViewModel(), albumViewModel: viewModel.getAlbum(at: indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - bind ViewModel

extension AlbumsViewController {
    
    func bindViewModel() {
        
        viewModel.onReloadData = { [weak self] albums, user in
            guard let self = self else { return }
            if let user = user {
                self.bindUserInfo(user)
            }
            self.albumsTableView.reloadData()
        }
        
        viewModel.onShowNetworkErrorAlertClosure = { [weak self] alertMessage in
            guard let self = self else { return }
            self.showToast(message: alertMessage, font: .systemFont(ofSize: 14), textColor: .red, backgroundViewColor: .gray.withAlphaComponent(0.5))
        }
        
        viewModel.onUpdateLoadingStatus = { [weak self] state in
            
            guard let self = self else { return }
            
            switch state {
            case .error:
                activityIndicator.stopAnimating()
            case .loading:
                activityIndicator.startAnimating()
            case .loaded:
                activityIndicator.stopAnimating()
            case .empty:
                print("Empty ---")
            }
        }
        viewModel.getProfileData()
    }
}

