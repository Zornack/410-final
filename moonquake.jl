
using Plots
c = 400
c² = 400*400
Δx = 0.1
Δy = Δx
CFL = 0.001
Δt = CFL*Δx/c

Tf = 0.1
M = Integer(round(Tf/Δt)) # how many time steps to take

N = Integer(round(1/Δx)) # N+1 total spatial nodes

#x = [0:Δx:1]
x = collect(range(0, 1, step = Δx))
y = collect(range(0, 1, step = Δy))
x_int = x[2:end-1] #interior spatial nodes 
y_int = y[2:end-1] #interior spatial nodes 

t = collect(range(0, Tf, step = Δt))

u = zeros(N+1, N+1, M+1)
v = zeros(N+1, N+1, M+1)

for i = 4:N-2
    for j = 4:N-2
        u[i, j, 1] = 50
    end
end

for n = 1:M  # Take M total time steps
    for i = 2:N
        for j = 2:N

            u[i, j, n+1] = u[i,j,n] + Δt*v[i,j,n]

            v[i,j,n+1] = v[i,j,n] + (Δt*c²)/(Δx*Δx)*(u[i+1, j, n] + u[i-1, j, n] +
            u[i, j+1, n] + u[i, j-1, n] - 4*u[i, j, n])

            # u[:,2,n+1] = u[:,2,n+1]*.1
            # u[:,end-1,n+1] = u[:,end-1,n+1]*.1
            # u[2,:,n+1] = u[2,:,n+1]*.1
            # u[end-1,:,n+1] = u[end-1,:,n+1]*.1

        end
    end
end



for n = 1:100:M+1

    # For a contour plot, uncomment below
    # p = plot3d(x, y, u[:, :, n], clims = (0, 1))

    # For a surface plot, uncomment below
    p = surface(x, y, u[:, :, n], zlims = (-100,100))
    display(p)
end