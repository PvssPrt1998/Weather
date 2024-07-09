//
//  ViewController.swift
//  Weather
//
//  Created by Николай Щербаков on 05.07.2024.
//

import UIKit

protocol WeatherViewControllerNavigationDelegate: AnyObject {
    func cityButtonPressed(_ parentViewController: WeatherViewController, onDismiss: @escaping ()->Void)
}

final class WeatherViewController: UIViewController {
    
    weak var delegate: WeatherViewControllerNavigationDelegate?
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 34)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96, weight: .thin)
        return label
    }()
    
    let weatherTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 67/255.0, alpha: 0.6)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()

    let changeCityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "location.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))
        button.configuration = configuration
        return button
    }()
    
    var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel, delegate: WeatherViewControllerNavigationDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupObserver()
        configureView()
    }
    
    private func setupObserver() {
        let notificationName = "DataLoaded"
        viewModel.setNotificationName(notificationName)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateInterface), name: Notification.Name(notificationName), object: nil)
    }
    
    private func configureView() {
        setViewBackgroundWith(imageTitle: viewModel.getBackgroundTitle(), animated: false)
        configureBackgroundView()
        configureWeatherStackView()
        configureChangeCityButton()
    }
    
    private func configureWeatherStackView() {
        view.addSubview(weatherStackView)
        configureCityLabel()
        NSLayoutConstraint.activate([
            weatherStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
    }
    
    private func configureBackgroundView() {
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            view.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            view.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
    }
    
    private func configureCityLabel() {
        cityLabel.text = viewModel.getCity()
        cityLabel.textColor = viewModel.isNight() ? .white : .black
        weatherStackView.addArrangedSubview(cityLabel)
    }
    
    private func configureTempLabel() {
        tempLabel.text = viewModel.getTemp()
        tempLabel.textColor = viewModel.isNight() ? .white : .black
        weatherStackView.addArrangedSubview(tempLabel)
    }
    
    private func configureWeatherTypeLabel() {
        weatherTypeLabel.text = viewModel.getWeatherType()
        weatherTypeLabel.layer.shadowColor = UIColor.white.cgColor
        weatherTypeLabel.layer.shadowRadius = 0.7
        weatherTypeLabel.layer.shadowOpacity = 0.5
        weatherTypeLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        weatherTypeLabel.layer.masksToBounds = false
        weatherStackView.addArrangedSubview(weatherTypeLabel)
    }
    
    private func configureChangeCityButton() {
        view.addSubview(changeCityButton)
        changeCityButton.addTarget(self, action: #selector(changeCityButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            view.layoutMarginsGuide.bottomAnchor.constraint(equalTo: changeCityButton.bottomAnchor, constant: 20),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: changeCityButton.trailingAnchor, constant: 20)
        ])
    }
    
    @objc private func changeCityButtonAction() {
        delegate?.cityButtonPressed(self) { [weak self] in
            self?.viewModel.updateData()
        }
    }
    
    @objc private func updateInterface() {
        view.setNeedsLayout()
        DispatchQueue.main.async {
            UIView.transition(with: self.backgroundView, duration: 0.5, options: .transitionCrossDissolve) {
                self.backgroundView.image = UIImage(named: self.viewModel.getBackgroundTitle())
            }
            self.cityLabel.text = self.viewModel.getCity()
            self.configureTempLabel()
            self.configureWeatherTypeLabel()
        }
    }
    
    private func setViewBackgroundWith(imageTitle: String, animated: Bool) {
        if animated {
            UIView.transition(with: backgroundView, duration: 0.75, options: .transitionCrossDissolve) {
                self.backgroundView.image = UIImage(named: imageTitle)
            }
        } else {
            backgroundView.image = UIImage(named: imageTitle)
        }
    }
}

