---
layout: default
title : Varieties.EquationalLogic module (The Agda Universal Algebra Library)
date : 2021-01-14
author: William DeMeo
---

### <a id="model-theory-and-equational-logic-types">Model Theory and Equational Logic</a>

This section presents the [Varieties.EquationalLogic][] module of the [Agda Universal Algebra Library][] where the binary "models" relation ⊧, relating algebras (or classes of algebras) to the identities that they satisfy, is defined.

Agda supports the definition of infix operations and relations, and we use this to define ⊧ so that we may write, e.g., `𝑨 ⊧ p ≈ q` or `𝒦 ⊧ p ≋ q`.

We also prove some closure and invariance properties of ⊧.  In particular, we prove the following facts (which are needed, for example, in the proof the Birkhoff HSP Theorem).

* [Algebraic invariance](#algebraic-invariance). The ⊧ relation is an *algebraic invariant* (stable under isomorphism).

* [Subalgebraic invariance](#subalgebraic-invariance). Identities modeled by a class of algebras are also modeled by all subalgebras of algebras in the class.

* [Product invariance](#product-invariance). Identities modeled by a class of algebras are also modeled by all products of algebras in the class.



**Notation**. In the [Agda UniversalAlgebra][] library, because a class of structures has a different type than a single structure, we must use a slightly different syntax to avoid overloading the relations ⊧ and ≈. As a reasonable alternative to what we would normally express informally as 𝒦 ⊧ 𝑝 ≈ 𝑞, we have settled on 𝒦 ⊧ p ≋ q to denote this relation.  To reiterate, if 𝒦 is a class of 𝑆-algebras, we write 𝒦 ⊧ 𝑝 ≋ 𝑞 if every 𝑨 ∈ 𝒦 satisfies 𝑨 ⊧ 𝑝 ≈ 𝑞.

**Unicode Hints**. To produce the symbols ≈, ⊧, and ≋ in [agda2-mode][], type `\~~`, `\models`, and `\~~~`, respectively.

\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}


-- Imports from Agda (builtin/primitive) and the Agda Standard Library
open import Agda.Builtin.Equality using (_≡_; refl)
open import Axiom.Extensionality.Propositional renaming (Extensionality to funext)
open import Data.Product using (_,_; Σ; _×_)
open import Function.Base  using (_∘_)
open import Level renaming (suc to lsuc; zero to lzero)
open import Relation.Binary.PropositionalEquality.Core using (cong; cong-app)
open import Relation.Unary using (⋂; _∈_; Pred; _⊆_)

-- Imports from the Agda Universal Algebra Library
open import Algebras.Basic
open import Overture.Inverses using (IsInjective; ∘-injective)
open import Overture.Preliminaries --  using (Type; 𝓞; 𝓤; 𝓥; 𝓦; 𝓧; Π; -Π; -Σ; _≡⟨_⟩_; _∎; _∙_;_⁻¹; ∣_∣; ∥_∥; snd;_≈_)
open import Relations.Discrete using (Im_⊆_)
open import Relations.Extensionality using (DFunExt; SwellDef)




module Varieties.EquationalLogic {𝑆 : Signature 𝓞 𝓥} where

open import Subalgebras.Subalgebras{𝑆 = 𝑆} using (_≤_; SubalgebraOfClass; iso→injective)
open import Algebras.Products{𝑆 = 𝑆} using (ov; ⨅)
open import Homomorphisms.Basic {𝑆 = 𝑆} using (hom; 𝒾𝒹; ∘-hom)
open import Homomorphisms.Isomorphisms {𝑆 = 𝑆} using (_≅_; _≋_; _≂_; Lift-≅; ≅-sym; ≂sym)
open import Terms.Basic {𝑆 = 𝑆} using (Term; 𝑻; lift-hom)
open import Terms.Operations {𝑆 = 𝑆} using (_⟦_⟧; comm-hom-term; interp-prod; term-agreement)

open Term

\end{code}


#### <a id="the-models-relation">The models relation</a>

We define the binary "models" relation ⊧ using infix syntax so that we may write, e.g., `𝑨 ⊧ p ≈ q` or `𝒦 ⊧ p ≋ q`, relating algebras (or classes of algebras) to the identities that they satisfy. We also prove a coupld of useful facts about ⊧.  More will be proved about ⊧ in the next module, [Varieties.EquationalLogic](Varieties.EquationalLogic.html).

\begin{code}

module _ {𝓤 : Level}{X : Type 𝓧} where
 _⊧_≈_ : Algebra 𝓤 𝑆 → Term X → Term X → Type(𝓤 ⊔ 𝓧)
 𝑨 ⊧ p ≈ q = 𝑨 ⟦ p ⟧ ≈ 𝑨 ⟦ q ⟧

 _⊧_≋_ : Pred(Algebra 𝓤 𝑆)(ov 𝓤) → Term X → Term X → Type(𝓧 ⊔ ov 𝓤)
 𝒦 ⊧ p ≋ q = ∀ {𝑨 : Algebra 𝓤 𝑆} → 𝒦 𝑨 → 𝑨 ⊧ p ≈ q

\end{code}

##### <a id="semantics-of-⊧">Syntax and semantics of ⊧</a>
The expression `𝑨 ⊧ p ≈ q` represents the assertion that the identity `p ≈ q` holds when interpreted in the algebra `𝑨`; syntactically, `𝑨 ⟦ p ⟧ ≡ 𝑨 ⟦ q ⟧`.  It should be emphasized that the expression  `𝑨 ⟦ p ⟧ ≡ 𝑨 ⟦ q ⟧` interpreted computationally as an *extensional equality*, by which we mean that for each *assignment function*  `𝒂 :  X → ∣ 𝑨 ∣`, assigning values in the domain of `𝑨` to the variable symbols in `X`, we have `⟦ p ⟧ 𝑨 𝒂 ≡ ⟦ q ⟧  𝑨 𝒂`.



#### <a id="equational-theories-and-classes">Equational theories and models</a>

Here we define a type `Th` so that, if 𝒦 denotes a class of algebras, then `Th 𝒦` represents the set of identities modeled by all members of 𝒦.

\begin{code}

Th : {X : Type 𝓧} → Pred (Algebra 𝓤 𝑆)(ov 𝓤) → Pred(Term X × Term X)(𝓧 ⊔ ov 𝓤)
Th 𝒦 = λ (p , q) → 𝒦 ⊧ p ≋ q

\end{code}

If `ℰ` denotes a set of identities, then the class of algebras satisfying all identities in ℰ is represented by `Mod ℰ`, which we define in the following natural way.

\begin{code}

Mod : {X : Type 𝓧} → Pred(Term X × Term X)(𝓧 ⊔ ov 𝓤) → Pred(Algebra 𝓤 𝑆)(ov (𝓧 ⊔ 𝓤))
Mod ℰ = λ 𝑨 → ∀ p q → (p , q) ∈ ℰ → 𝑨 ⊧ p ≈ q

\end{code}




#### <a id="algebraic-invariance-of-models">Algebraic invariance of ⊧</a>

The binary relation ⊧ would be practically useless if it were not an *algebraic invariant* (i.e., invariant under isomorphism).

\begin{code}

module _ (wd : SwellDef){𝓤 𝓦 : Level}{X : Type 𝓧}{𝑨 : Algebra 𝓤 𝑆}
         (𝑩 : Algebra 𝓦 𝑆)(p q : Term X) where

 ⊧-I-invar : 𝑨 ⊧ p ≈ q  →  𝑨 ≅ 𝑩  →  𝑩 ⊧ p ≈ q

 ⊧-I-invar Apq (f , g , f∼g , g∼f) x =
  (𝑩 ⟦ p ⟧) x                      ≡⟨ wd 𝓧 𝓦 (𝑩 ⟦ p ⟧) x (∣ f ∣ ∘ ∣ g ∣ ∘ x) (λ i → ( f∼g (x i))⁻¹) ⟩
  (𝑩 ⟦ p ⟧) ((∣ f ∣ ∘ ∣ g ∣) ∘ x)  ≡⟨ (comm-hom-term (wd 𝓥 𝓦) 𝑩 f p (∣ g ∣ ∘ x))⁻¹ ⟩
  ∣ f ∣ ((𝑨 ⟦ p ⟧) (∣ g ∣ ∘ x))    ≡⟨ cong ∣ f ∣ (Apq (∣ g ∣ ∘ x))  ⟩
  ∣ f ∣ ((𝑨 ⟦ q ⟧) (∣ g ∣ ∘ x))    ≡⟨ comm-hom-term (wd 𝓥 𝓦) 𝑩 f q (∣ g ∣ ∘ x) ⟩
  (𝑩 ⟦ q ⟧) ((∣ f ∣ ∘ ∣ g ∣) ∘  x) ≡⟨ wd 𝓧 𝓦 (𝑩 ⟦ q ⟧) (∣ f ∣ ∘ ∣ g ∣ ∘ x) x (λ i → ( f∼g (x i))) ⟩
  (𝑩 ⟦ q ⟧) x                      ∎
\end{code}

We can prove the foregoing with two fewer applications of SwellDef if we use our alternative definition of isomorphism (≋ instead of ≅).  (It's possible we could eliminate SwellDef altogether.)

\begin{code}

 ⊧-I-invar' : 𝑨 ⊧ p ≈ q  →  𝑨 ≋ 𝑩  →  𝑩 ⊧ p ≈ q

 ⊧-I-invar' Apq hyp x = γ
  where
   f : hom 𝑨 𝑩
   f = fstω hyp

   g : hom 𝑩 𝑨
   g = fstω (sndω hyp)

   f≂g : ∣ f ∣ ∘ ∣ g ∣ ≂ ∣ 𝒾𝒹 𝑩 ∣
   f≂g = FST (sndω (sndω hyp))

   ξ : x ≡ ∣ f ∣ ∘ ∣ g ∣ ∘ x
   ξ = x ≡⟨ ≂sym (∣ f ∣ ∘ ∣ g ∣) ∣ 𝒾𝒹 𝑩 ∣ f≂g x ⟩ ∣ f ∣ ∘ ∣ g ∣ ∘ x ∎

   γ : (𝑩 ⟦ p ⟧) x ≡ (𝑩 ⟦ q ⟧) x
   γ = (𝑩 ⟦ p ⟧) x                      ≡⟨ cong (𝑩 ⟦ p ⟧) ξ ⟩
       (𝑩 ⟦ p ⟧) ((∣ f ∣ ∘ ∣ g ∣) ∘ x)  ≡⟨ (comm-hom-term (wd 𝓥 𝓦) 𝑩 f p (∣ g ∣ ∘ x))⁻¹ ⟩
       ∣ f ∣ ((𝑨 ⟦ p ⟧) (∣ g ∣ ∘ x))    ≡⟨ cong ∣ f ∣ (Apq (∣ g ∣ ∘ x))  ⟩
       ∣ f ∣ ((𝑨 ⟦ q ⟧) (∣ g ∣ ∘ x))    ≡⟨ comm-hom-term (wd 𝓥 𝓦) 𝑩 f q (∣ g ∣ ∘ x) ⟩
       (𝑩 ⟦ q ⟧) ((∣ f ∣ ∘ ∣ g ∣) ∘  x) ≡⟨ cong (𝑩 ⟦ q ⟧) (ξ ⁻¹) ⟩
       (𝑩 ⟦ q ⟧) x                      ∎



 \end{code}

 As the proof makes clear, we show 𝑩 ⊧ p ≈ q by showing that `𝑩 ⟦ p ⟧ ≡ 𝑩 ⟦ q ⟧ holds *extensionally*, that is, `∀ x, 𝑩 ⟦ p ⟧ x ≡ 𝑩 ⟦q ⟧ x`.

#### <a id="lift-invariance">Lift-invariance of ⊧</a>
The ⊧ relation is also invariant under the algebraic lift and lower operations.

\begin{code}

module _ (wd : SwellDef){X : Type 𝓧}{𝑨 : Algebra 𝓤 𝑆} where

 ⊧-Lift-invar : (p q : Term X) → 𝑨 ⊧ p ≈ q → Lift-alg 𝑨 𝓦 ⊧ p ≈ q
 ⊧-Lift-invar p q Apq = ⊧-I-invar wd (Lift-alg 𝑨 _) p q Apq Lift-≅

 ⊧-lower-invar : (p q : Term X) → Lift-alg 𝑨 𝓦 ⊧ p ≈ q  →  𝑨 ⊧ p ≈ q
 ⊧-lower-invar p q lApq = ⊧-I-invar wd 𝑨 p q lApq (≅-sym Lift-≅)

\end{code}





#### <a id="subalgebraic-invariance">Subalgebraic invariance of ⊧</a>

Identities modeled by an algebra `𝑨` are also modeled by every subalgebra of `𝑨`, which fact can be formalized as follows.

\begin{code}

module _ (wd : SwellDef){𝓤 𝓦 : Level}{X : Type 𝓧} where

 ⊧-S-invar : {𝑨 : Algebra 𝓤 𝑆}(𝑩 : Algebra 𝓦 𝑆){p q : Term X}
  →          𝑨 ⊧ p ≈ q  →  𝑩 ≤ 𝑨  →  𝑩 ⊧ p ≈ q
 ⊧-S-invar {𝑨} 𝑩 {p}{q} Apq B≤A b = (∥ B≤A ∥) (ξ b)
  where
  h : hom 𝑩 𝑨
  h = ∣ B≤A ∣

  ξ : ∀ b → ∣ h ∣ ((𝑩 ⟦ p ⟧) b) ≡ ∣ h ∣ ((𝑩 ⟦ q ⟧) b)
  ξ b = ∣ h ∣((𝑩 ⟦ p ⟧) b)   ≡⟨ comm-hom-term (wd 𝓥 𝓤) 𝑨 h p b ⟩
        (𝑨 ⟦ p ⟧)(∣ h ∣ ∘ b) ≡⟨ Apq (∣ h ∣ ∘ b) ⟩
        (𝑨 ⟦ q ⟧)(∣ h ∣ ∘ b) ≡⟨ (comm-hom-term (wd 𝓥 𝓤) 𝑨 h q b)⁻¹ ⟩
        ∣ h ∣((𝑩 ⟦ q ⟧) b)   ∎

 \end{code}

 Next, identities modeled by a class of algebras is also modeled by all subalgebras of the class.  In other terms, every term equation `p ≈ q` that is satisfied by all `𝑨 ∈ 𝒦` is also satisfied by every subalgebra of a member of 𝒦.

 \begin{code}

 ⊧-S-class-invar : {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)}(p q : Term X)
  →                𝒦 ⊧ p ≋ q → (𝑩 : SubalgebraOfClass{𝓦} 𝒦) → ∣ 𝑩 ∣ ⊧ p ≈ q
 ⊧-S-class-invar p q Kpq (𝑩 , 𝑨 , SA , (ka , BisSA)) = ⊧-S-invar 𝑩 {p}{q}((Kpq ka)) (h , hinj)
  where
  h : hom 𝑩 𝑨
  h = ∘-hom 𝑩 𝑨 (∣ BisSA ∣) ∣ snd SA ∣
  hinj : IsInjective ∣ h ∣
  hinj = ∘-injective (iso→injective BisSA) ∥ snd SA ∥
 \end{code}





#### <a id="product-invariance">Product invariance of ⊧</a>

Notice that the submodule in this section requires a **function extensionality** postulate `fe : DFunExt`, unlike the other submodules of the [Varieties.EquationalLogic][] module (which only require strong well-definedness of functions).

An identity satisfied by all algebras in an indexed collection is also satisfied by the product of algebras in that collection.

\begin{code}

module _ (fe : DFunExt)(wd : SwellDef){I : Type 𝓦}(𝒜 : I → Algebra 𝓤 𝑆){X : Type 𝓧} where

 ⊧-P-invar : (p q : Term X) → (∀ i → 𝒜 i ⊧ p ≈ q) → ⨅ 𝒜 ⊧ p ≈ q
 ⊧-P-invar p q 𝒜pq a = γ
  where
  -- This is where function extensionality is used.
  ξ : (λ i → (𝒜 i ⟦ p ⟧) (λ x → (a x) i)) ≡ (λ i → (𝒜 i ⟦ q ⟧)  (λ x → (a x) i))
  ξ = fe 𝓦 𝓤 λ i → 𝒜pq i (λ x → (a x) i)

  γ : (⨅ 𝒜 ⟦ p ⟧) a  ≡  (⨅ 𝒜 ⟦ q ⟧) a
  γ = (⨅ 𝒜 ⟦ p ⟧) a                      ≡⟨ interp-prod (wd 𝓥 (𝓦 ⊔ 𝓤)) p 𝒜 a ⟩
      (λ i → (𝒜 i ⟦ p ⟧)(λ x → (a x)i))  ≡⟨ ξ ⟩
      (λ i → (𝒜 i ⟦ q ⟧)(λ x → (a x)i))  ≡⟨ (interp-prod (wd 𝓥 (𝓦 ⊔ 𝓤)) q 𝒜 a)⁻¹ ⟩
      (⨅ 𝒜 ⟦ q ⟧) a                      ∎

\end{code}

An identity satisfied by all algebras in a class is also satisfied by the product of algebras in the class.

\begin{code}

 ⊧-P-class-invar : (𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)){p q : Term X}
  →                𝒦 ⊧ p ≋ q → (∀ i → 𝒜 i ∈ 𝒦) → ⨅ 𝒜 ⊧ p ≈ q

 ⊧-P-class-invar 𝒦 {p}{q}α K𝒜 = ⊧-P-invar p q λ i → α (K𝒜 i)

 \end{code}

 Another fact that will turn out to be useful is that a product of a collection of algebras models p ≈ q if the lift of each algebra in the collection models p ≈ q.

 \begin{code}

 ⊧-P-lift-invar : (p q : Term X) → (∀ i → Lift-alg (𝒜 i) 𝓦 ⊧ p ≈ q)  →  ⨅ 𝒜 ⊧ p ≈ q
 ⊧-P-lift-invar p q α = ⊧-P-invar p q Aipq
  where
  Aipq : ∀ i → (𝒜 i) ⊧ p ≈ q
  Aipq i = ⊧-lower-invar wd p q (α i) --  (≅-sym Lift-≅)

\end{code}


#### <a id="homomorphisc-invariance">Homomorphic invariance of ⊧</a>

If an algebra 𝑨 models an identity p ≈ q, then the pair (p , q) belongs to the kernel of every homomorphism φ : hom (𝑻 X) 𝑨 from the term algebra to 𝑨; that is, every homomorphism from 𝑻 X to 𝑨 maps p and q to the same element of 𝑨.

 \begin{code}

module _ (wd : SwellDef){X : Type 𝓧}{𝑨 : Algebra 𝓤 𝑆} where

 ⊧-H-invar : {p q : Term X}(φ : hom (𝑻 X) 𝑨) → 𝑨 ⊧ p ≈ q  →  ∣ φ ∣ p ≡ ∣ φ ∣ q

 ⊧-H-invar {p}{q}φ β = ∣ φ ∣ p               ≡⟨ cong ∣ φ ∣(term-agreement(wd 𝓥 (ov 𝓧)) p)⟩
                       ∣ φ ∣((𝑻 X ⟦ p ⟧) ℊ)  ≡⟨ comm-hom-term (wd 𝓥 𝓤) 𝑨 φ p ℊ ⟩
                       (𝑨 ⟦ p ⟧) (∣ φ ∣ ∘ ℊ) ≡⟨ β (∣ φ ∣ ∘ ℊ ) ⟩
                       (𝑨 ⟦ q ⟧) (∣ φ ∣ ∘ ℊ) ≡⟨ (comm-hom-term (wd 𝓥 𝓤)  𝑨 φ q ℊ )⁻¹ ⟩
                       ∣ φ ∣ ((𝑻 X ⟦ q ⟧) ℊ) ≡⟨(cong ∣ φ ∣ (term-agreement (wd 𝓥 (ov 𝓧)) q))⁻¹ ⟩
                       ∣ φ ∣ q               ∎

\end{code}

More generally, an identity is satisfied by all algebras in a class if and only if that identity is invariant under all homomorphisms from the term algebra `𝑻 X` into algebras of the class. More precisely, if `𝒦` is a class of `𝑆`-algebras and `𝑝`, `𝑞` terms in the language of `𝑆`, then,

```
  𝒦 ⊧ p ≈ q  ⇔  ∀ 𝑨 ∈ 𝒦,  ∀ φ : hom (𝑻 X) 𝑨,  φ ∘ (𝑻 X)⟦ p ⟧ = φ ∘ (𝑻 X)⟦ q ⟧.
```

\begin{code}

module _ (wd : SwellDef){X : Type 𝓧}{𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)}  where

 -- ⇒ (the "only if" direction)
 ⊧-H-class-invar : {p q : Term X}
  →                𝒦 ⊧ p ≋ q → ∀ 𝑨 φ → 𝑨 ∈ 𝒦 → ∀ a → ∣ φ ∣ ((𝑻 X ⟦ p ⟧) a) ≡ ∣ φ ∣ ((𝑻 X ⟦ q ⟧) a)
 ⊧-H-class-invar {p}{q} α 𝑨 φ ka a = ξ
  where
   ξ : ∣ φ ∣ ((𝑻 X ⟦ p ⟧) a) ≡ ∣ φ ∣ ((𝑻 X ⟦ q ⟧) a)
   ξ = ∣ φ ∣ ((𝑻 X ⟦ p ⟧) a)  ≡⟨ comm-hom-term (wd 𝓥 𝓤) 𝑨 φ p a ⟩
         (𝑨 ⟦ p ⟧)(∣ φ ∣ ∘ a)   ≡⟨ (α ka) (∣ φ ∣ ∘ a) ⟩
         (𝑨 ⟦ q ⟧)(∣ φ ∣ ∘ a)   ≡⟨ (comm-hom-term (wd 𝓥 𝓤) 𝑨 φ q a)⁻¹ ⟩
         ∣ φ ∣ ((𝑻 X ⟦ q ⟧) a)  ∎


-- ⇐ (the "if" direction)
 ⊧-H-class-coinvar : {p q : Term X}
  →  (∀ 𝑨 φ → 𝑨 ∈ 𝒦 → ∀ a → ∣ φ ∣ ((𝑻 X ⟦ p ⟧) a) ≡ ∣ φ ∣ ((𝑻 X ⟦ q ⟧) a)) → 𝒦 ⊧ p ≋ q

 ⊧-H-class-coinvar {p}{q} β {𝑨} ka = γ
  where
  φ : (a : X → ∣ 𝑨 ∣) → hom (𝑻 X) 𝑨
  φ a = lift-hom 𝑨 a

  γ : 𝑨 ⊧ p ≈ q
  γ a = (𝑨 ⟦ p ⟧)(∣ φ a ∣ ∘ ℊ)     ≡⟨(comm-hom-term (wd 𝓥 𝓤) 𝑨 (φ a) p ℊ)⁻¹ ⟩
               (∣ φ a ∣ ∘ (𝑻 X ⟦ p ⟧)) ℊ  ≡⟨ β 𝑨 (φ a) ka ℊ ⟩
               (∣ φ a ∣ ∘ (𝑻 X ⟦ q ⟧)) ℊ  ≡⟨ (comm-hom-term (wd 𝓥 𝓤) 𝑨 (φ a) q ℊ) ⟩
               (𝑨 ⟦ q ⟧)(∣ φ a ∣ ∘ ℊ)     ∎


\end{code}




-------------------------------------

[↑ Varieties](Varieties.html)
<span style="float:right;">[Varieties.Varieties →](Varieties.Varieties.html)</span>

{% include UALib.Links.md %}



