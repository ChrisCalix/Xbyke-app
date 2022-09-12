//
//  Observable.swift
//  Xbyke-app
//
//  Created by Christian Calixto on 12/9/22.
//

import Foundation

class Observable<T> {
    private var listener: ((T?) -> Void)?
    var value : T? {
        didSet {
            listener?(value)
        }
    }

    init (_ value: T?){
        self.value = value
    }

    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
