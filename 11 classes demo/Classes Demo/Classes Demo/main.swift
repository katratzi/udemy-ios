let skeleton = Enemy(health: 100, att: 10)
let skeleton2 = skeleton

skeleton.takeDamage(amount: 10)

print(skeleton2.health)

//let dragon = Dragon(health: 200, att: 50)
//
//print(skeleton.health)
//skeleton.move()
//skeleton.attack()
//
//dragon.wingspan = 5
//dragon.talk(speech: "My teeth are sharp")
//dragon.move()
//dragon.attack()
