require_relative "employee.rb"

class Manager < Employee
    def initialize(name, title, salary, boss, employees)
        @employees = employees
        super(name, title, salary, boss)
    end

    def bonus(multiplier)
        total_employee_salaries * multiplier
    end

    def total_employee_salaries
        total = 0
        @employees.each do |employee|
            if employee.is_a?(Manager)  # recursively add all employee's salaries under the manager
                total += employee.total_employee_salaries
            end
            total += employee.salary # then add employee's salary regardless of title
        end
        total
    end
end