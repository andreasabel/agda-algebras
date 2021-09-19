---
layout: default
title : "Terms.Func.Basic module (The Agda Universal Algebra Library)"
date : "2021-09-18"
author: "agda-algebras development team"
---

#### <a id="basic-definitions">Basic definitions</a>

This is the [Terms.Func.Basic][] module of the [Agda Universal Algebra Library][].

\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}

open import Algebras.Basic using ( 𝓞 ; 𝓥 ; Signature )

module Terms.Func.Basic {𝑆 : Signature 𝓞 𝓥} where

-- imports from Agda and the Agda Standard Library -------------------------------------
open import Agda.Primitive         using ( _⊔_ ; lsuc ) renaming ( Set to Type )
open import Data.Empty.Polymorphic using ( ⊥ )
open import Data.Product           using ( _,_ )
open import Data.Sum.Base          using ( _⊎_ ) renaming ( inj₁ to inl ; inj₂ to inr )
open import Function.Bundles       using ( Func )
open import Level                  using ( Level ; Lift )
open import Relation.Binary        using ( Setoid ; IsEquivalence )
open import Relation.Binary.Definitions using ( Reflexive ; Symmetric ; Transitive )
open import Relation.Binary.PropositionalEquality as ≡ using ( _≡_ ) -- ; sym ; trans ; refl )

-- Imports from the Agda Universal Algebra Library ------------------------------------
open import Overture.Preliminaries        using ( ∥_∥ )
open import Algebras.Setoid.Basic {𝑆 = 𝑆} using ( SetoidAlgebra ; ov )
open import Terms.Basic           {𝑆 = 𝑆} using ( Term )
open Term
open Func renaming ( f to _⟨$⟩_ )

private variable
 χ α ℓ : Level
 X Y : Type χ

\end{code}


##### <a id="equality-of-terms">Equality of terms</a>

We take a different approach here, using Setoids instead of quotient types.
That is, we will define the collection of terms in a signature as a setoid
with a particular equality-of-terms relation, which we must define.
Ultimately we will use this to define the (absolutely free) term algebra
as a SetoidAlgebra whose carrier is the setoid of terms.

\begin{code}

module _ {X : Type χ } where

 -- Equality of terms as an inductive datatype
 data _≐_ : Term X → Term X → Type (ov χ) where
  refl : {x y : X} → x ≡ y → (ℊ x) ≐ (ℊ y)
  genl : ∀ {f}{s t : ∥ 𝑆 ∥ f → Term X} → (∀ i → (s i) ≐ (t i)) → (node f s) ≐ (node f t)

 -- Equality of terms is an equivalence relation
 open Level
 ≐-isRefl : Reflexive _≐_
 ≐-isRefl {ℊ _} = refl ≡.refl
 ≐-isRefl {node _ _} = genl (λ _ → ≐-isRefl)

 ≐-isSym : Symmetric _≐_
 ≐-isSym (refl x) = refl (≡.sym x)
 ≐-isSym (genl x) = genl (λ i → ≐-isSym (x i))

 ≐-isTrans : Transitive _≐_
 ≐-isTrans (refl x) (refl y) = refl (≡.trans x y)
 ≐-isTrans (genl x) (genl y) = genl (λ i → ≐-isTrans (x i) (y i))

 ≐-isEquiv : IsEquivalence _≐_
 ≐-isEquiv = record { refl = ≐-isRefl ; sym = ≐-isSym ; trans = ≐-isTrans }

TermSetoid : (X : Type χ) → Setoid (ov χ) (ov χ)
TermSetoid X = record { Carrier = Term X ; _≈_ = _≐_ ; isEquivalence = ≐-isEquiv }

module _ where

 open SetoidAlgebra

 -- The Term SetoidAlgebra
 𝑻 : (X : Type χ) → SetoidAlgebra (ov χ) (ov χ)
 Domain (𝑻 X) = TermSetoid X
 Interp (𝑻 X) ⟨$⟩ (f , ts) = node f ts
 cong (Interp (𝑻 X)) (≡.refl , ss≐ts) = genl ss≐ts

\end{code}


##### <a id="interpretation-of-terms-in-setoid-algebras">Interpretation of terms in setoid algebras</a>

