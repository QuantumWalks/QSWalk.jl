# ------------------------------------------------------------------------------
# Example 4: spontaneous moralization on the path graph
# ------------------------------------------------------------------------------

using QSWalk
using PyPlot # for plot
using LightGraphs # for PathGraph

## nonsymmetric case

dim = 101 #odd for unique middle point
w = 0.5
time = 40.
adjacency = adjacency_matrix(PathGraph(dim))

midpoint = ceil(Int, dim/2)
lind, vset = nm_lindbladian(adjacency)
hglobal = nm_glob_ham(adjacency)
hlocal = nm_loc_ham(vset)
opnonsymmetric = evolve_generator(hglobal, [lind], hlocal, w)
rhoinit = nm_init(vset[[midpoint]], vset)

rho_nonsymmetric = evolve(opnonsymmetric, rhoinit, time)
positions = (collect(1:dim)-midpoint)
measurement_nonsymmetric = nm_measurement(rho_nonsymmetric, vset)
println(sum(positions .* measurement_nonsymmetric))

figure(figsize=[2.5, 1.5])
plot(positions, measurement_nonsymmetric, "k")
plot(positions, reverse(measurement_nonsymmetric), "b--")
xlabel("position")
ylabel("probability")
tick_params(labelsize=9)
axis([positions[1], positions[end], 0, maximum(measurement_nonsymmetric)])
vlines(0,0.,maximum(measurement_nonsymmetric),linestyles="--")
savefig("nonsymmetric.pdf", bbox_inches="tight")

## symmetric case

dim = 101 #odd for unique middle point
w = 0.5
time = 40.
adjacency = adjacency_matrix(PathGraph(dim))
midpoint = ceil(Int, dim/2)

linddescription1 = Dict(1 => ones(1,1), 2 => [1 1; 1 -1])
linddescription2 = Dict(1 => ones(1,1), 2 => [1 1; -1 1])
lind1, vset = nm_lindbladian(adjacency, linddescription1)
lind2, vset = nm_lindbladian(adjacency, linddescription2)
hglobal = nm_glob_ham(adjacency)
hlocal = nm_loc_ham(vset)
opsymmetric = evolve_generator(hglobal, [lind1, lind2], hlocal, w)
rhoinit = nm_init(vset[[midpoint]], vset)

rho_symmetric = evolve(opsymmetric, rhoinit, time)
positions = (collect(1:dim)-midpoint)
measurement_symmetric = nm_measurement(rho_symmetric, vset)
println(sum(positions .* measurement_symmetric))

figure(figsize=[2.5, 1.5])
plot(positions, measurement_symmetric, "k")
plot(positions, reverse(measurement_symmetric), "--b")
xlabel("position")
ylabel("probability")
tick_params(labelsize=9)
axis([positions[1], positions[end], 0, maximum(measurement_symmetric)])
vlines(0,0.,maximum(measurement_symmetric),linestyles="--")
savefig("symmetric.pdf", bbox_inches="tight")
