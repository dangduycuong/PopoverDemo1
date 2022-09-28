//
//  CategoryDetailTableViewCell.swift
//  PopoverDemo1
//
//  Created by cuongdd on 27/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var mealThumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(category: Meal) {
        if let strMealThumb = category.strMealThumb, let url = URL(string: strMealThumb) {
            mealThumbImageView.kf.setImage(with: url)
        }
        mealLabel.text = category.strMeal
    }
    
}
