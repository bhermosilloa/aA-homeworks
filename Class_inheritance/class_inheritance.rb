class Employee

    attr_reader :name, :salary

    def initialize(name, title, salary, boss = nil)
        @name, @title, @salary, @boss = name, title, salary, boss

        assign_to_boss
    end

    def assign_to_boss
        @boss.employees << self unless @boss.nil?
    end

    def bonus(multiplier)
        @salary * multiplier
    end

    def sum_of_salaries
        0
    end

end

class Manager < Employee

    attr_accessor :employees

    def initialize(name, title, salary, boss, employees = [])
        super(name, title, salary, boss)
        @employees = employees
    end

    def bonus(multiplier)
        self.sum_of_salaries * multiplier
    end

    def sum_of_salaries
        employees.inject(0) { |sum, employee| sum + employee.salary + employee.sum_of_salaries }
    end

end

ned = Manager.new("Ned", "Founder", 1000000, nil)
george = Manager.new("Darren", "TA Manager", 80000, ned)
darren = Manager.new("Darren", "TA Manager", 78000, george)
david = Employee.new("David", "TA", 10000, darren)
shawna = Employee.new("Shawna", "TA", 12000, darren)    

puts ned.bonus(5) # => 900_000
puts george.bonus(4) # => 400_000
puts darren.bonus(4) # => 88_000
puts david.bonus(3) # => 30_000