The approach to terms and their interpretation in this module was inspired by
[Andreas Abel's formal proof of Birkhoff's completeness theorem](http://www.cse.chalmers.se/~abela/agda/MultiSortedAlgebra.pdf).

A substitution from `Δ` to `Γ` associates a term in `Γ` with each variable in `Δ`.

\begin{code}

-- Parallel substitutions.
Sub : Type χ → Type χ → Type (ov χ)
Sub X Y = (y : Y) → Term X

-- Application of a substitution.
_[_] : (t : Term Y) (σ : Sub X Y) → Term X
(ℊ x) [ σ ] = σ x
(node f ts) [ σ ] = node f (λ i → ts i [ σ ])

\end{code}

An environment for `Γ` maps each variable `x : Γ` to an element of `A`, and equality of environments is defined pointwise.

\begin{code}

module Environment (𝑨 : SetoidAlgebra α ℓ) where
 open SetoidAlgebra 𝑨 using ( Interp ) renaming ( Domain to A )
 open Setoid A using () renaming ( _≈_ to _≃_ ; Carrier to ∣A∣
                                 ; refl to ≃refl ; sym to ≃sym ; trans to ≃trans )

 Env : Type χ → Setoid _ _
 Env X = record { Carrier = (x : X) → ∣A∣
                ; _≈_ = λ ρ ρ' → (x : X) → ρ x ≃ ρ' x
                ; isEquivalence =
                   record { refl = λ _ → ≃refl
                          ; sym = λ h x → ≃sym (h x)
                          ; trans = λ g h x → ≃trans (g x) (h x)
                          }
                }

\end{code}

Interpretation of terms is iteration on the W-type. The standard library offers `iter' (on sets), but we need this to be a Func (on setoids).

\begin{code}

 ⟦_⟧ : {X : Type χ}(t : Term X) → Func (Env X) A
 ⟦ ℊ x ⟧ ⟨$⟩ ρ = ρ x
 ⟦ node f args ⟧ ⟨$⟩ ρ = Interp ⟨$⟩ (f , λ i → ⟦ args i ⟧ ⟨$⟩ ρ)
 cong ⟦ ℊ x ⟧ u≈v = u≈v x
 cong ⟦ node f args ⟧ x≈y = cong Interp (≡.refl , λ i → cong ⟦ args i ⟧ x≈y )


 open Setoid using () renaming ( Carrier to ∣_∣ )

 -- An equality between two terms holds in a model
 -- if the two terms are equal under all valuations of their free variables.
 Equal : ∀ {X : Type χ} (s t : Term X) → Type _
 Equal {X = X} s t = ∀ (ρ : ∣ Env X ∣) →  ⟦ s ⟧ ⟨$⟩ ρ ≃ ⟦ t ⟧ ⟨$⟩ ρ

 -- Equal is an equivalence relation.
 isEquiv : {Γ : Type χ} → IsEquivalence (Equal {X = Γ})

 isEquiv = record { refl  =         λ ρ → ≃refl
                  ; sym   =     λ x=y ρ → ≃sym (x=y ρ)
                  ; trans = λ i=j j=k ρ → ≃trans (i=j ρ) (j=k ρ)
                  }

 -- Evaluation of a substitution gives an environment.
 ⟦_⟧s : {X Y : Type χ} → Sub X Y → ∣ Env X ∣ → ∣ Env Y ∣
 ⟦ σ ⟧s ρ x = ⟦ σ x ⟧ ⟨$⟩ ρ

 -- Substitution lemma: ⟦t[σ]⟧ρ ≃ ⟦t⟧⟦σ⟧ρ
 substitution : {X Y : Type χ} → (t : Term Y) (σ : Sub X Y) (ρ : ∣ Env X ∣ )
  →             ⟦ t [ σ ] ⟧ ⟨$⟩ ρ  ≃  ⟦ t ⟧ ⟨$⟩ (⟦ σ ⟧s ρ)

 substitution (ℊ x) σ ρ = ≃refl
 substitution (node f ts) σ ρ = cong Interp (≡.refl , λ i → substitution (ts i) σ ρ)

\end{code}

--------------------------------

<span style="float:left;">[↑ Terms.Func](Terms.Func.html)</span>
<span style="float:right;">[Terms.Func.Properties →](Terms.Func.Properties.html)</span>

{% include UALib.Links.md %}









<!--

The following was used in [Andreas Abel's formal proof of Birkhoff's completeness theorem](http://www.cse.chalmers.se/~abela/agda/MultiSortedAlgebra.pdf), but it seems unnecessary.

-- To obtain terms with free variables, we add nullary operations, each representing a variable.
-- These are covered in the std lib FreeMonad module, albeit with the restriction that the sets of
-- operation symbols and variable symbols have the same size.

-- Ops : Type χ → Signature (𝓞 ⊔ χ) 𝓥
-- Ops X = ((∣ 𝑆 ∣ ⊎ X) , ar)
--  where
--  ar : ∣ 𝑆 ∣ ⊎ X → Type _
--  ar (inl f) = ∥ 𝑆 ∥ f
--  ar (inr x) = ⊥             -- Add a nullary operation symbol for each variable symbol.

-->