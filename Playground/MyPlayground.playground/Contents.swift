import Foundation

// observed property
var pizzaInInches : Int = 10 {
    // before change
    willSet {
        print(pizzaInInches)
        print(newValue)
    }
    // after change
    didSet {
        if pizzaInInches >= 18
        {
            print("invalid size, pizza set to 18")
            pizzaInInches = 18
        }
    }
}

var numberOfPeople : Int = 12
let slicesPerPerson : Int = 6

// computed - must be var
// have to specify datatype
var numberOfSlices : Int {
    // long version of getter
    get {
        return pizzaInInches - 4
    }
}

var numberOfPizza : Int {
    get {
        let numPeopleFedPerPizza = numberOfSlices / slicesPerPerson
        return numberOfPeople / numPeopleFedPerPizza
    }
    set {
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices / slicesPerPerson
    }
}

numberOfPizza = 4
print(numberOfPeople)

pizzaInInches = 33
print(pizzaInInches)




