//
//  Swapper.swift
//  
//
//  Created by Stefan Jaindl on 15.11.20.
//

import Foundation

open class Swapper<T: BinaryInteger> {
    public init() { }
    
    open func swapInline(_ first: inout T, _ second: inout T) {
        first = first ^ second //bit difference
        second = first ^ second //= original first
        first = first ^ second //= original second
    }
}
