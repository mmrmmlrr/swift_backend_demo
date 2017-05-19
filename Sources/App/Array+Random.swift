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
        #if os(Linux)
            return self[Int(random() % (self.count + 1))]
        #else
            return self[Int(arc4random_uniform(UInt32(self.count)))]
        #endif
    }
}
