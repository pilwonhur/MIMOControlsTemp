module MIMOControlsTemp

greet() = print("Hello World!")

export	kalmandecomp,
		findprojector,
		mqr,
		minimumreal,
		mmult,
		madd,
		msub,
		transp,
		cjt,
		cj,
		minv,
		mscl,
		sbs,
		abv,
		daug,
		eye,
		eyec
		# hinflmi,
		# hinfbis,
		# h2lmi,
		# h2gram,
		# splitSS,
		# complex2real,
		# LQRlmi,
		# h2syn,
		# hinfsyn,
		# lft,
		# are

# using Pkg
# l = ["ControlSystems","LinearAlgebra","JuMP","ProxSDP"]
# for item in l
#     Pkg.add(item)
# end

using LinearAlgebra, ControlSystems # JuMP, ProxSDP
# # using SCS, Convex

include("matrix_comps.jl")
end # module