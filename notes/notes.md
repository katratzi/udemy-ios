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