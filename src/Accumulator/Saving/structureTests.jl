

##################### Accumulator ######################

Accum(xstar::Vector = [0.0, 1, 1, 2, 3, 5, 8, 13, 21, 34]) = Accumulator(Value(), Iter(),
                FieldAccumulator{Float64}(:fcand), Delta(), Times(), SamplingSizeAccumulator(), DistTo(xstar),
                FieldAccumulator{Float64}(:mu), FieldAccumulator{Float64}(:sigma2), FieldAccumulator{Float64}(:sHs) ,
                FieldAccumulator{Float64}(:ρ), IsAcceptedAccumulator(), Param())

################### Accumulator ##############################

Accum_fo() = Accumulator(Value(), Iter(), NGrad(), Times(), Geraldine.Param())

################### Accumulator ##############################
Accum_tv() = Accumulator(Iter(), Delta(), Times(), SamplingSizeAccumulator(), FieldAccumulator{Int64}(:iterCG),
        FieldAccumulator{Float64}(:mu), FieldAccumulator{Float64}(:ρ),
        FieldAccumulator{Float64}(:sHs), FieldAccumulator{Float64}(:sigma2), IsAcceptedAccumulator(), Geraldine.Param())

################### Accumulator ##############################
Accum_sHs() = Accumulator(Iter(), Delta(), Times(), SamplingSizeAccumulator(),  FieldAccumulator{Float64}(:mu),
                FieldAccumulator{Int64}(:iterCG), FieldAccumulator{Float64}(:ρ),
                FieldAccumulator{Float64}(:sHs), IsAcceptedAccumulator(), Geraldine.Param())


abstract type Test end

################################################################################
                    #  First-Order
################################################################################

mutable struct FirstOrderTest <: Test
    state::Geraldine.AbstractState
    sam::Geraldine.AbstractSampling
    algo::Geraldine.AbstractSGD

    accumulator::Geraldine.Accumulator

    sp::Geraldine.StopParam

    verbose::Bool

    function FirstOrderTest(state::Geraldine.AbstractState, sam::Geraldine.AbstractSampling,
                                algo::Geraldine.AbstractSGD,
                                sp::Geraldine.StopParam ; verbose::Bool=false)
        accumulator = Accum_fo()
        return new(state, sam, algo, accumulator, sp, verbose)
    end

    function FirstOrderTest(state::Geraldine.AbstractState, sam::Geraldine.AbstractSampling,
                                algo::Geraldine.AbstractSGD,
                                accumulator::Geraldine.Accumulator,
                                sp::Geraldine.StopParam ; verbose::Bool=false)
        return new(state, sam, algo, accumulator, sp, verbose)
    end
end

################################################################################
                    #  Second-Order
################################################################################

mutable struct SecondOrderTest <: Test
    algo::Geraldine.BTRStruct
    sam::AbstractSampling
    b::Geraldine.AbstractBasicTrustRegion

    accumulator::Geraldine.Accumulator
    verbose::Bool

    function SecondOrderTest(algo::Geraldine.BTRStruct, sam::AbstractSampling,
                                b::Geraldine.AbstractBasicTrustRegion,
                                ; verbose::Bool=false)
        # Definition accumulator
        if (typeof(sam) <: Union{Geraldine.AbstractRandomDynamicTrueVar, Geraldine.AbstractTrueVarSAA})
            accumulator = Accum_tv()
        else
            accumulator = Accum_sHs()
        end

        return new(algo, sam, b, accumulator, verbose)
    end

    function SecondOrderTest(algo::Geraldine.BTRStruct, sam::AbstractSampling,
                                b::Geraldine.AbstractBasicTrustRegion,
                                accumulator::Geraldine.Accumulator,
                                ; verbose::Bool=false)

        return new(algo, sam, b, accumulator, verbose)
    end
end

################################################################################
                    #  All Tests
################################################################################

mutable struct AllTests{T}
    model::AbstractModel
    x0::Vector{T}

    numberTest::Int

    testsNormal::Array{Test, 1}
    all_settingNormal::Array
    all_legendNormal::Array
    all_dataNormal::Array

    all_accuracy_testNormal::Array
    all_accuracy_trainNormal::Array


    testsVariance::Array{Test, 1}
    all_settingVariance::Array
    all_legendVariance::Array
    all_dataVariance::Array

    all_accuracy_testVariance::Array
    all_accuracy_trainVariance::Array

    function AllTests(model::AbstractModel, x0::Vector{T}) where T
        new{T}(model, x0, 0, Test[], [], [], [], [], [], Test[], [], [], [], [], [])
    end
end

function addTest(test::FirstOrderTest, allTests::AllTests)
    allTests.numberTest += 1
    append!(allTests.all_settingNormal, [full_settings_firstOrder(allTests.numberTest, test.algo, test.state, test.sp)])
    append!(allTests.all_legendNormal, [legend_settings_firstOrder(allTests.numberTest, test.algo, test.sam)])
    append!(allTests.testsNormal, [test])
end


function addTest(test::SecondOrderTest, allTests::AllTests)
    allTests.numberTest += 1
    if (typeof(sam) <: Union{Geraldine.AbstractRandomDynamicTrueVar, Geraldine.AbstractTrueVarSAA})
        append!(allTests.all_settingVariance, [full_settings_secondOrder(allTests.numberTest, test.algo, test.b, test.sam)])
        append!(allTests.all_legendVariance, [legend_settings_secondOrder(allTests.numberTest, test.algo, test.sam)])
        append!(allTests.testsVariance, [test])
    else
        append!(allTests.all_settingNormal, [full_settings_secondOrder(allTests.numberTest, test.algo, test.b, test.sam)])
        append!(allTests.all_legendNormal, [legend_settings_secondOrder(allTests.numberTest, test.algo, test.sam)])
        append!(allTests.testsNormal, [test])
    end
end


###############################################################################
import Base.println

function println(allTests::AllTests)

    println("### Tests with TRUE Variance: ")
    for legend in allTests.all_legendVariance
        println(" - ", legend)
    end

    println("### Tests with sHs: ")
    for legend in allTests.all_legendNormal
        println(" - ", legend)
    end
end
