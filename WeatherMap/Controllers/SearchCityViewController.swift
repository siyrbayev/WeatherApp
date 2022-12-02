//
//  SearchCityViewController.swift
//  WeatherMap
//
//  Created by ADMIN ODoYal on 19.05.2021.
//

import UIKit
import Alamofire

class SearchCityViewController: UIViewController {
    
    // MARK: Static properties
    
    static let identifier = "SearchCityViewController"
    static let nib = UINib(nibName: identifier, bundle: Bundle(for: SearchCityViewController.self))
    
    // MARK: Public
    
    public weak var delegate: WeatherMapViewControllerDelegate?
    public var setDayPartBackImageCallBack: (()->String)?
    public var setTypeBackImageCallBack: (()->String)?
    
    // MARK: Private
    
    private let weatherApi = WeatherApi()
    
    // MARK: IBOutlet
    
    @IBOutlet weak private var lableView: UIView!
    @IBOutlet weak private var clearSearchTextFieldButton: UIButton!
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var locationNameTextField: UITextField!
    @IBOutlet weak private var searchButton: UIButton!
    @IBOutlet weak private var dayPartBackImageView: UIImageView!
    @IBOutlet weak private var weatherTypeBackImageView: UIImageView!
    
    // MARK: Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    // MARK: IBAction
    
    @IBAction private func locationNameTextFieldEditing(_ sender: Any) {
        checkClearSearchButton()
    }
    
    @IBAction private func clearSearchTextFieldButtonPressed(_ sender: Any) {
        locationNameTextField.text = ""
        clearSearchTextFieldButton.isHidden = true
        clearSearchTextFieldButton.isEnabled = false
    }
    
    @IBAction private func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func searchButtonPressed(_ sender: Any) {
        if let text = locationNameTextField.text, text != ""{
            searchButton.isEnabled = false
            getCityWeatherByName(name: text)
        }
    }
}

// MARK: Public func

extension SearchCityViewController {}

// MARK: Private func
    
extension SearchCityViewController {
    
    func configureLayout() {
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(searchFieldEndEditing))
        self.view.addGestureRecognizer(tapOnView)
        
        searchButton.layer.cornerRadius = 6
        searchButton.titleLabel?.font = UIFont.ubuntu(16, .bold)
        
        lableView.layer.cornerRadius = 6
        
//        locationNameTextField.font = UIFont.ubuntu(16, .bold)
        
        backButton.imageEdgeInsets = UIEdgeInsets(top: 18, left: 9, bottom: 18, right: 9)
    }
    
    @objc func searchFieldEndEditing() {
        locationNameTextField.endEditing(true)
    }
    
    func getCityWeatherByName(name: String) {
        defer {
            searchButton.isEnabled = true
        }
        AF.request(weatherApi.getHost(with: name), method: .get).responseJSON { [self] response in
            switch response.result {
            case .success(_):
                guard let data = response.data else{return}
                do {
                    let cityWeatherJSON = try JSONDecoder().decode(CityWeather.self, from: data)
                    guard let _ = cityWeatherJSON.name else {
                        setOkAlertMessage(with: "There is no place with such name")
                        return
                    }
                    delegate?.setcityWeather(cityWeatherJSON)
                    locationNameTextField.text = ""
                    navigationController?.popViewController(animated: true)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print("API_PATH failed to retrive data!")
                print(error.errorDescription ?? "")
                setOkAlertMessage(with: "Do not use space")
            }
        }
    }
    
    func setOkAlertMessage(with message: String){
        let allertController = UIAlertController(
            title: "Message",
            message: message,
            preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        allertController.addAction(okAlertAction)
        self.present(allertController, animated: true, completion: nil)
    }
    
    func checkClearSearchButton() {
        if locationNameTextField.text == "" {
            clearSearchTextFieldButton.isEnabled = false
            clearSearchTextFieldButton.isHidden = true
        } else {
            clearSearchTextFieldButton.isEnabled = true
            clearSearchTextFieldButton.isHidden = false
        }
    }
}
