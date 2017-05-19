//
//  Array+Random.swift
//  MyBackend
//
//  Created by Oleksii Chernysh on 5/19/17.
//
//

import Foundation

extension Array {
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
