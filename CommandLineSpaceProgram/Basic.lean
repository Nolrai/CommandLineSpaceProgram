import Mathlib.Data.Real.Basic
import Mathlib.Data.EReal.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Order.Interval.Set.Defs

def hello := "world"

section

infix:50 "^" => fun a b => Fin b → a

variable
  (radialPotential : ℝ → ℝ)
  (radialForce : ℝ → ℝ)
  (potentialDiff : ∀ {r : ℝ}, r ≠ 0 → HasDerivAt radialPotential (-(radialForce r)) r)

def potentialAtPoint {n} (p : ℝ^n) : ℝ := radialPotential (norm p)

def forceAtPoint {n} (p : ℝ^n) : ℝ^n := radialForce (norm p) • -p

structure initialValueProblem {n} where
  (force : ℝ → ℝ^n → ℝ^n)
  (x₀ : ℝ ^ n)
  (v₀ : ℝ ^ n)
  (t₀ : ℝ)

structure boundryProblem {n} where
  (force : ℝ → ℝ^n → ℝ^n)
  (x₀ : ℝ ^ n)
  (t₀ : ℝ)
  (x₁ : ℝ ^ n)
  (t₁ : ℝ)

structure isSolutionOfIVP {n} (problem : @initialValueProblem n)
  {a b : ℝ} (p : ℝ → ℝ ^ n) where
  (contains_t₀ : problem.t₀ ∈ Set.Ioo a b)
  (correct_x₀ : p problem.t₀ = problem.x₀)
  (correct_v₀ : deriv p problem.t₀ = problem.v₀)
  (follows_f : ∀ t ∈ Set.Ioo a b, deriv (deriv p) t = problem.force t (p t))

def EulersMethod {n} (problem : @initialValueProblem n) (Δt : ℝ) : ℕ → Fin 2 → ℝ ^ n
  | 0, 0 => problem.x₀
  | 0, 1 => problem.v₀
  | (i+1), 0 => (EulersMethod problem Δt i 0) +
    Δt • (EulersMethod problem Δt i 1)
  | (i+1), 1 => (EulersMethod problem Δt i 1) +
    Δt • problem.force (Δt * (i + 1)) (EulersMethod problem Δt i 0)


end
