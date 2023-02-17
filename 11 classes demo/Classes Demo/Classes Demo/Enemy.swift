class Enemy {
    var health : Int
    var att : Int
    
    init(health: Int, att: Int) {
        self.health = health
        self.att = att
    }
    
    func takeDamage(amount: Int){
        health -= amount
    }
    
    func move()
    {
        print("Walk")
    }
    
    func attack() {
        print("Land hit, does \(att) damage")
    }
    
    
}
