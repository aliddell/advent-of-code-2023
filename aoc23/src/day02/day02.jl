module day02

mutable struct Draw
    red::Int64
    green::Int64
    blue::Int64
    Draw() = new(0, 0, 0)
end

Draw(red::Int64, green::Int64, blue::Int64) = begin
    draw = Draw()
    draw.red = red
    draw.green = green
    draw.blue = blue
    draw
end

function parseline(line::String)
    draws = Vector{Draw}()
    gamere = r"Game\s+(\d+)"
    redre = r"(\d+)\s+red"
    greenre = r"(\d+)\s+green"
    bluere = r"(\d+)\s+blue"

    substrings = map(strip, split(line, r"[;:]"; keepempty=false))
    @assert startswith(substrings[1], "Game")

    game = parse(Int64, match(gamere, substrings[1]).captures[1])

    for s in substrings[2:end]
        draw = Draw()
        m = match(redre, s)
        if !isnothing(m)
            draw.red = parse(Int64, m.captures[1])
        end

        m = match(greenre, s)
        if !isnothing(m)
            draw.green = parse(Int64, m.captures[1])
        end

        m = match(bluere, s)
        if !isnothing(m)
            draw.blue = parse(Int64, m.captures[1])
        end

        push!(draws, draw)
    end

    game, draws
end

function gameispossible(draws::Vector{Draw}, maxred::Int64, maxgreen::Int64, maxblue::Int64)
    for draw in draws
        if draw.red > maxred || draw.green > maxgreen || draw.blue > maxblue
            return false
        end
    end
    true
end

function problem1()
    possiblegames = Vector{Int64}()
    open(joinpath(@__DIR__, "input")) do io
        for line in eachline(io)
            game, draws = parseline(line)
            if gameispossible(draws, 12, 13, 14)
                push!(possiblegames, game)
            end
        end
    end

    sum(possiblegames) # 2541
end

function powerofminimalset(draws::Vector{Draw})
    red = 0
    green = 0
    blue = 0
    for draw in draws
        red = max(red, draw.red)
        green = max(green, draw.green)
        blue = max(blue, draw.blue)
    end
    
    red * green * blue
end

function problem2()
    val = 0
    open(joinpath(@__DIR__, "input")) do io
        for line in eachline(io)
            _, draws = parseline(line)
            val += powerofminimalset(draws)
        end
    end

    val # 66016
end

end # module day02