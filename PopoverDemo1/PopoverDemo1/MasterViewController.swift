//
//  MasterViewController.swift
//  PopoverDemo1
//
//  Created by cuongdd on 27/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var rightBarButtonFilterItems: [UIBarButtonItem]!
    var detailCategory = [Meal]()
    var filterMeal = [Meal]()
    var findBy = ListBy.categories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.registerCell(CategoryDetailTableViewCell.self)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.searchBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        let pc = vc.popoverPresentationController
        pc?.sourceRect = CGRect(origin: self.view.center, size: CGSize.zero)
        pc?.delegate = self
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Call API
    private func filterByCategory(category: String?) {
        self.searchBar.isHidden = true
        activityIndicatorView.startAnimating()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.themealdb.com"
        urlComponents.path = "/api/json/v1/1/filter.php"
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "c", value: category)
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
            }
            if let data = data {
                data.printFormatedJSON()
                do {
                    let json = try JSONDecoder().decode(DetailCategoryModel.self, from: data)
                    if let meals = json.meals {
                        DispatchQueue.main.async {
                            self.searchBar.isHidden = false
                            self.activityIndicatorView.stopAnimating()
                            self.detailCategory = meals
                            self.filterMeal = meals
                            self.tableView.reloadData()
                        }
                    }
                } catch {}
            }
        })
        
        dataTask.resume()
    }
    
    private func filterByArea(area: String?) {
        self.searchBar.isHidden = true
        activityIndicatorView.startAnimating()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.themealdb.com"
        urlComponents.path = "/api/json/v1/1/filter.php"
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "a", value: area)
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
            }
            if let data = data {
                data.printFormatedJSON()
                do {
                    let json = try JSONDecoder().decode(DetailCategoryModel.self, from: data)
                    if let meals = json.meals {
                        DispatchQueue.main.async {
                            self.searchBar.isHidden = false
                            self.activityIndicatorView.stopAnimating()
                            self.detailCategory = meals
                            self.filterMeal = meals
                            self.tableView.reloadData()
                        }
                    }
                } catch {}
            }
        })
        
        dataTask.resume()
    }
    
    private func filterByMainIngredient(ingredient: String?) {
        self.searchBar.isHidden = true
        activityIndicatorView.startAnimating()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.themealdb.com"
        urlComponents.path = "/api/json/v1/1/filter.php"
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "i", value: ingredient)
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
            }
            if let data = data {
                data.printFormatedJSON()
                do {
                    let json = try JSONDecoder().decode(DetailCategoryModel.self, from: data)
                    if let meals = json.meals {
                        DispatchQueue.main.async {
                            self.searchBar.isHidden = false
                            self.activityIndicatorView.stopAnimating()
                            self.detailCategory = meals
                            self.filterMeal = meals
                            self.tableView.reloadData()
                        }
                    }
                } catch {}
            }
        })
        
        dataTask.resume()
    }
    
    @IBAction func showPop(_ sender: UIBarButtonItem) {
        findBy = .categories
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectFilterByVC") as! SelectFilterByVC
        vc.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender
        popover.sourceRect = CGRect(origin: self.view.center, size: CGSize.zero)
        popover.delegate = self
        vc.findBy = .categories
        vc.selectCategory = { [weak self] category in
            self?.filterByCategory(category: category)
        }
        rightBarButtonFilterItems.forEach { barButtonItem in
            if barButtonItem == sender {
                barButtonItem.tintColor = .red
            } else {
                barButtonItem.tintColor = UIColor.systemGreen
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showListByArea(_ sender: UIBarButtonItem) {
        findBy = .area
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectFilterByVC") as! SelectFilterByVC
        vc.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender
        popover.sourceRect = CGRect(origin: self.view.center, size: CGSize.zero)
        popover.delegate = self
        vc.findBy = .area
        vc.filterByArea = { [weak self] area in
            self?.filterByArea(area: area)
        }
        rightBarButtonFilterItems.forEach { barButtonItem in
            if barButtonItem == sender {
                barButtonItem.tintColor = .red
            } else {
                barButtonItem.tintColor = UIColor.systemGreen
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showListByMainIngredient(_ sender: UIBarButtonItem) {
        findBy = .ingredients
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectFilterByVC") as! SelectFilterByVC
        vc.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender
        popover.sourceRect = CGRect(origin: self.view.center, size: CGSize.zero)
        popover.delegate = self
        vc.findBy = .ingredients
        vc.filterByMainIngredient = { [weak self] ingredient in
            self?.filterByMainIngredient(ingredient: ingredient)
        }
        rightBarButtonFilterItems.forEach { barButtonItem in
            if barButtonItem == sender {
                barButtonItem.tintColor = .red
            } else {
                barButtonItem.tintColor = UIColor.systemGreen
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    
}

extension MasterViewController: UIPopoverPresentationControllerDelegate {
    
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: CategoryDetailTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(category: filterMeal[indexPath.row])
        let selectedView = UIView()
        selectedView.backgroundColor = .white
        cell.selectedBackgroundView = selectedView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMealViewController") as! DetailMealViewController
        vc.infoMeal = filterMeal[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MasterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            filterMeal = detailCategory
            tableView.reloadData()
            return
        }
        filterMeal = detailCategory.filter { (meal: Meal) in
            if let strMeal = meal.strMeal?.lowercased().unaccent() {
                if strMeal.range(of: searchText.lowercased().unaccent()) != nil {
                    return true
                }
            }
            return false
        }
        tableView.reloadData()
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let detailCategoryModel = try? newJSONDecoder().decode(DetailCategoryModel.self, from: jsonData)

import Foundation

// MARK: - DetailCategoryModel
class DetailCategoryModel: Codable {
    let meals: [Meal]?
    
    init(meals: [Meal]?) {
        self.meals = meals
    }
}

// MARK: - Meal
