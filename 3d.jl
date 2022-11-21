using Plots
include("euler_methods.jl")

# u_t = κ*(u_xx + u_yy) + F(t, x, y) on the domain 0 ≤ x, y ≤ 1, 0 ≤ t ≤ Tf
# u(0, x, y) = f(x, y)
# u(t, 0, y) = u(t, 1, y) = u(t, x, 0) = u(t, x, 1) = 0
# using second-order finite difference approx in space, and forward Euler in time. 


# λ = Δt/Δx^2, Stability → λ ≤ 1/(2κ)

κ = 1
Δx = 0.1
Δy = Δx
λ = 0.5*(1/(2κ))
Δt = round(λ*Δx^2, digits = 10)

Tf = 1
M = Integer(Tf/Δt) # how many time steps to take

N = Integer(1/Δx) # N+1 total spatial nodes

#x = [0:Δx:1]
x = collect(range(0, 1, step = Δx))
y = collect(range(0, 1, step = Δy))
x_int = x[2:end-1] #interior spatial nodes 
y_int = y[2:end-1] #interior spatial nodes 

t = collect(range(0, Tf, step = Δt))

u = zeros(N+1, N+1, M+1)

function F(t, x, y)
    return 0
end

function f(x, y)
    return sin(π*x)*(sin.(π*y))'
end

# fill in initial data into u:
# u[2:N, 2:N, 1] = f(x_int, y_int)
# OR:
for i = 2:N
    for j = 2:N
        u[i, j, 1] = sin(π*x[i])*sin(π*y[j])
    end
end



for n = 1:M  # Take M total time steps
    for i = 2:N
        for j = 2:N
            u[i, j, n+1] = u[i, j, n] + λ*κ*(u[i+1, j, n] + u[i-1, j, n] + 
                                        u[i, j+1, n] + u[i, j-1, n] - 4*u[i, j, n]) + 
                                        Δt*F(t[n], x[i], y[j])
        end
    end
end



for n = 1:M+1

    # For a contour plot, uncomment below
    #p = plot3d(x, y, u[:, :, n], clims = (0, 1))

    # For a surface plot, uncomment below
    p = surface(x, y, u[:, :, n], zlim = (0, 1))
    display(p)
    sleep(1)
end