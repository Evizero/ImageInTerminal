@testset "STDOUT" begin
    # make sure it compiles and executes
    # TODO: replace this with VT100 tests
    imshow(colorview(RGB, rand(3,2,2))); println()
    imshow(colorview(RGB, rand(3,2,2)), (2,2)); println()
    imshow256(colorview(RGB, rand(3,2,2))); println()
    imshow256(colorview(RGB, rand(3,2,2)), (2,2)); println()
    imshow24bit(colorview(RGB, rand(3,2,2))); println()
    imshow24bit(colorview(RGB, rand(3,2,2)), (2,2)); println()
end

@testset "imshow" begin
    @testset "non colorant" begin
        @test_throws ArgumentError imshow(rand(5,5))
        @test_throws ArgumentError imshow(sprand(5,5,.5))
    end
    @testset "monarch" begin
        img = imresize(monarch, 10, 10)
        io = IOBuffer()
        ensurecolor(imshow256, io, img)
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/monarch_big_imshow.txt" res
    end
    @testset "ndarray" begin
        img = rgb_line_4d
        io = IOBuffer()
        ensurecolor(imshow256, io, img)
        res = readlines(seek(io, 0))
        @test_reference "reference/ndarray_imshow.txt" res
    end
end

@testset "imshow256" begin
    @testset "non colorant" begin
        @test_throws ArgumentError imshow256(rand(5,5))
        @test_throws ArgumentError imshow256(sprand(5,5,.5))
    end
    @testset "rgb line" begin
        io = IOBuffer()
        ensurecolor(imshow256, io, rgb_line)
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/rgbline_big_imshow256.txt" res
        io = IOBuffer()
        ensurecolor(imshow256, io, rgb_line, (1, 45))
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/rgbline_small1_imshow256.txt" res
        io = IOBuffer()
        ensurecolor(imshow256, io, rgb_line, (1, 19))
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/rgbline_small2_imshow256.txt" res
    end
    @testset "monarch" begin
        img = imresize(monarch, 10, 10)
        io = IOBuffer()
        ensurecolor(imshow256, io, img)
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/monarch_big_imshow256.txt" res
        io = IOBuffer()
        ensurecolor(imshow256, io, img, (10, 20))
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/monarch_small_imshow256.txt" res
    end
    @testset "ndarray" begin
        img = rgb_line_4d
        io = IOBuffer()
        ensurecolor(imshow256, io, img)
        res = readlines(seek(io, 0))
        @test_reference "reference/ndarray_imshow256.txt" res
    end
end

@testset "imshow24bit" begin
    @testset "non colorant" begin
        @test_throws ArgumentError imshow24bit(rand(5,5))
        @test_throws ArgumentError imshow24bit(sprand(5,5,.5))
    end
    @testset "rgb line" begin
        io = IOBuffer()
        ensurecolor(imshow24bit, io, rgb_line)
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/rgbline_big_imshow24bit.txt" res
        io = IOBuffer()
        ensurecolor(imshow24bit, io, rgb_line, (1, 45))
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/rgbline_small1_imshow24bit.txt" res
        io = IOBuffer()
        ensurecolor(imshow24bit, io, rgb_line, (1, 19))
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/rgbline_small2_imshow24bit.txt" res
    end
    @testset "monarch" begin
        img = imresize(monarch, 10, 10)
        io = IOBuffer()
        ensurecolor(imshow24bit, io, img)
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/monarch_big_imshow24bit.txt" res
        io = IOBuffer()
        ensurecolor(imshow24bit, io, img, (10, 20))
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/monarch_small_imshow24bit.txt" res
    end
    @testset "ndarray" begin
        img = rgb_line_4d
        io = IOBuffer()
        ensurecolor(imshow24bit, io, img)
        res = readlines(seek(io, 0))
        @test_reference "reference/ndarray_imshow24bit.txt" res
    end
end

@testset "imshow non1" begin
    @testset "monarch" begin
        img = OffsetArray(imresize(monarch, 10, 10), (-10,5))
        io = IOBuffer()
        ensurecolor(imshow256, io, img)
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/monarch_big_imshow.txt" res
    end
    @testset "rotation" begin
        tfm = recenter(RotMatrix(-pi/4), center(lighthouse))
        lhr = ImageTransformations.warp(lighthouse, tfm)
        io = IOBuffer()
        ensurecolor(imshow256, io, lhr)
        res = replace.(readlines(seek(io, 0)), Ref("\n" => ""))
        @test_reference "reference/lighthouse_rotated.txt" res
    end
end
