let skeleton = Enemy()
let dragon = Dragon()

print(skeleton.health)
skeleton.move()
skeleton.attack()

dragon.wingspan = 5
dragon.att = 15
dragon.talk(speech: "My teeth are sharp")
dragon.move()
dragon.attack()
