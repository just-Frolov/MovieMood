//
//  VideoPickerPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.09.2023.
//

import UIKit

enum VideoPickerAction {
    case viewDidLoad
    case itemDidTap(index: Int?)
}

protocol VideoPickerPresenter: AnyObject {
    func perform(action: VideoPickerAction)
}

final class VideoPickerPresenterImpl {
    
    // MARK: - Variables -
    private weak var view: VideoPickerView?
    private var viewStateFactory: VideoPickerViewStateFactory
    private var movieVideoList: [MovieVideo]
    
    // MARK: - Life Cycle -
    init(
        viewStateFactory: VideoPickerViewStateFactory,
        movieVideoList: [MovieVideo]
    ) {
        self.viewStateFactory = viewStateFactory
        self.movieVideoList = movieVideoList
    }
    
    func inject(view: VideoPickerView) {
        self.view = view
    }
}

extension VideoPickerPresenterImpl: VideoPickerPresenter {
    func perform(action: VideoPickerAction) {
        switch action {
        case .viewDidLoad:
            performViewDidLoadAction()
        case .itemDidTap(let index):
            performItemDidTapAction(with: index)
        }
    }
}

private extension VideoPickerPresenterImpl {
    func performViewDidLoadAction() {
        Task {
            let viewState = viewStateFactory.makeViewState(movieVideoList)
            await updateDataSource(viewState: viewState)
        }
    }
    
    func performItemDidTapAction(with index: Int?) {
        // TODO: select delegate
    }
}

private extension VideoPickerPresenterImpl {
    func updateDataSource(viewState: VideoPickerViewState) async {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(viewState.items, toSection: .zero)
       
        await view?.setDataSource(snapshot: snapshot)
    }
}
