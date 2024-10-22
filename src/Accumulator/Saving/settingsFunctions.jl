
######################################## Full settings ################################################

function full_settings_firstOrder(numberTest::Int,
                                        algo::Geraldine.AbstractSGD,
                                        state::Geraldine.AbstractState,
                                        sp::Geraldine.StopParam)
    setting = "\n \n############## Test $(numberTest) ###############\n \n"
    setting = string(setting, firstOrder_full_settings(algo))
    setting = string(setting, full_settings(state.sampling))
    setting = string(setting, stop_full_settings(sp))
    return setting
end

function full_settings_secondOrder(numberTest::Int,
                                    btr::Geraldine.BTRStruct{Hessian, CG, SAM},
                                    btrCoeffs::Geraldine.AbstractBasicTrustRegion,
                                    sampling::Geraldine.AbstractSampling) where {Hessian<:Geraldine.HessianApproximation, CG <: Geraldine.AbstractConjugateGradient,
    SAM <: Geraldine.AbstractSampling}
    setting = "\n \n############## Test $(numberTest) ###############\n \n"
    setting = string(setting, "## Basic Trust Region (BTR) ##\n")
    if (Hessian <: Geraldine.UncomputedHessian)
        setting = string(setting, " + Uncomputed True Hessian \n")
    elseif (Hessian <: Geraldine.BHHHScores)
        setting = string(setting, " + Uncomputed BHHH \n")
    elseif (Hessian <: Geraldine.DiagBHHHApprox)
        setting = string(setting, " + Diagonal Approximation BHHH \n")
    elseif (Hessian <: Geraldine.DiagAdamApprox)
        setting = string(setting, " + Diagonal Approximation Adam \n")
    elseif (Hessian <: Geraldine.AdamTRApprox)
        setting = string(setting, " + Adam TR \n")
    elseif (Hessian <: Geraldine.IdentityApprox)
        setting = string(setting, " + SGD-TR \n")
    else
        error("Setting not defined for this Hessian Approximation type")
    end
    setting = string(setting, btrCoeffs_full_settings(btrCoeffs))
    setting = string(setting, stop_full_settings(btr.stopparm))
    setting = string(setting, full_settings(sampling))
    return setting
end


function btrCoeffs_full_settings(btrCoeffs::Geraldine.BasicTrustRegionWithStep)
    setting = "## region update with step norm ‖s‖ ##\n"
    setting = string(setting, " + rejection threshold, η1 = $(btrCoeffs.η1) \n")
    setting = string(setting, " + very good iteration threshold, η2 = $(btrCoeffs.η2) \n")
    setting = string(setting, " + contraction BAD iteration, γ1 = $(btrCoeffs.γ1) \n")
    setting = string(setting, " + contraction GOOD iteration, γ2 = $(btrCoeffs.γ2) \n")
    return setting
end

function btrCoeffs_full_settings(btrCoeffs::Geraldine.BasicTrustRegionWithCoeff)
    setting = "## region update with coefficients ##\n"
    setting = string(setting, " + rejection threshold, η1 = $(btrCoeffs.η1) \n")
    setting = string(setting, " + very good iteration threshold, η2 = $(btrCoeffs.η2) \n")
    setting = string(setting, " + contraction BAD iteration, γ1 = $(btrCoeffs.γ1) \n")
    setting = string(setting, " + contraction GOOD iteration, γ2 = $(btrCoeffs.γ2) \n")
    setting = string(setting, " + expansion VERY GOOD iteration, γ3 = $(btrCoeffs.γ3) \n")
    return setting
end

###############################

function stop_full_settings(sp::Geraldine.StopParam)
    setting = "## Stopping parameters ##\n"
    setting = string(setting, " + ϵ = $(sp.tol) \n")
    setting = string(setting, " + Iter Max = $(sp.NMax) \n")
    setting = string(setting, " + Time Max = $(sp.TMax) (s) \n")
    return setting
end

function stop_full_settings(sp::Geraldine.StoppingTests)
    setting = "## Stopping parameters ##\n"
    return setting
end

#################################

function firstOrder_full_settings(algo::AdamConstStep)
    setting = "#######  Adam Constant steplength #######\n"
    setting = string(setting, " + α = $(algo.α)\n")
    setting = string(setting, " + β_1 = $(algo.β_1)\n")
    setting = string(setting, " + β_2 = $(algo.β_2)\n")
    return setting
end

function firstOrder_full_settings(algo::SGDConstStep)
    setting = "#######  SGD Constant steplength #######\n"
    setting = string(setting, " + α = $(algo.α)\n")
    return setting
