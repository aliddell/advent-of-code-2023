module day03

getschematic() = open(joinpath(@__DIR__, "input")) do io
    readlines(io)
end

function findnumbers(line::AbstractString)
    numre = r"(?<![\d])\d+" # digits preceded by non-digits
    findall(numre, line)
end

function isnearsymbol(lines, lineno, idx)
    start = idx.start
    stop = idx.stop
    line = lines[lineno]
    eol = length(line)

    if start > 1 && line[start - 1] != '.'
        return true
    end

    if stop < eol && line[stop + 1] != '.'
        return true
    end

    nextstart = max(1, start - 1)
    nextstop = min(eol, stop + 1)

    if lineno > 1
        prevline = lines[lineno - 1]
        if any(split(prevline[nextstart:nextstop], "") .≠ ".")
            return true
        end
    end

    if lineno < length(lines)
        nextline = lines[lineno + 1]
        if any(split(nextline[nextstart:nextstop], "") .≠ ".")
            return true
        end
    end

    false
end

function problem1()
    val = 0
    lines = getschematic()
    for (lineno, line) in enumerate(lines)
        indices = findnumbers(line)
        for idx in indices
            if isnearsymbol(lines, lineno, idx)
                val += parse(Int64, line[idx])
            end
        end
    end
    val # 527369
end

function nearbynumbers(lines, lineno, idx)
    line = lines[lineno]
    eol = length(line)

    numsnearby = Vector{Int64}()

    if idx > 1
        prevline = lines[lineno - 1]
        numbers = findnumbers(prevline)
        for num in numbers
            if idx in num || idx - 1 in num || idx + 1 in num
                push!(numsnearby, parse(Int64, prevline[num]))
            end
        end
    end

    numbers = findnumbers(line)
    for num in numbers
        if idx in num || idx - 1 in num || idx + 1 in num
            push!(numsnearby, parse(Int64, line[num]))
        end
    end

    if idx < eol
        nextline = lines[lineno + 1]
        numbers = findnumbers(nextline)
        for num in numbers
            if idx in num || idx - 1 in num || idx + 1 in num
                push!(numsnearby, parse(Int64, nextline[num]))
            end
        end
    end

    numsnearby
end

function problem2()
    val = 0
    lines = getschematic()

    for (lineno, line) in enumerate(lines)
        indices = map(x -> x[1], findall("*", line))
        for idx in indices
            numsnearby = nearbynumbers(lines, lineno, idx)
            if 2 == length(numsnearby)
                val += prod(numsnearby)
            end
        end
    end

    val # 73074886
end

end # module day03