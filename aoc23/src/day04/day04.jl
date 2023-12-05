module day04

function getnumbersfrom(line)
    substrings = map(strip, split(line, r"[:|]"))
    winners = map(x -> parse(Int64, x), split(substrings[2], r"\s+"))
    have = map(x -> parse(Int64, x), split(substrings[3], r"\s+"))

    intersect(winners, have)
end

function problem1()
    score = 0

    open(joinpath(@__DIR__, "input")) do io
        for line in eachline(io)
            winnerswehave = getnumbersfrom(line)
            if isempty(winnerswehave)
                continue
            end
            score += 2^(length(winnerswehave) - 1)
        end
    end

    score # 21105
end

function problem2()
    copies = Dict{Int64,Int64}()
    open(joinpath(@__DIR__, "input")) do io
        for (card, line) in enumerate(eachline(io))
            if haskey(copies, card)
                copies[card] += 1
            else
                copies[card] = 1
            end

            winnerswehave = getnumbersfrom(line)

            for i in 1:length(winnerswehave)
                if haskey(copies, card + i)
                    copies[card+i] += copies[card]
                else
                    copies[card+i] = copies[card]
                end
            end
        end
    end

    sum(values(copies)) # 5329815
end

end # module day04