//
//  DetailMealViewController.swift
//  PopoverDemo1
//
//  Created by cuongdd on 27/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit
import Kingfisher

class DetailMealViewController: UIViewController {
    @IBOutlet weak var strInstructionsLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var mealThumbImageView: UIImageView!
    @IBOutlet weak var strYoutubeLabel: UILabel!
    
    var detailMeal = [Meal]()
    var infoMeal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lookupFullMealDetails(by: infoMeal?.idMeal)
        title = infoMeal?.strMeal
        strInstructionsLabel.text = ""
        strYoutubeLabel.text = ""
        
        
        strYoutubeLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        strYoutubeLabel.addGestureRecognizer(tapgesture)
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        if let strYoutube = detailMeal[0].strYoutube {
            open(url: strYoutube)
        }
    }
    
    private func open(url: String, completed: (() -> Void)? = nil, error: (() -> Void)? = nil) {
        if let url = URL(string: url),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                completed?()
            })
        } else {
            error?()
        }
    }
    
    private func lookupFullMealDetails(by id: String?) {
        activityIndicatorView.startAnimating()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.themealdb.com"
        urlComponents.path = "/api/json/v1/1/lookup.php"
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "i", value: id)
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
                            self.detailMeal = meals
                            if !self.detailMeal.isEmpty {
                                let meal = self.detailMeal[0]
                                let strInstructions = meal.strInstructions
                                self.strInstructionsLabel.text = strInstructions
                                if let strMealThumb = meal.strMealThumb, let url = URL(string: strMealThumb) {
                                    self.mealThumbImageView.kf.setImage(with: url)
                                }
                                self.strYoutubeLabel.text = meal.strYoutube
                            }
                        }
                    }
                } catch {}
            }
        })
        
        dataTask.resume()
    }

}
