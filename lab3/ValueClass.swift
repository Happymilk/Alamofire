//
//  ValueClass.swift
//  lab3
//
//  Created by Admin on 28.02.16.
//  Copyright © 2016 Admin. All rights reserved.
//

class MyValue {
    var cur = ""
    var val = 0.0
    
    init (Currency: String, Value: String) {
        self.cur = Currency
        if let tmp = Double(Value) {
            self.val = tmp
        }
    }
}
