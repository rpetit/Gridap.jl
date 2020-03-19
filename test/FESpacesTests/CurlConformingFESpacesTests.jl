# module CurlConformingFESpacesTests
##
using Test
using Gridap
using LinearAlgebra
using Gridap.FESpaces

domain =(0,1,0,1,0,1)
partition = (3,3,3)
model = CartesianDiscreteModel(domain,partition)
trian = get_triangulation(model)

order = 2

u(x) = VectorValue(x[1]*x[1],x[1]*x[1]*x[1],0.0)
# u(x) = x

V = TestFESpace(
  reffe = :Nedelec,
  conformity = :Hcurl,
  order = order,
  model = model,
  dirichlet_tags = [21,22])
  # dirichlet_tags = "boundary")

test_single_field_fe_space(V)

U = TrialFESpace(V,u)

uh = interpolate(U,u)
length(uh.free_values)
uh.free_values

e = u - uh

trian = Triangulation(model)
quad = CellQuadrature(trian,order)

el2 = sqrt(sum(integrate(inner(e,e),trian,quad)))
@test el2 < 1.0e-10

# using Gridap.Visualization

# writevtk(trian,"trian",nsubcells=10,cellfields=["uh"=>uh])

##

# end # module
