_tostring(io) = replace.(replace.(readlines(seek(io,0)), ["\n"] => [""]), ["$Int"], ["Int64"])

@testset "256 colors" begin
    ImageInTerminal.use_256()
    io = IOBuffer()
    ensurecolor(show, io, MIME"text/plain"(), lena)
    @test_reference "lena_show_256" _tostring(io)
    if VERSION < v"0.6-" # FIXME: first line (i.e. summary) changes in 0.6
        io = IOBuffer()
        ensurecolor(show, io, MIME"text/plain"(), rgb_line)
        @test_reference "rgbline_show_256" _tostring(io)
    end
    io = IOBuffer()
    ensurecolor(show, io, MIME"text/plain"(), RGB(0.5,0.1,0.9))
    @test_reference "colorant_show_256" _tostring(io)
end

@testset "24 bit" begin
    ImageInTerminal.use_24bit()
    io = IOBuffer()
    ensurecolor(show, io, MIME"text/plain"(), lena)
    @test_reference "lena_show_24bit" _tostring(io)
    if VERSION < v"0.6-" # FIXME: first line (i.e. summary) changes in 0.6
        io = IOBuffer()
        ensurecolor(show, io, MIME"text/plain"(), rgb_line)
        @test_reference "rgbline_show_24bit" _tostring(io)
    end
    io = IOBuffer()
    ensurecolor(show, io, MIME"text/plain"(), RGB(0.5,0.1,0.9))
    @test_reference "colorant_show_24bit" _tostring(io)
end

ImageInTerminal.use_256()
