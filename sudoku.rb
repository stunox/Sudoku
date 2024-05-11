require './utils.rb'

class Grid
    def initialize
        @grid = []
        size = 4 # default
    end

    def get_grid
        return @grid
    end

    def add_line(line)
        @grid.push(line)
    end

    def get_line(index)
        return @grid[index - 1]
    end

    def get_column(index)
        column = []
        @grid.each do |line|
            column.append(line[index - 1])
        end
        return column
    end

    def get_size
        return @size
    end

    def set_size(size)
        @size = size.to_i
    end

    def is_completed
        @grid.each do |line|
            line.each do |square|
                if square.get_value == 0
                    return false
                end
            end
        end
    end
end

class Square
    def initialize(value = nil, line = nil, column = nil, block = nil)
        @value = value
        @line = line
        @column = column
        @block = block
    end

    def get_value
        return @value
    end

    def set_value(value)
        @value = value
    end

    def get_column_index
        return @column
    end

    def get_block_index
        return @block
    end

    def is_empty
        return @value == 0 ? true : false
    end
end

def create_grid(difficulty, n = nil)
    grid = Grid.new
    case difficulty
    when "easy"
        file="grid4x4-#{n != nil ? n.to_s : "1"}.txt"
    when "medium"
        file="grid9x9-#{n != nil ? n.to_s : "1"}.txt"
    when "hard"
        file="grid16x16.txt"
    when "expert"
        file="grid25x25.txt"
    else # default
        file="grid4x4-1.txt"
    end
    file_content = File.read(__dir__ + "/Grids/" + file)
    grid.set_size(file_content.split("\n")[0])
    file_content.split("\n").drop(1).each_with_index do |value, i|
        line = []
        value.split(" ").each do |value|
            block = (i / Math.sqrt(grid.get_size).to_i).to_i * Math.sqrt(grid.get_size).to_i + line.size / Math.sqrt(grid.get_size).to_i
            line.push(Square.new(value.to_i, i, line.size, block))
        end
        grid.add_line(line)
    end
    return grid
end

def print_grid(grid)
    clear_console
    block_size = Math.sqrt(grid.get_size).to_i
    grid.get_grid.each_with_index do |line, index|
        line.each do |square|
            if square.get_column_index % block_size == 0 and square.get_column_index != 0
                print "|   "
            end
            value = square.get_value
            value_str = (value == 0 ? red(value.to_s) : green(value.to_s))
            print value_str + (value > 9 ? "  " : "   ")
        end
        print "\n"
        if (index + 1) % block_size == 0
            print "\n"
        end
    end
end

def check_line(grid, x, n)
    line=grid.get_line(x)
    line.each do |square|
        if square.get_value == n
            return false
        end
    end
    return true
end

def check_column(grid, y, n)
    column = grid.get_column(y)
    column.each do |square|
        if square.get_value == n
            return false
        end
    end
    return true
end

def check_block(grid, x, y, n)
    block_size = Math.sqrt(grid.get_size).to_i
    block_x = ((x - 1) / block_size).to_i
    block_y = ((y - 1) / block_size).to_i
    block = []
    grid.get_grid.each do |line|
        line.each do |square|
            if square.get_block_index == block_x * block_size + block_y
                block.append(square)
            end
        end
    end

    block.each do |square|
        if square.get_value == n
            return false
        end
    end
    return true
end

def check_completed(grid)
    if grid.is_completed
        print_grid(grid)
        puts green("Congratulations ! You completed the grid !")
        exit
    else
        puts "Press enter to continue"
        gets
    end
end

clear_console
puts yellow("Welcome to Sudoku !").center(80)
puts blue("Please choose a difficulty level (easy, medium, hard, expert):")
# clear console
difficulty = gets.chomp!.downcase
clear_console
if difficulty == "easy" or difficulty == "medium"
    puts blue("There are 3 different grids on this level, choose a number between 1 and 3")
    input=gets.chomp
    n = input.to_i < 1 ? 1 : (input.to_i > 3 ? 3 : input.to_i)
end
grid=create_grid(difficulty, n)



def start_game(grid)
    while not grid.is_completed
        print_grid(grid)
        puts blue("R for rules, Q to quit, H for hint")
        puts yellow("X Y N: fill the square at line X and column Y with the number N")
        input = gets.chomp!
        if input == "R"
            show_rules(grid)
        elsif input == "Q"
            exit
        elsif input == "H"
            help(grid)
        else
            (x,y,n) = input.split(" ").map(&:to_i)
            grid_size = grid.get_size
            if isNil(x,y,n) or outOfRange(x, grid_size) or outOfRange(y, grid_size) or outOfRange(n, grid_size)
                puts red("Invalid input !")
            else
                square = grid.get_line(x)[y-1]
                unless square.is_empty
                    puts red("This square is not empty")
                else
                    is_line_ok = check_line(grid, x, n)
                    is_column_ok = check_column(grid, y, n)
                    is_block_ok = check_block(grid, x, y, n)
                    if not is_line_ok or not is_column_ok or not is_block_ok
                        if not is_line_ok
                            puts red("This number is already in the line")
                        end
                        if not is_column_ok
                            puts red("This number is already in the column")
                        end
                        if not is_block_ok
                            puts red("This number is already in the block")
                        end
                    else
                        square.set_value(n)
                        puts green("Square filled !")
                    end
                end
            end
        end
        check_completed(grid)
    end
end

def show_rules(grid)
    puts yellow("Rules of the game:").center(80)
    puts "- Fill in the grid so that every row, every column, and every block contains the digits 1 through #{grid.get_size}."
    puts "- You can't change the initial values."
    puts "- To fill a square, it should be empty (0) and you should enter a number between 1 and #{grid.get_size}."
    puts "- You should also enter the line and column of the square you want to fill."
    puts blue("Example : 1 4 3 means you want to fill the square at line 1 and column 4 with the number 3.")
    puts red("Press enter to start the game.")
    gets
    start_game(grid)
end

def help(grid)
    clear_console
    # search for n where n is the most completed number, and return it with the number of occurences,
    # the number of occurences shoould be lower than the grid size
    # if there are multiple numbers with the same number of occurences, return the first one

    numbers = Array.new(grid.get_size, 0)
    grid.get_grid.each do |line|
        line.each do |square|
            if not square.is_empty
                numbers[square.get_value - 1] += 1
            end
        end
    end

    max = numbers.max
    while max == grid.get_size
        numbers[numbers.index(max)] = 0
        max = numbers.max
    end

    puts "The number #{blue(numbers.index(max) + 1)} is the most completed number with #{blue(max)} occurences."
    puts red("Press enter to continue")
    gets
    start_game(grid)
end

show_rules(grid)
