//  
//  AlbumDetailsViewController.swift
//  UserAlbums
//
//  Created by marwa on 1/03/2025.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumDetailsViewController: UIViewController, UISearchBarDelegate {

    // MARK: Outlets
    
    @IBOutlet private(set) weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private(set) weak var imagesCollectionView: UICollectionView!
    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    private var viewModel: AlbumDetailsViewModelType
    private var albumViewModel: AlbumsVM?
    let disposeBag = DisposeBag()

    // MARK: Init

    init(viewModel: AlbumDetailsViewModelType, albumViewModel: AlbumsVM) {
        self.viewModel = viewModel
        self.albumViewModel = albumViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        bindViewModel()
        bindTitle()
        bindSearchBar()
    }
}

// MARK: - setup

extension AlbumDetailsViewController {
    
    func bindTitle() {
        titleLabel.text = albumViewModel?.title
    }
    
    func bindSearchBar() {
        searchBar.delegate = self
        searchBar.rx.text.orEmpty
            .distinctUntilChanged() // Prevent duplicate values
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                self.viewModel.filterData(searchText: query)
            })
            .disposed(by: disposeBag)
    }
    
    func collectionViewSetup() {
        imagesCollectionView.register(ImagesCollectionViewCell.self)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
}

// MARK: - CollectionView

extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImagesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureCell(with: viewModel.getPhoto(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPhotosCount()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }
}

// MARK: - bindViewModel

extension AlbumDetailsViewController {
    
    func bindViewModel() {
        viewModel.onReloadData = { [weak self] data in
            guard let self = self else { return }
            self.imagesCollectionView.reloadData()
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
        
        if let id = albumViewModel?.id {
            viewModel.getPhotos(id)
        }
    }
}
    
