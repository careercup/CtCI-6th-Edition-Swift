import Foundation

//: Write a function that adds two numbers. You should not use + or any arithmetic  operators.

func add(_ a: Int64, _ b: Int64) -> Int64 {
    if b == 0 { return a }
    let carry = (a & b) << 1
    let sum = a ^ b
    return add(sum, carry)
}

add(10, 32)
add(-10, 20)
add(0, 1002)
add(3420129, -9)
