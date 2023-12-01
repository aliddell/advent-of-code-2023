module day01

function problem1()
    calibrationvalues = Vector{Int64}()
    open(joinpath(@__DIR__, "input")) do io
        for line in eachline(io)
            digits = Vector{Int64}()
            for c in line
                if (isdigit(c))
                    push!(digits, parse(Int64, c))
                end
            end

            @assert length(digits) ≥ 1
            10 * digits[1] + digits[end]
            push!(calibrationvalues, 10 * digits[1] + digits[end])
        end
    end

    sum(calibrationvalues) # 54601
end

function problem2()
    calibrationvalues = Vector{Int64}()
    replacements = Dict{String, Int64}(
        "one" => 1,
        "two" => 2,
        "three" => 3,
        "four" => 4,
        "five" => 5,
        "six" => 6,
        "seven" => 7,
        "eight" => 8,
        "nine" => 9
    )

    open(joinpath(@__DIR__, "input")) do io
        for line in eachline(io)
            digits = Vector{Int64}()
            for i in eachindex(line)
                if (isdigit(line[i]))
                    push!(digits, parse(Int64, line[i]))
                end

                for (k, v) in replacements
                    if startswith(line[i:end], k)
                        push!(digits, v)
                    end
                end
            end

            push!(calibrationvalues, 10 * digits[1] + digits[end])
        end
    end

    sum(calibrationvalues) # 54078
end

end # module day01