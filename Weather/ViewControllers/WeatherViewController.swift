//
//  ViewController.swift
//  Weather
//
//  Created by Николай Щербаков on 05.07.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 34)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
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
//
//    let button1: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        var configuration = UIButton.Configuration.plain()
//        configuration.title = "Buttonweather"
//        button.configuration = configuration
//        return button
//    }()
    
    var viewModel: WeatherViewModel
    var remoteManager = RemoteDataManager()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
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
//        configureCityLabel()
//        configureTempLabel()
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
        cityLabel.text = viewModel.getCity().city
        weatherStackView.addArrangedSubview(cityLabel)
    }
    
    private func configureTempLabel() {
        tempLabel.text = viewModel.getTemp()
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
    
    @objc private func updateInterface() {
        DispatchQueue.main.async {
            UIView.transition(with: self.backgroundView, duration: 0.5, options: .transitionCrossDissolve) {
                self.backgroundView.image = UIImage(named: self.viewModel.getBackgroundTitle())
            }
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

