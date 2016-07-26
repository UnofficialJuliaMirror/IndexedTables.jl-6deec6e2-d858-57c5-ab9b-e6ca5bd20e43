using Base.Test
using NDSparseData

let lo=1, hi=10
    I = NDSparseData.Interval(lo, hi)
    @test lo in I
    @test hi in I
    @test !(hi+1 in I)
    @test !(lo-1 in I)
    @test  (lo+1 in I)
    for left in [true, false]
        for right in [true, false]
            I = NDSparseData.Interval{Int,left,right}(lo, hi)
            @test (lo in I) == left
            @test (hi in I) == right
            @test (hi+1 in I) == false
            @test (lo-1 in I) == false
            @test (lo+1 in I) == true
        end
    end
end

import NDSparseData: @dimension, Dimension

@dimension Year
@test Year(1) == Year(1)
@test Year(1) != Year(2)
@test isless(Year(1), Year(2))
@test !isless(Year(2), Year(1))
@test repr(Year(2016)) == "Year(2016)"
@test convert(Int, Year(2000)) === 2000
@test convert(Year, 1999) === Year(1999)

let a = NDSparse([12,21,32], [52,41,34], [11,53,150]), b = NDSparse([12,23,32], [52,43,34], [56,13,10])
    p = collect(NDSparseData.product(a, b))
    @test p == [(11,56), (11,13), (11,10), (53,56), (53,13), (53,10), (150,56), (150,13), (150,10)]

    p = collect(NDSparseData.product(a, b, a))
    @test p == [(11,56,11),(11,56,53),(11,56,150),(11,13,11),(11,13,53),(11,13,150),(11,10,11),(11,10,53),(11,10,150),
                (53,56,11),(53,56,53),(53,56,150),(53,13,11),(53,13,53),(53,13,150),(53,10,11),(53,10,53),(53,10,150),
                (150,56,11),(150,56,53),(150,56,150),(150,13,11),(150,13,53),(150,13,150),(150,10,11),(150,10,53),(150,10,150)]
end

let a = [1:10;]
    @test NDSparseData._sizehint!(1:10, 20) == 1:10
    @test NDSparseData._sizehint!(a, 20) === a
end
