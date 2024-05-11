def clear_console
    puts "\e[H\e[2J"
end

def green(text)
    return "\e[32m#{text}\e[0m"
end

def red(text)
    return "\e[31m#{text}\e[0m"
end

def blue(text)
    return "\e[34m#{text}\e[0m"
end

def yellow(text)
    return "\e[33m#{text}\e[0m"
end

def outOfRange(n, range)
    if n < 1 or n > range
        return true
    end
end

def isNil(*args)
    args.each do |arg|
        if arg.nil?
            return true
        end
    end
    return false
end
