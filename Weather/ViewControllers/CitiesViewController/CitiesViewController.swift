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
        let textField = TextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
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
        setupObserver()
        configureView()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.filter(with: text)
            citiesTableView.reloadData()
        }
    }
    
    private func setupObserver() {
        let notificationName = "CitiesDataLoaded"
        viewModel.setNotificationName(notificationName)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateInterface), name: Notification.Name(notificationName), object: nil)
    }
    
    private func configureView() {
        view.backgroundColor = .clear
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: viewModel.isNight ? UIBlurEffect.Style.dark : UIBlurEffect.Style.light))
        let textFieldBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: viewModel.isNight ? UIBlurEffect.Style.light : UIBlurEffect.Style.dark))
        textFieldBlurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
        view.addSubview(textFieldBlurEffectView)
        view.addSubview(searchTextField)
        view.addSubview(citiesTableView)
        
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.clipsToBounds = true
        textFieldBlurEffectView.layer.cornerRadius = 8
        textFieldBlurEffectView.clipsToBounds = true
        searchTextField.layer.cornerRadius = 8
        citiesTableView.layer.cornerRadius = 8
        
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        citiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let horizontalPadding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            textFieldBlurEffectView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
            textFieldBlurEffectView.topAnchor.constraint(equalTo: searchTextField.topAnchor),
            textFieldBlurEffectView.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            textFieldBlurEffectView.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            
            citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            citiesTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 12),
            citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blurEffectView.leadingAnchor.constraint(equalTo: citiesTableView.leadingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: citiesTableView.topAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: citiesTableView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: citiesTableView.bottomAnchor)
        ])
    }
    
    @objc private func updateInterface() {
        DispatchQueue.main.async {
            if let text = self.searchTextField.text {
                self.viewModel.filter(with: text)
                self.citiesTableView.reloadData()
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowSelected(indexPath.row)
        delegate?.dismissAction()
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        cell.backgroundColor = .clear
        config.textProperties.color = viewModel.isNight ? .white : .black
        config.text = viewModel.filtered[indexPath.row]
        cell.contentConfiguration = config
        return cell
    }
}
