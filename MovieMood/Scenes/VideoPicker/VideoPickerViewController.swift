//
//  VideoPickerViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.09.2023.
//

import UIKit

@MainActor
protocol VideoPickerView: AnyObject {
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<Int, AnyHashable>)
}

final class VideoPickerViewController: BaseViewController<VideoPickerPresenter> {

    // MARK: - IBOutlets -
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            dataSource = .init(tableView: tableView)
            VideoPickerTableViewCell.xibRegister(in: tableView)
            tableView.delegate = self
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
        }
    }
    
    // MARK: - Variables -
    private var dataSource: VideoPickerDataSource?
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.perform(action: .viewDidLoad)
    }
}

extension VideoPickerViewController: VideoPickerView {
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<Int, AnyHashable>) {
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension VideoPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.perform(action: .itemDidTap(index: indexPath.row))
    }
}

private extension VideoPickerViewController {

}
