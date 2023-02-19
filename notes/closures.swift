import UIKit

var greeting = "Hello, playground"

func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int{
    return operation(n1, n2)
}

func add (no1: Int, no2: Int) -> Int {
    return no1 + no2
}
func multiply (no1: Int, no2: Int) -> Int {
    return no1 * no2
}
// as closure
//{ (no1: Int, no2: Int) -> Int in
//    return no1 * no2
//}
//calculator(n1: 2, n2: 3, operation: { (no1: Int, no2: Int) -> Int in
//    return no1 * no2
// }

// type can also be inferred and we can loose Int for the types
// and also the return as that's implied
//{ (no1, no2) in no1 * no2
//}

//calculator(n1: 2, n2: 3, operation: { (no1, no2) in no1 * no2 })

// and go even further, use anon parameter names $0 is first paremeter etc
//calculator(n1: 2, n2: 3, operation: { $0 * $1 })

// if the last paremeter inthe function is a closer, you can omit the name
// and you have what's known as a trailing closure
let result = calculator(n1: 2, n2: 3) { $0 * $1 }

print(result)


// Another example

let array = [6,2,3,8,9,4,1]

//func addOne (n1: Int) -> Int {
//    return n1 + 1
//}

var array2 = array.map() { $0 + 1}

print(array2)
