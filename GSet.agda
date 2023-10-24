{-

  This file contains:

  - Definition of Actions
  - Definition of GSets and the GSet Structure

-}

{-# OPTIONS --cubical #-}

open import Cubical.Foundations.Everything
open import Cubical.Algebra.Group
open import Cubical.Reflection.RecordEquiv

private
  variable
    ℓ : Level

record Action (G : Group ℓ) (X : Type ℓ) : Type ℓ where
  constructor
    action
  field
    _*_ : ⟨ G ⟩ → X → X
    is-set : isSet X
    ·Unit : (x : X) → (str G).GroupStr.1g * x ≡ x
    ·Composition : (g1 g2 : ⟨ G ⟩) (x : X) → g1 * (g2 * x) ≡ ((str G).GroupStr._·_ g1 g2) * x

unquoteDecl ActionIsoΣ = declareRecordIsoΣ ActionIsoΣ (quote Action)

record GSetStr (G : Group ℓ) (X : Type ℓ) : Type ℓ where
  constructor
    gsetstr
  field
    ϕ : Action {ℓ} G X

  open Action ϕ public

unquoteDecl GSetStrIsoΣ = declareRecordIsoΣ GSetStrIsoΣ (quote GSetStr)

-- preserves-inv : (G : Group ℓ) (X : Type ℓ) (F : Action G X) (a : ⟨ G ⟩) (x : X) → F .Action._*_ (str G .GroupStr.inv a) x ≡ {!F!}
-- preserves-inv G X F = {!!}

GSet : {ℓ : Level} → Group ℓ → Type (ℓ-suc ℓ)
GSet {ℓ} G = TypeWithStr ℓ (GSetStr G)
