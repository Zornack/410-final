using Plots
Lx = 10
Ly = 10
dx = 0.1
dy = dx
nx = Integer(Lx/dx)
ny = Integer(Ly/dy)
x = collect(range(0, Lx, nx))
y = collect(range(0, Ly, ny))
T = 10
wn = zeros(nx,ny)
wnm1 = wn
wnp1 = wn
CFL = 0.5
c = 400
dt = CFL*dx/c
t = 0


while t < T
    global wn[:,1] .= 0
    global wn[:,end] .= 0
    global wn[1,:] .= 0
    global wn[end,:] .= 0
    global t = t + dt
    global wnm1 = wn
    global wn = wnp1
    global wn[50,50] = dt^2*20*sin(30*pi*t/20)
    for i = 2:nx-1
        for j = 2:ny-1
            global wnp1[i,j] = 2*wn[i,j] - wnm1[i,j] + CFL^2 * (wn[i+1,j] + wn[i,j+1] - 4*wn[i,j] + wn[i-1,j] + wn[i,j-1])
        end
    end 
    p = plot3d(x, y, wnp1[:, :], clims = (-0.02,0.02))
    display(p)
    sleep(0.01)
end