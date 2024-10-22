



#################################### Legend settings ##################################

function legend_settings_firstOrder(numberTest::Int,
                                        algo::Geraldine.AdamConstStep, sampling::Geraldine.AbstractSampling)
    setting = "T$(numberTest): Adam"
    setting = string(setting, legend_sampling(sampling))
    setting = string(setting, " α=$(algo.α)")
#     setting = string(setting, " β1=$(algo.β_1)")
#     setting = string(setting, " β2=$(algo.β_2)")
    return setting
end

function legend_settings_firstOrder(numberTest::Int,
                                        algo::Geraldine.SGDConstStep, sampling::Geraldine.AbstractSampling)
    setting = "T$(numberTest): SGD"
    setting = string(setting, legend_sampling(sampling))
    setting = string(setting, " α=$(algo.α)")
    return setting
end

function legend_settings_secondOrder(numberTest::Int,
                                    btr::Geraldine.BTRStruct{Hessian, CG, SAM},
                                    sampling::Geraldine.AbstractSampling) where {Hessian<:Geraldine.HessianApproximation, CG <: Geraldine.AbstractConjugateGradient,
    SAM <: Geraldine.AbstractSampling}
    if Hessian <: Geraldine.BHHHScores
        setting = "T$(numberTest): BTR-bhhh"
    elseif Hessian <: Geraldine.UncomputedHessian
        setting = "T$(numberTest): BTR-TH"
    elseif (Hessian <: Geraldine.DiagBHHHApprox)
        setting = "T$(numberTest): BTR-D-bhhh"
    elseif (Hessian <: Geraldine.DiagAdamApprox)
        setting = "T$(numberTest): BTR-D-Adam"
    elseif (Hessian <: Geraldine.AdamTRApprox)
        setting = "T$(numberTest): BTR-Adam"
    elseif (Hessian <: Geraldine.IdentityApprox)
        setting = "T$(numberTest): TR-SGD"
    else
        error("Legend not defined for this Hessian Approximation type")
    end
    setting = string(setting, legend_sampling(sampling))
    setting = string(setting, legend_smoothing(sampling.smoothing))
    return setting
end


function legend_sampling(sampling::RandomSampling)
    return " (VAI N=$(sampling.N))"
end

function legend_sampling(sampling::BatchSampling)
    return " (Batch N=$(sampling.N))"
end

function legend_sampling(sampling::RandomSamplingDynamic)
    if sampling.commonVar
        setting = " (VAI/VAC sHs)"
    else
        setting = " (VAI sHs)"
    end
    return setting
end

function legend_sampling(sampling::RandomSamplingDynamicTrueVariance)
    if sampling.commonVar
        setting = " (VAI/VAC-tv)"
    else
        setting = " (VAI-tv)"
    end
    return setting
end


function legend_sampling(sampling::DynamicSAA)
    return " (VAC sHs)"
end


function legend_sampling(sampling::TrueVarDynamicSAA)
    return " (VAC-tv)"
end

########################

function legend_smoothing(smoothing::Geraldine.NoSmoothing)
    return " NoSmoothing"
end

function legend_smoothing(smoothing::Geraldine.NaiveSmoothing)
    return " Naive($(smoothing.coeffInf), $(smoothing.coeffSup))"
end

function legend_smoothing(smoothing::Geraldine.SameOverIter)
    return " CMS($(smoothing.maxIter))"
end

function legend_smoothing(smoothing::Geraldine.CumulativeDecreaseSmoothing)
    return " CMS-cum($(smoothing.maxIter))"
end
