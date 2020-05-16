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
        return @salary * multiplier if self.class != Manager
        self.sum_of_salaries * multiplier
    end

    def sum_of_salaries
        return 0 if self.class != Manager
        employees.inject(0) { |sum, employee| sum + employee.salary + employee.sum_of_salaries }
    end

end

class Manager < Employee

    attr_accessor :employees

    def initialize(name, title, salary, boss, employees = [])
        super(name, title, salary, boss)
        @employees = employees
    end

end

ned = Manager.new("Ned", "Founder", 1000000, nil)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
david = Employee.new("David", "TA", 10000, darren)
shawna = Employee.new("Shawna", "TA", 12000, darren)    

puts ned.bonus(5) # => 500_000
puts darren.bonus(4) # => 88_000
puts david.bonus(3) # => 30_000