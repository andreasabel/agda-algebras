---
layout: default
title : "Varieties.Closure.Setoid module (The Agda Universal Algebra Library)"
date : "2021-01-14"
author: "agda-algebras development team"
---

#### <a id="closure-operators-for-setoid-algebras">Closure Operators for Setoid Algebras</a>

Fix a signature 𝑆, let 𝒦 be a class of 𝑆-algebras, and define

* H 𝒦 = algebras isomorphic to a homomorphic image of a members of 𝒦;
* S 𝒦 = algebras isomorphic to a subalgebra of a member of 𝒦;
* P 𝒦 = algebras isomorphic to a product of members of 𝒦.

\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}

open import Algebras.Basic using ( 𝓞 ; 𝓥 ; Signature )

module Varieties.Setoid.Closure {𝑆 : Signature 𝓞 𝓥} where

-- imports from Agda and the Agda Standard Library -------------------------------------------
open import Agda.Primitive using ( _⊔_ ; lsuc ; Level ) renaming ( Set to Type )
open import Axiom.Extensionality.Propositional renaming ( Extensionality to funext ) using () 
open import Data.Product   using ( _,_ ; Σ-syntax ) renaming ( proj₁ to fst ; proj₂ to snd )
open import Relation.Unary using ( Pred  ; _∈_ ; _⊆_ )

-- Imports from the Agda Universal Algebra Library ---------------------------------------------
open import Overture.Preliminaries                  using ( ∣_∣ ; ∥_∥ )
open import Algebras.Setoid.Products        {𝑆 = 𝑆} using ( ⨅ )
open import Algebras.Setoid.Basic           {𝑆 = 𝑆} using ( SetoidAlgebra ; ov )
open import Homomorphisms.Func.Isomorphisms{𝑆 = 𝑆}using ( _≅_ ; ≅-sym ; Lift-≅ ; ≅-trans ; ≅-refl )
open import Homomorphisms.Func.HomomorphicImages{𝑆 = 𝑆}using ( HomImages )
open import Subalgebras.Setoid.Subalgebras  {𝑆 = 𝑆} using (_≤_ ; _IsSubalgebraOfClass_ ; Subalgebra )

-- The inductive type H
data H {α ρ : Level} (𝒦 : Pred (SetoidAlgebra α ρ)(ov α)) : Pred (SetoidAlgebra α ρ) (ov(α ⊔ ρ))
 where
 hbase : {𝑨 : SetoidAlgebra α ρ} → 𝑨 ∈ 𝒦 → 𝑨 ∈ H 𝒦
 hhimg : {𝑨 𝑩 : SetoidAlgebra _ ρ} → 𝑨 ∈ H 𝒦 → ((𝑩 , _) : HomImages 𝑨) → 𝑩 ∈ H 𝒦

-- The inductive type S
data S {α ρ : Level}(𝒦 : Pred(SetoidAlgebra α ρ)(ov α)) : Pred(SetoidAlgebra α ρ)(ov(α ⊔ ρ))
 where
 sbase : {𝑨 : SetoidAlgebra α ρ} → 𝑨 ∈ 𝒦 → 𝑨 ∈ S 𝒦
 ssub  : {𝑨 𝑩 : SetoidAlgebra _ ρ} → 𝑨 ∈ S 𝒦 → 𝑩 ≤ 𝑨 → 𝑩 ∈ S 𝒦
 siso  : {𝑨 𝑩 : SetoidAlgebra _ ρ} → 𝑨 ∈ S 𝒦 → 𝑨 ≅ 𝑩 → 𝑩 ∈ S 𝒦

-- The inductive type P
data P {α ρ : Level}(𝒦 : Pred(SetoidAlgebra α ρ)(ov α)) : Pred(SetoidAlgebra α ρ)(ov (α ⊔ ρ))
 where
 pbase  : {𝑨 : SetoidAlgebra α ρ} → 𝑨 ∈ 𝒦 → 𝑨 ∈ P 𝒦
 pprod  : {I : Type}{𝒜 : I → SetoidAlgebra _ ρ} → (∀ i → (𝒜 i) ∈ P 𝒦) → ⨅ 𝒜 ∈ P 𝒦
 piso  : {𝑨 𝑩 : SetoidAlgebra _ ρ} → 𝑨 ∈ P 𝒦 → 𝑨 ≅ 𝑩 → 𝑩 ∈ P 𝒦

-- The inductive types V
data V {α ρ : Level}(𝒦 : Pred(SetoidAlgebra α ρ)(ov α)) : Pred(SetoidAlgebra α ρ)(ov(α ⊔ ρ))
 where
 vbase  : {𝑨 : SetoidAlgebra α ρ} → 𝑨 ∈ 𝒦 → 𝑨 ∈ V 𝒦
 vhimg  : {𝑨 𝑩 : SetoidAlgebra _ ρ} → 𝑨 ∈ V 𝒦 → ((𝑩 , _) : HomImages 𝑨) → 𝑩 ∈ V 𝒦
 vssub  : {𝑨 𝑩 : SetoidAlgebra _ ρ} → 𝑨 ∈ V 𝒦 → 𝑩 ≤ 𝑨 → 𝑩 ∈ V 𝒦
 vpprod : {I : Type}{𝒜 : I → SetoidAlgebra _ ρ} → (∀ i → (𝒜 i) ∈ V 𝒦) → ⨅ 𝒜 ∈ V 𝒦
 viso   : {𝑨 𝑩 : SetoidAlgebra _ ρ} → 𝑨 ∈ V 𝒦 → 𝑨 ≅ 𝑩 → 𝑩 ∈ V 𝒦

\end{code}

Thus, if 𝒦 is a class of 𝑆-algebras, then the *variety generated by* 𝒦 is denoted by `V 𝒦` and defined to be the smallest class that contains 𝒦 and is closed under `H`, `S`, and `P`.

With the closure operator V representing closure under HSP, we represent formally what it means to be a variety of algebras as follows.

\begin{code}

is-variety : {α ρ : Level}(𝒱 : Pred (SetoidAlgebra α ρ)_) → Type _
is-variety{α}{ρ} 𝒱 = V 𝒱 ⊆ 𝒱

variety : (α ρ : Level) → Type _
variety α ρ = Σ[ 𝒱 ∈ (Pred (SetoidAlgebra α ρ)_) ] is-variety 𝒱

\end{code}

--------------------------------

<span style="float:left;">[← Varieties.Setoid.EquationalLogic](Varieties.Setoid.EquationalLogic.html)</span>
<span style="float:right;">[Varieties.Setoid.FreeAlgebras →](Varieties.Setoid.FreeAlgebras.html)</span>

{% include UALib.Links.md %}