end

######################### Sampling #################

function full_settings(sampling::RandomSampling)
    setting = "\n### Fixed size sampling ### \n"
    setting = string(setting, " + VAI \n")
    setting = string(setting, " + N = $(sampling.N) \n")
    setting = string(setting, " + Population size = $(sampling.NMax) \n")
    return setting
end

function full_settings(sampling::BatchSampling)
    setting = "\n### Batch sampling ### \n"
    setting = string(setting, " + Cycling epochs / Batch \n")
    setting = string(setting, " + N = $(sampling.N) \n")
    setting = string(setting, " + Population size = $(sampling.NMax) \n")
    return setting
end

################## Dynamic Sampling ###############

function full_settings(sampling::DynamicSAA)
    setting = "\n### Dynamic sampling ### \n"
    setting = string(setting, " + sHs : Fisher information \n")
    setting = string(setting, " + VAC \n")

    setting = string(setting, confidence_interval(sampling))

    setting = string(setting, dynamic_sampling_details(sampling))
    return setting
end

function full_settings(sampling::TrueVarDynamicSAA)
    setting = "\n### Dynamic sampling ### \n"
    setting = string(setting, " + True Variance \n")
    setting = string(setting, " + VAC \n")

    setting = string(setting, confidence_interval(sampling))

    setting = string(setting, dynamic_sampling_details(sampling))

    setting = string(setting, smoothing_details(sampling.smoothing))
    return setting
end

function full_settings(sampling::RandomSamplingDynamicTrueVariance)
    setting = "\n### Dynamic sampling ### \n"
    setting = string(setting, " + True Variance \n")

    if sampling.commonVar
       setting = string(setting, " + VAC / VAI \n")
    else
        setting = string(setting, " + VAI \n")
    end
    setting = string(setting, confidence_interval(sampling))

    setting = string(setting, dynamic_sampling_details(sampling))

    setting = string(setting, smoothing_details(sampling.smoothing))
    return setting
end

function full_settings(sampling::RandomSamplingDynamic)
    setting = "\n### Dynamic sampling ### \n"
    setting = string(setting, " + sHs : Fisher information \n")
    if sampling.commonVar
       setting = string(setting, " + VAC / VAI \n")
    else
        setting = string(setting, " + VAI \n")
    end
    setting = string(setting, confidence_interval(sampling))

    setting = string(setting, dynamic_sampling_details(sampling))
    return setting
end

########################################################

function dynamic_sampling_details(sampling::AbstractSampling)
    setting = "Sample size initialisation : \n"
    setting = string(setting, " + N min = $(sampling.NMin)\n")
    setting = string(setting, " + N max = $(sampling.NMax)\n")
    setting = string(setting, " + increment = $(sampling.increment)\n")
    setting = string(setting, " + N0 = $(sampling.N0)\n")

    setting = string(setting, subsampling_details(sampling.subSampling))

    return setting
end

#####################################################
function confidence_interval(sampling::AbstractSampling)
    setting = "Confidence Interval : \n"
    setting = string(setting, " + α error = $(sampling.α_error) \n")
    setting = string(setting, " + quantile (1 - α) = $(sampling.z_α) \n")
    return setting
end

#######################################################

function subsampling_details(subSampling::Geraldine.ConstantCoeffSubSampling)
    setting =  "Sub-sampling : \n"
    setting = string(setting, " + size = $(subSampling.coeff)*N \n")
    setting = string(setting, " + size max = $(subSampling.Nmax) \n")

    return setting
end

##########################################################################

function smoothing_details(smoothing::Geraldine.NoSmoothing)
    setting = "Smoothing : ## None ##\n"
    return setting
end

function smoothing_details(smoothing::Geraldine.NaiveSmoothing)
    setting = "Smoothing : ## Naive ##\n"
    setting = string(setting, " + coeff decrease = $(smoothing.coeffInf)\n")
    setting = string(setting, " + coeff increase = $(smoothing.coeffSup)\n")
    return setting
end

function smoothing_details(smoothing::Geraldine.CumulativeDecreaseSmoothing)
    setting = "Smoothing : ## CMS -- cumulative ##\n"
    setting = string(setting, " + max iterations = $(smoothing.maxIter)\n")
    return setting
end

function smoothing_details(smoothing::Geraldine.SameOverIter)
    setting = "Smoothing : ## CMS -- heuristic  ##\n"
    setting = string(setting, " + max iterations = $(smoothing.maxIter)\n")
    return setting
end
