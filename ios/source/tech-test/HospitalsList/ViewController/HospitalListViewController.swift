//
//  HospitalListViewController.swift
//  tech-test
//
//  Created by Robert Majtan on 05/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import UIKit

class HospitalListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let refreshControl = UIRefreshControl()

    let viewModel = HospitalViewModel()
    var data: [HospitalModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setSubviews()
        setActions()
        setDelegates()
        registerCells()

        getData()
    }

    // MARK: - ACTIONS
    func getData() {
        viewModel.getHospitals() { result in
            switch result {
            case .success(let hospitals):
                self.data = []
                self.data = hospitals
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }

    @objc private func refreshData() {
        getData()
        refreshControl.endRefreshing()
    }
}

extension HospitalListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = viewModel.prepareDetailViewController(indexPath: indexPath)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HospitalListViewController {

    // MARK: - SETUP ACTIONS
    func setActions() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    // MARK: - SETUP DELEGATES
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = viewModel
        searchBar.delegate = self
    }

    // MARK: - REGISTER CELLS
    func registerCells() {
        tableView.register(HospitalListCustomCell.self,
                           forCellReuseIdentifier: HospitalListCustomCell.identifier)
    }
}

extension HospitalListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFiltering = false
        self.view.endEditing(true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isFiltering = true
        viewModel.filter(text: searchText)
        searchBar.accessibilityLabel = searchText
        self.tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension HospitalListViewController {

    // MARK: - CONFIGURE UI
    func configureUI() {
        view.backgroundColor = .white
        view.accessibilityIdentifier = "Hospital List View"
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.accessibilityIdentifier = "searchBar"
        searchBar.isAccessibilityElement = true
    }

    // MARK: - SETUP SUBVIEWS
    func setSubviews() {
        tableView.addSubview(refreshControl)
    }
}
