//
//  Identifier.swift
//  PopoverDemo1
//
//  Created by cuongdd on 27/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import UIKit

//
// MARK: - Identifier
// Easily to get ViewID and XIB file
protocol Identifier {
    
    /// ID view
    static var identifierView: String {get}
    
    /// XIB - init XIB from identifierView
    static func xib() -> UINib?
}

extension UIView: Identifier {
    
    /// ID View
    static var identifierView: String {
        get {
            return String(describing: self)
        }
    }
    
    /// XIB
    static func xib() -> UINib? {
        return UINib(nibName: self.identifierView, bundle: nil)
    }
    
    class func instanceFromXib() -> UIView? {
        return xib()?.instantiate(withOwner: nil, options: nil).first as? UIView
    }
}

public protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }

//
// MARK: - Register View
extension UITableView {
    /// Helper register cell
    /// The View must conform Identifier protocol
    func registerCell<T: Identifier>(_ viewType: T.Type) {
        self.register(viewType.xib(), forCellReuseIdentifier: viewType.identifierView)
    }
    
    func register<T: UITableViewCell>(with classType: T.Type) {
        self.register(classType.self, forCellReuseIdentifier: classType.identifierView)
    }
    
    func registerCells<T: Identifier>(_ viewsType: [T.Type]) {
        viewsType.forEach({
            self.register($0.xib(), forCellReuseIdentifier: $0.identifierView)
        })
    }
    
    func registerHeaderFooterView<T: Identifier>(_ viewType: T.Type) {
        self.register(viewType.xib(), forHeaderFooterViewReuseIdentifier: viewType.identifierView)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(" Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue header/footer view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
    
    var lastIndexPath: IndexPath? {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
        
        if lastRowIndex >= 0 && lastSectionIndex > 0 {
            return IndexPath.init(row: lastRowIndex, section: lastSectionIndex)
        }
        
        return nil
    }
    
}

extension UITableView {
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
}

