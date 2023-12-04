module day03

getschematic() = open(joinpath(@__DIR__, "input")) do io
    readlines(io)
end

function findnumbers(line::AbstractString)
    numre = r"(?<![\d])\d+" # digits preceded by non-digits
    findall(numre, line)
end

end # module day03