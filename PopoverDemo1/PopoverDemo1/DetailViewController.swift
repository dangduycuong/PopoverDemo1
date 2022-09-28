//
//  DetailViewController.swift
//  PopoverDemo1
//
//  Created by cuongdd on 27/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

enum ListBy {
    case categories
    case area
    case ingredients
}

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var categoriesMeal = [Meal]()
    var selectCategory: ((_ category: String?) -> Void)?
    var filterByArea: ((_ area: String?) -> Void)?
    var filterByMainIngredient: ((_ ingredient: String?) -> Void)?
    var findBy = ListBy.categories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(CategoryCell.self)
        switch findBy {
        case .categories:
            getAllCategories()
        case .area:
            getAllArea()
        case .ingredients:
            getListAllIngredients()
        }
    }
    
    private func getAllCategories() {
        activityIndicatorView.startAnimating()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.themealdb.com"
        urlComponents.path = "/api/json/v1/1/list.php"
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "c", value: "list")
        ]
        urlComponents.queryItems = urlQueryItem
        guard let url = urlComponents.url else {
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.activityIndicatorView.stopAnimating()
                print(error)
            }
            if let data = data {
                data.printFormatedJSON()
                do {
                    let json = try JSONDecoder().decode(CategoryMealModel.self, from: data)
                    if let meals = json.meals {
                        DispatchQueue.main.async {
                            self.activityIndicatorView.stopAnimating()
                            self.categoriesMeal = meals
                            self.tableView.reloadData()
                        }
                    }
                } catch {}
            }
        })
        
        dataTask.resume()
    }
    
    private func getAllArea() {
        activityIndicatorView.startAnimating()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.themealdb.com"
        urlComponents.path = "/api/json/v1/1/list.php"
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "a", value: "list")
        ]
        urlComponents.queryItems = urlQueryItem
        guard let url = urlComponents.url else {
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.activityIndicatorView.stopAnimating()
                print(error)
            }
            if let data = data {
                data.printFormatedJSON()
                do {
                    let json = try JSONDecoder().decode(CategoryMealModel.self, from: data)
                    if let meals = json.meals {
                        DispatchQueue.main.async {
                            self.activityIndicatorView.stopAnimating()
                            self.categoriesMeal = meals
                            self.tableView.reloadData()
                        }
                    }
                } catch {}
            }
        })
        
        dataTask.resume()
    }

    private func getListAllIngredients() {
        activityIndicatorView.startAnimating()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.themealdb.com"
        urlComponents.path = "/api/json/v1/1/list.php"
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "i", value: "list")
        ]
        urlComponents.queryItems = urlQueryItem
        guard let url = urlComponents.url else {
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.activityIndicatorView.stopAnimating()
                print(error)
            }
            if let data = data {
                data.printFormatedJSON()
                do {
                    let json = try JSONDecoder().decode(CategoryMealModel.self, from: data)
                    if let meals = json.meals {
                        DispatchQueue.main.async {
                            self.activityIndicatorView.stopAnimating()
                            self.categoriesMeal = meals
                            self.tableView.reloadData()
                        }
                    }
                } catch {}
            }
        })
        
        dataTask.resume()
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: CategoryCell.self, forIndexPath: indexPath)
        switch findBy {
        case .categories:
            cell.fillData(titleMeal: categoriesMeal[indexPath.row].strCategory)
        case .area:
            cell.fillData(titleMeal: categoriesMeal[indexPath.row].strArea)
        case .ingredients:
            cell.fillData(titleMeal: categoriesMeal[indexPath.row].strIngredient)
        }
        let selectedView = UIView()
        selectedView.backgroundColor = .white
        cell.selectedBackgroundView = selectedView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch findBy {
        case .area:
            filterByArea?(categoriesMeal[indexPath.row].strArea)
        case .categories:
            selectCategory?(categoriesMeal[indexPath.row].strCategory)
        case .ingredients:
            filterByMainIngredient?(categoriesMeal[indexPath.row].strIngredient)
        }
        dismiss(animated: true)
    }
    
}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
class CategoryMealModel: Codable {
    let meals: [Meal]?
    
    init(meals: [Meal]?) {
        self.meals = meals
    }
}

// MARK: - Meal
class Meal: Codable {
    let strCategory: String?
    
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    let strInstructions: String?
    let strYoutube: String?
    let strArea: String?
    let idIngredient, strIngredient: String?
    let strDescription, strType: String?

    init(strCategory: String?, strMeal: String?, strMealThumb: String?, idMeal: String?, strInstructions: String?, strYoutube: String?, strArea: String?, idIngredient: String?, strIngredient: String?, strDescription: String?, strType: String?) {
        self.strCategory = strCategory
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
        self.strInstructions = strInstructions
        self.strYoutube = strYoutube
        self.strArea = strArea
        self.idIngredient = idIngredient
        self.strIngredient = strIngredient
        self.strDescription = strDescription
        self.strType = strType
    }
}



import Foundation

extension Data {
    
    func printResponseJson() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
    
    func printFormatedJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            pringJSONData(jsonData)
        } else {
            assertionFailure("Malformed JSON")
        }
    }
    
    private func pringJSONData(_ data: Data) {
        print(String(decoding: data, as: UTF8.self))
    }
}
