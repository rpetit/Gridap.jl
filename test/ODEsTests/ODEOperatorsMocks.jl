using SparseArrays: spzeros

using Gridap
using Gridap.Algebra
using Gridap.Polynomials
using Gridap.ODEs

####################
# ODEOperatorMock1 #
####################
"""
    struct ODEOperatorMock1 <: ODEOperator end

Mock 1st-order linear ODE
```math
M u̇ + K u + f(t) = 0.
```
"""
struct ODEOperatorMock1{T} <: ODEOperator{T}
  M::AbstractMatrix
  K::AbstractMatrix
  f::Function
end

Polynomials.get_order(odeop::ODEOperatorMock1) = 1

function Algebra.allocate_residual(
  odeop::ODEOperatorMock1,
  t::Real, us::NTuple{2,AbstractVector},
  odeopcache
)
  M = odeop.M
  zeros(typeof(t), size(M, 2))
end

function Algebra.residual!(
  r::AbstractVector, odeop::ODEOperatorMock1,
  t::Real, us::NTuple{2,AbstractVector},
  odeopcache; include_mass::Bool=true
)
  u, v = us
  fill!(r, zero(eltype(r)))
  if include_mass
    r .+= odeop.M * v
  end
  r .+= odeop.K * u
  r .+= f(t)
  r
end

function Algebra.allocate_jacobian(
  odeop::ODEOperatorMock1,
  t::Real, us::NTuple{2,AbstractVector},
  odeopcache
)
  M = odeop.M
  spzeros(typeof(t), size(M, 2), size(M, 2))
end

function Algebra.jacobian!(
  J::AbstractMatrix, odeop::ODEOperatorMock1,
  t::Real, us::NTuple{2,AbstractVector},
  k::Integer, γ::Real,
  odeopcache
)
  if k == 0
    @. J += γ * odeop.K
  elseif k == 1
    @. J += γ * odeop.M
  end
  J
end

####################
# ODEOperatorMock2 #
####################
"""
    struct ODEOperatorMock2 <: ODEOperator end

2nd-order linear ODE
```math
M ü + C u̇ + K u + f(t) = 0.
```
"""
struct ODEOperatorMock2{T} <: ODEOperator{T}
  M::AbstractMatrix
  C::AbstractMatrix
  K::AbstractMatrix
  f::Function
end

Polynomials.get_order(odeop::ODEOperatorMock2) = 2

function Algebra.allocate_residual(
  odeop::ODEOperatorMock2,
  t::Real, us::NTuple{3,AbstractVector},
  odeopcache
)
  M = odeop.M
  zeros(typeof(t), size(M, 2))
end

function Algebra.residual!(
  r::AbstractVector, odeop::ODEOperatorMock2,
  t::Real, us::NTuple{3,AbstractVector},
  odeopcache; include_mass::Bool=true
)
  u, v, a = us
  fill!(r, zero(eltype(r)))
  if include_mass
    r .+= odeop.M * a
  end
  r .+= odeop.C * v
  r .+= odeop.K * u
  r .+= f(t)
  r
end

function Algebra.allocate_jacobian(
  odeop::ODEOperatorMock2,
  t::Real, us::NTuple{3,AbstractVector},
  odeopcache
)
  M = odeop.M
  spzeros(typeof(t), size(M, 2), size(M, 2))
end

function Algebra.jacobian!(
  J::AbstractMatrix, odeop::ODEOperatorMock2,
  t::Real, us::NTuple{3,AbstractVector},
  k::Integer, γ::Real,
  odeopcache
)
  if k == 0
    @. J += γ * odeop.K
  elseif k == 1
    @. J += γ * odeop.C
  elseif k == 2
    @. J += γ * odeop.M
  end
  J
end
