module ArraysTests

using Test

@testset "Interfaces" begin include("InterfaceTests.jl") end

@testset "BlockArraysCoo" begin include("BlockArraysCooTests.jl") end

# @testset "VectorsOfBlockArrayCoo" begin include("VectorsOfBlockArrayCooTests.jl") end

@testset "CachedArrays" begin include("CachedArraysTests.jl") end

@testset "Mappings" begin include("MappingsTests.jl") end

@testset "LazyArrays" begin include("LazyArraysTests.jl") end

@testset "CompressedArrays" begin include("CompressedArraysTests.jl") end

@testset "FilteredArraysTests" begin include("FilteredArraysTests.jl") end

# @testset "Tables" begin include("TablesTests.jl") end

@testset "Reindex" begin include("ReindexTests.jl") end

@testset "PosNegReindex" begin include("PosNegReindexTests.jl") end

# @testset "IdentityVectors" begin include("IdentityVectorsTests.jl") end

# @testset "SubVectors" begin include("SubVectorsTests.jl") end

# @testset "ArrayPairs" begin include("ArrayPairsTests.jl") end

# @testset "AppendedArrays" begin include("AppendedArraysTests.jl") end

# @testset "AutodiffTests" begin include("AutodiffTests.jl") end

# @testset "VectorWithEntryRemovedTests" begin include("VectorWithEntryRemovedTests.jl") end

# @testset "VectorWithEntryInsertedTests" begin include("VectorWithEntryInsertedTests.jl") end

end # module
