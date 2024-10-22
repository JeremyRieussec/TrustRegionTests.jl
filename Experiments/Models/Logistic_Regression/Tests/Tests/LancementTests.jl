# Fonctions de lancement

function lancementTest(test::SecondOrderTest, allTests::AllTests)

    _, acc =  test.algo(allTests.model, allTests.x0, test.sam ; b = test.b,
                        verbose = test.verbose, accumulator = test.accumulator)

    data = (getData(acc))

    if (typeof(test.sam) <: Union{Geraldine.AbstractRandomDynamicTrueVar, Geraldine.AbstractTrueVarSAA})
        append!(allTests.all_dataVariance, [data])
    else
        append!(allTests.all_dataNormal, [data])
    end

end

function lancementTest(test::FirstOrderTest, allTests::AllTests)

    _, acc = test.algo(allTests.model, test.state ;
                        verbose = test.verbose, accumulator = test.accumulator, sp = test.sp)


    data = (getData(acc))

    append!(allTests.all_dataNormal, [data])
end

function lancementAllTests(tests::Array{Test, 1}, allTests::AllTests)
    for test in tests
       lancementTest(test, allTests)
    end
end
