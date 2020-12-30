//
//  MultiStack.swift
//  
//
//  Created by Stefan Jaindl on 21.06.20.
//

import Foundation

open class StackSort<T: Comparable & Hashable> {
    
    public init() { }
    
    public static func sort(stack: Stack<T>) {
        let tempStack = Stack<T>()
        
        while !stack.isEmpty(), let element = try? stack.pop() {
            if tempStack.isEmpty() {
                tempStack.push(val: element)
            } else {
                while !tempStack.isEmpty(), let tempElement = try? tempStack.peek(), tempElement >= element {
                    try? stack.push(val: tempStack.pop())
                }
                
                tempStack.push(val: element)
            }
        }
        
        //elements are now sorted in reverse order in temp stack.
        //So, copy elements back from temp to original stack to have in correct order
        while !tempStack.isEmpty() {
            try? stack.push(val: tempStack.pop())
        }
    }
}
