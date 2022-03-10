//
//  ListViewController.swift
//  MapTabBarApp
//
//  Created by Yuliya Martsenko on 14.02.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    var interactor: LocationInteractorOutputProtocol?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Location")
        return table
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let mapViewController = tabBarController?.viewControllers?.first,
//              let tabBarController = tabBarController else {
//            return
//        }
        interactor?.activeLocationIndex = indexPath.row
        tabBarController?.selectedIndex = 0
//        tabBarController(tabBarController, shouldSelect: mapViewController)
//        tabBarController?.showDetailViewController(mapViewController, sender: self)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor?.locations.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Location",
                                                       for: indexPath)
        cell.textLabel?.text = interactor?.locations[indexPath.row].title
        return cell
    }
    
}

extension ListViewController: UITabBarControllerDelegate {
    
}
