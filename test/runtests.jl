using PATHSolver
using Base.Test

M = [0  0 -1 -1 ;
     0  0  1 -2 ;
     1 -1  2 -2 ;
     1  2 -2  4 ]

q = [2; 2; -2; -6]

myfunc(x) = M*x + q

n = 4
lb = zeros(n)
ub = 100*ones(n)

path_options(   "convergence_tolerance 1e-2",
                "output yes",
                "time_limit 3600"      )

status, z, f = solveMCP(myfunc, lb, ub)

@show status
@show z
@show f


@test isapprox(z, [2.8, 0.0, 0.8, 1.2])
@test status == :Solved


println("-------------------------------------------------------")


M = [0  0 -1 -1 ;
     0  0  1 -2 ;
     1 -1  2 -2 ;
     1  2 -2  4 ]

q = [2; 2; -2; -6]

myfunc(x) = M*x + q

n = 4
lb = zeros(n)
ub = 100*ones(n)

path_options(   "convergence_tolerance 1e-2",
                "output no",
                "time_limit 3600"      )

status, z, f = solveMCP(myfunc, lb, ub)

@show status
@show z
@show f

@test isapprox(z, [2.8, 0.0, 0.8, 1.2])
@test status == :Solved



println("-------------------------------------------------------")


function elemfunc(x)
    val = similar(x)
    val[1] = -x[3]-x[4] + q[1]
    val[2] = x[3] -2x[4] + q[2]
    val[3] = x[1]-x[2]+2x[3]-2x[4] + q[3]
    val[4] = x[1]+2x[2]-2x[3]+4x[4] + q[4]
    return val
end

n = 4
lb = zeros(n)
ub = 100*ones(n)

status, z, f = solveMCP(elemfunc, lb, ub)

@show status
@show z
@show f


@test isapprox(z, [2.8, 0.0, 0.8, 1.2])
@test status == :Solved
