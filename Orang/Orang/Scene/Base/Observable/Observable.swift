//
//  Observable.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation

class Observable<T> {
    
    var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping ((T) -> Void)) {
        closure(value)
        listener = closure
    }
}
