
let myOptional: String?

myOptional = "Angela"

// Force Unwrap
// optional!
// simple but least safe

let text: String = myOptional!


// Check for nil value
if myOptional != nil {
    let text1 = myOptional!
    let text2 = myOptional!
}
// works but quite wordy and we have to keep unwrapping

// Optional Binding
if let safeOptional = myOptional {
    let text1 = safeOptional
    let text2 = safeOptional
    //      it's now unwrapped with the safeOptional value
}

// Nil coalescing operator
// optional ?? defaulValue
let textB : String = myOptional ?? "I am default"

struct MyOptionalStruct {
    var property = 123
    func method(){
        print("i am a method")
    }
}

let myOptStruct: MyOptionalStruct?
myOptStruct = nil
myOptStruct!.property

// Optional Chaining using ?
// safer to check using a chaining method when checking for nil
print(myOptStruct?.property)

