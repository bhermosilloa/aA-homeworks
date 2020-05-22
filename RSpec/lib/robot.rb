class Robot

    attr_accessor :position, :items, :weight, :health, :equipped_weapon

    def initialize
        @position = [0,0]
    end

    def move_left
        position[0] += -1
    end
    
    def move_right
        position[0] += 1
    end
    
    def move_up
        position[1] += 1
    end
    
    def move_down
        position[1] += -1
    end

    def items
        @items || @items = []
    end

    def pick_up(item)
        raise ArgumentError.new "Can't pick up more than 250 of weight" if items_weight + item.weight > 250
        items << item
    end

    def items_weight
        @weight = items.inject(0) { |sum, item| sum += item.weight }
    end

    def health
        @health || @health = 100
    end

    def wound(damage)
        new_health = self.health - damage
        new_health < 0 ? self.health = 0 : self.health = new_health
    end

    def heal(healing)
        new_health = self.health + healing
        new_health > 100 ? self.health = 100 : self.health = new_health
    end

    def attack(robot)
        equipped_weapon.nil? ? robot.wound(5) : equipped_weapon.hit(robot)
    end

    def equipped_weapon
        @equipped_weapon
    end

end

class Item

    attr_reader :name, :weight

    def initialize(name, weight)
        @name = name
        @weight = weight
    end

end

class Bolts < Item

    def initialize
        @name = "bolts"
        @weight = 25
    end

    def feed(robot)
        robot.heal(weight)
    end

end

class Weapon < Item

    attr_reader :damage

    def initialize(name, weight, damage)
        super(name, weight)
        @damage = damage
    end

    def hit(robot)
        robot.wound(damage)
    end

end

class Laser < Weapon

    def initialize
        @name = "laser"
        @weight = 125
        @damage = 25
    end

end

class PlasmaCannon < Weapon

    def initialize
        @name = "plasma_cannon"
        @weight = 200
        @damage = 55
    end

end