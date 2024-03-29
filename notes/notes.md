# Create a code snippet

Highlight code, right click and create code snippet.  For the placeholder use

<#nameofplaceholder#>

Use this nice syntax for breaking up files a bit like regions

//MARK: - UITextFieldDelegate

# Singletons

class Car {
    var colour = "Red"
    static let singletonCar = Car()
}

let myCar = Car.singletonCar

# Did Set

var selectedCategory : Category? {
    // this runs only when property is set
    // useful for segues
        didSet {
            loadItems()
        }
    }

# Computer Properties


let pizzaInInches : Int = 14

// computed - must be var
// have to specify datatype
var numberOfSlices : Int {
    // short version of getter
    return pizzaInInches - 4
}

var numberOfSlices : Int {
    // long version of getter
    get {
        return pizzaInInches - 4
    }
    set {
        // newValue is the keyword
        print("num of slice is now \(newValue)")
    }
}

print(numberOfSlices)

# Observed Properties

// observed property
var pizzaInInches : Int = 10 {
    // before change
    willSet {
        print(pizzaInInches)
        print(newValue)
    }
    // after change
    didSet {
        print(oldValue)
        print(pizzaInInches)
    }
}

# Tuples

// tuple access with number
let tuple1 = ("Rygel", 16)
print(tuple1.0) // "Rygel"

// tuple access with name
let tuple2 = (name: "Angela", age: 12)
print(tuple2.name)

// tuple data type declaration
let tuple3: (name: String, age: Int)
tuple3 = (name: "Angela", age: 12)
print(tuple3.name)



