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

    private enum Constant {
        static let maxDimmedAlpha: CGFloat = 0.6
        static let defaultHeight: CGFloat = UIScreen.main.bounds.height / 2
    }
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var dimmedView: UIView! {
        didSet {
            dimmedView.alpha = Constant.maxDimmedAlpha
        }
    }
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
        setupViewTapRecognizer()
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
    func setupViewTapRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func viewDidTap(_ gesture: UITapGestureRecognizer) {
        presenter?.perform(action: .itemDidTap(index: nil))
    }
}
