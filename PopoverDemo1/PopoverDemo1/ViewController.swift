//
//  ViewController.swift
//  PopoverDemo1
//
//  Created by duycuong on 1/23/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func onClickedPassThroughButton(_ sender: UIButton) {
        title = "Pass Through Clicked"
    }

//    @IBAction func showButton(_ sender: UIButton) {
//        //CGRect(origin: self.view.center, size: CGSize.zero)
//        //CGRect(origin: self.view.CGPoint.init(x: 100, y: 200), size: CGSize.init(width: 250, height: 400))
//        Anh Thắng đã sửa
//    }

}

