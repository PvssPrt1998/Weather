//
//  CitiesViewController.swift
//  Weather
//
//  Created by Николай Щербаков on 09.07.2024.
//

import UIKit

protocol CitiesViewControllerNavigationDelegate: AnyObject {
    func dismissAction()
}

final class CitiesViewController: UIViewController {
    
    let viewModel: CitiesViewModel
    weak var delegate: CitiesViewControllerNavigationDelegate?
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: CitiesViewModel, delegate: CitiesViewControllerNavigationDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(searchTextField)
        view.addSubview(citiesTableView)
        
        searchTextField.backgroundColor = .gray
        citiesTableView.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 6),
            citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//extension CitiesViewController: UITableViewDelegate {
//    
//}
//
//extension CitiesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
