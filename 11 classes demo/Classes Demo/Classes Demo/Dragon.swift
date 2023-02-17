class Dragon: Enemy {
    
 var wingspan = 2

    func talk(speech: String)
    {
        print(speech)
    }
    
    override func move() {
        print("Fly forwards")
    }
    
    override func attack() {
        super.attack()
        print("Spits fire, does \(att) dmg")
    }
}
