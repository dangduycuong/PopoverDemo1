//
//  String+Extension.swift
//  PopoverDemo1
//
//  Created by cuongdd on 28/09/2022.
//  Copyright © 2022 duycuong. All rights reserved.
//

import Foundation

extension String {
    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
