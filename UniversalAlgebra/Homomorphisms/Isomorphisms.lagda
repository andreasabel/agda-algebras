---
layout: default
title : Homomorphisms.Isomoprhisms module (The Agda Universal Algebra Library)
date : 2021-01-14
author: William DeMeo
---

### <a id="isomorphisms">Isomorphisms</a>

This section describes the [Homomorphisms.Isomorphisms][] module of the [Agda Universal Algebra Library][].
Here we formalize the informal notion of isomorphism between algebraic structures.
̇
\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}

-- Imports from the Agda (Builtin) and the Agda Standard Library
open import Agda.Builtin.Equality using (_≡_; refl)
open import Axiom.Extensionality.Propositional renaming (Extensionality to funext)
open import Data.Product using (_,_; Σ; _×_)
open import Function.Base  using (_∘_)
open import Level renaming (suc to lsuc; zero to lzero)
open import Relation.Binary.PropositionalEquality.Core using (sym; trans; cong; cong-app)

open import Algebras.Basic
open import Overture.Preliminaries


module Homomorphisms.Isomorphisms{𝑆 : Signature 𝓞 𝓥}  where

open import Algebras.Products {𝑆 = 𝑆} using (⨅)
open import Homomorphisms.Basic {𝑆 = 𝑆}
 using (hom; kercon; ker[_⇒_]_↾_; πker; is-homomorphism; epi; epi-to-hom; 𝒾𝒹; ∘-hom; 𝓁𝒾𝒻𝓉; 𝓁ℴ𝓌ℯ𝓇; ∘-is-hom)

\end{code}

#### <a id="isomorphism-toolbox">Definition of isomorphism</a>

Recall, `f ~ g` means f and g are *extensionally* (or pointwise) equal; i.e., `∀ x, f x ≡ g x`. We use this notion of equality of functions in the following definition of **isomorphism**.

\begin{code}

_≅_ : {𝓤 𝓦 : Level}(𝑨 : Algebra 𝓤 𝑆)(𝑩 : Algebra 𝓦 𝑆) → Type(𝓞 ⊔ 𝓥 ⊔ 𝓤 ⊔ 𝓦)
𝑨 ≅ 𝑩 =  Σ[ f ꞉ (hom 𝑨 𝑩)] Σ[ g ꞉ hom 𝑩 𝑨 ] ((∣ f ∣ ∘ ∣ g ∣ ≈ ∣ 𝒾𝒹 𝑩 ∣) × (∣ g ∣ ∘ ∣ f ∣ ≈ ∣ 𝒾𝒹 𝑨 ∣))


domain : {A : Type 𝓤}{B : Type 𝓦} → (A → B) → Type 𝓤
domain{A = A} f = A


_≂_ : {𝓦 𝓧 : Level}{B : Type 𝓦}{C : Type 𝓧}(f g : B → C) → Setω
f ≂ g = ∀{𝓤}{A : Type 𝓤} (h : A → domain f) → f ∘ h ≡ g ∘ h

infix 8 _≂_

≂lem1 : {A : Type 𝓤}{B : Type 𝓦}{C : Type 𝓧}(f g : B → C)(α β : A → B)
 →      f ≂ g → α ≡ β → f ∘ α ≡ g ∘ β

≂lem1 f g α .α f≂g refl = f≂g α

≂refl : {B : Type 𝓦}{C : Type 𝓧}(f : B → C) → f ≂ f
≂refl f = λ h → refl

≂sym : {B : Type 𝓦}{C : Type 𝓧}(f g : B → C) → f ≂ g → g ≂ f
≂sym f g f≂g = sym ∘ f≂g

≂trans : {B : Type 𝓦}{C : Type 𝓧}(f g h : B → C) → f ≂ g → g ≂ h → f ≂ h
≂trans f g h f≂g g≂h k = trans (f≂g k) (g≂h k)



_≋_ : {𝓤 𝓦 : Level}(𝑨 : Algebra 𝓤 𝑆)(𝑩 : Algebra 𝓦 𝑆) → Setω
𝑨 ≋ 𝑩 =  Σω[ f ꞉ (hom 𝑨 𝑩)] Σω[ g ꞉ hom 𝑩 𝑨 ] ((∣ f ∣ ∘ ∣ g ∣ ≂ ∣ 𝒾𝒹 𝑩 ∣) ╳ (∣ g ∣ ∘ ∣ f ∣ ≂ ∣ 𝒾𝒹 𝑨 ∣))


\end{code}

That is, two structures are **isomorphic** provided there are homomorphisms going back and forth between them which compose to the identity map.



#### <a id="isomorphism-is-an-equivalence-relation">Isomorphism is an equivalence relation</a>

\begin{code}

≅-refl : {𝓤 : Level} {𝑨 : Algebra 𝓤 𝑆} → 𝑨 ≅ 𝑨
≅-refl {𝓤}{𝑨} = 𝒾𝒹 𝑨 , 𝒾𝒹 𝑨 , (λ a → refl) , (λ a → refl)

≅-sym : {𝓤 𝓦 : Level}{𝑨 : Algebra 𝓤 𝑆}{𝑩 : Algebra 𝓦 𝑆}
 →      𝑨 ≅ 𝑩 → 𝑩 ≅ 𝑨
≅-sym h = fst ∥ h ∥ , fst h , ∥ snd ∥ h ∥ ∥ , ∣ snd ∥ h ∥ ∣

≅-trans : {𝑨 : Algebra 𝓧 𝑆}{𝑩 : Algebra 𝓨 𝑆}{𝑪 : Algebra 𝓩 𝑆}
 →        𝑨 ≅ 𝑩 → 𝑩 ≅ 𝑪 → 𝑨 ≅ 𝑪

≅-trans {𝑨 = 𝑨} {𝑩}{𝑪} ab bc = f , g , α , β
 where
  f1 : hom 𝑨 𝑩
  f1 = ∣ ab ∣
  f2 : hom 𝑩 𝑪
  f2 = ∣ bc ∣
  f : hom 𝑨 𝑪
  f = ∘-hom 𝑨 𝑪 f1 f2

  g1 : hom 𝑪 𝑩
  g1 = fst ∥ bc ∥
  g2 : hom 𝑩 𝑨
  g2 = fst ∥ ab ∥
  g : hom 𝑪 𝑨
  g = ∘-hom 𝑪 𝑨 g1 g2

  α : ∣ f ∣ ∘ ∣ g ∣ ≈ ∣ 𝒾𝒹 𝑪 ∣
  α x = (cong ∣ f2 ∣(∣ snd ∥ ab ∥ ∣ (∣ g1 ∣ x)))∙(∣ snd ∥ bc ∥ ∣) x

  β : ∣ g ∣ ∘ ∣ f ∣ ≈ ∣ 𝒾𝒹 𝑨 ∣
  β x = (cong ∣ g2 ∣(∥ snd ∥ bc ∥ ∥ (∣ f1 ∣ x)))∙(∥ snd ∥ ab ∥ ∥) x

\end{code}

#### <a id="lift-is-an-algebraic-invariant">Lift is an algebraic invariant</a>

Fortunately, the lift operation preserves isomorphism (i.e., it's an *algebraic invariant*). As our focus is universal algebra, this is important and is what makes the lift operation a workable solution to the technical problems that arise from the noncumulativity of the universe hierarchy discussed in [Overture.Lifts][].

\begin{code}

open Lift

Lift-≅ : {𝑨 : Algebra 𝓤 𝑆} → 𝑨 ≅ (Lift-alg 𝑨 𝓦)
Lift-≅{𝓤}{𝓦} {𝑨} = 𝓁𝒾𝒻𝓉 , (𝓁ℴ𝓌ℯ𝓇{𝓤}{𝓦}{𝑨}) , cong-app lift∼lower , cong-app (lower∼lift {𝓦 = 𝓦})

Lift-hom : (𝓧 : Level)(𝓨 : Level){𝑨 : Algebra 𝓤 𝑆}(𝑩 : Algebra 𝓦 𝑆)
 →         hom 𝑨 𝑩  →  hom (Lift-alg 𝑨 𝓧) (Lift-alg 𝑩 𝓨)

Lift-hom 𝓧 𝓨 {𝑨} 𝑩 (f , fhom) = lift ∘ f ∘ lower , γ
 where
 lABh : is-homomorphism (Lift-alg 𝑨 𝓧) 𝑩 (f ∘ lower)
 lABh = ∘-is-hom (Lift-alg 𝑨 𝓧) 𝑩 {lower}{f} (λ _ _ → refl) fhom

 γ : is-homomorphism(Lift-alg 𝑨 𝓧)(Lift-alg 𝑩 𝓨) (lift ∘ (f ∘ lower))
 γ = ∘-is-hom (Lift-alg 𝑨 𝓧) (Lift-alg 𝑩 𝓨){f ∘ lower}{lift} lABh λ _ _ → refl


Lift-alg-iso : {𝑨 : Algebra 𝓤 𝑆}{𝓧 : Level}
               {𝑩 : Algebra 𝓦 𝑆}{𝓨 : Level}
               -----------------------------------------
 →             𝑨 ≅ 𝑩 → (Lift-alg 𝑨 𝓧) ≅ (Lift-alg 𝑩 𝓨)

Lift-alg-iso A≅B = ≅-trans (≅-trans (≅-sym Lift-≅) A≅B) Lift-≅

\end{code}




#### <a id="lift-associativity">Lift associativity</a>

The lift is also associative, up to isomorphism at least.

\begin{code}

module _ {𝓘 : Level} where

  Lift-alg-assoc : {𝑨 : Algebra 𝓤 𝑆} → Lift-alg 𝑨 (𝓦 ⊔ 𝓘) ≅ (Lift-alg (Lift-alg 𝑨 𝓦) 𝓘)
  Lift-alg-assoc {𝓤}{𝓦}{𝑨} = ≅-trans (≅-trans γ Lift-≅) Lift-≅
   where
   γ : Lift-alg 𝑨 (𝓦 ⊔ 𝓘) ≅ 𝑨
   γ = ≅-sym Lift-≅

  Lift-alg-associative : (𝑨 : Algebra 𝓤 𝑆) → Lift-alg 𝑨 (𝓦 ⊔ 𝓘) ≅ (Lift-alg (Lift-alg 𝑨 𝓦) 𝓘)
  Lift-alg-associative 𝑨 = Lift-alg-assoc {𝑨 = 𝑨}

\end{code}




#### <a id="products-preserve-isomorphisms">Products preserve isomorphisms</a>

Products of isomorphic families of algebras are themselves isomorphic. The proof looks a bit technical, but it is as straightforward as it ought to be.

\begin{code}

module _ {𝓘 : Level}{I : Type 𝓘}{fiu : funext 𝓘 𝓤}{fiw : funext 𝓘 𝓦} where

  ⨅≅ : {𝒜 : I → Algebra 𝓤 𝑆}{ℬ : I → Algebra 𝓦 𝑆} → (∀ (i : I) → 𝒜 i ≅ ℬ i) → ⨅ 𝒜 ≅ ⨅ ℬ

  ⨅≅ {𝒜}{ℬ} AB = γ
   where
   ϕ : ∣ ⨅ 𝒜 ∣ → ∣ ⨅ ℬ ∣
   ϕ a i = ∣ fst (AB i) ∣ (a i)

   ϕhom : is-homomorphism (⨅ 𝒜) (⨅ ℬ) ϕ
   ϕhom 𝑓 a = fiw (λ i → ∥ fst (AB i) ∥ 𝑓 (λ x → a x i))

   ψ : ∣ ⨅ ℬ ∣ → ∣ ⨅ 𝒜 ∣
   ψ b i = ∣ fst ∥ AB i ∥ ∣ (b i)

   ψhom : is-homomorphism (⨅ ℬ) (⨅ 𝒜) ψ
   ψhom 𝑓 𝒃 = fiu (λ i → snd ∣ snd (AB i) ∣ 𝑓 (λ x → 𝒃 x i))

   ϕ~ψ : ϕ ∘ ψ ≈ ∣ 𝒾𝒹 (⨅ ℬ) ∣
   ϕ~ψ 𝒃 = fiw λ i → fst ∥ snd (AB i) ∥ (𝒃 i)

   ψ~ϕ : ψ ∘ ϕ ≈ ∣ 𝒾𝒹 (⨅ 𝒜) ∣
   ψ~ϕ a = fiu λ i → snd ∥ snd (AB i) ∥ (a i)

   γ : ⨅ 𝒜 ≅ ⨅ ℬ
   γ = (ϕ , ϕhom) , ((ψ , ψhom) , ϕ~ψ , ψ~ϕ)

\end{code}


A nearly identical proof goes through for isomorphisms of lifted products (though, just for fun, we use the universal quantifier syntax here to express the dependent function type in the statement of the lemma, instead of the Pi notation we used in the statement of the previous lemma; that is, `∀ i → 𝒜 i ≅ ℬ (lift i)` instead of `Π i ꞉ I , 𝒜 i ≅ ℬ (lift i)`.)

\begin{code}

module _ {𝓘 : Level}{I : Type 𝓘}{fizw : funext (𝓘 ⊔ 𝓩) 𝓦}{fiu : funext 𝓘 𝓤} where

  Lift-alg-⨅≅ : {𝒜 : I → Algebra 𝓤 𝑆}{ℬ : (Lift 𝓩 I) → Algebra 𝓦 𝑆}
   →            (∀ i → 𝒜 i ≅ ℬ (lift i)) → Lift-alg (⨅ 𝒜) 𝓩 ≅ ⨅ ℬ

  Lift-alg-⨅≅ {𝒜}{ℬ} AB = γ
   where
   ϕ : ∣ ⨅ 𝒜 ∣ → ∣ ⨅ ℬ ∣
   ϕ a i = ∣ fst (AB  (lower i)) ∣ (a (lower i))

   ϕhom : is-homomorphism (⨅ 𝒜) (⨅ ℬ) ϕ
   ϕhom 𝑓 a = fizw (λ i → (∥ fst (AB (lower i)) ∥) 𝑓 (λ x → a x (lower i)))

   ψ : ∣ ⨅ ℬ ∣ → ∣ ⨅ 𝒜 ∣
   ψ b i = ∣ fst ∥ AB i ∥ ∣ (b (lift i))

   ψhom : is-homomorphism (⨅ ℬ) (⨅ 𝒜) ψ
   ψhom 𝑓 𝒃 = fiu (λ i → (snd ∣ snd (AB i) ∣) 𝑓 (λ x → 𝒃 x (lift i)))

   ϕ~ψ : ϕ ∘ ψ ≈ ∣ 𝒾𝒹 (⨅ ℬ) ∣
   ϕ~ψ 𝒃 = fizw λ i → fst ∥ snd (AB (lower i)) ∥ (𝒃 i)

   ψ~ϕ : ψ ∘ ϕ ≈ ∣ 𝒾𝒹 (⨅ 𝒜) ∣
   ψ~ϕ a = fiu λ i → snd ∥ snd (AB i) ∥ (a i)

   A≅B : ⨅ 𝒜 ≅ ⨅ ℬ
   A≅B = (ϕ , ϕhom) , ((ψ , ψhom) , ϕ~ψ , ψ~ϕ)

   γ : Lift-alg (⨅ 𝒜) 𝓩 ≅ ⨅ ℬ
   γ = ≅-trans (≅-sym Lift-≅) A≅B

\end{code}






--------------------------------------


<br>

[← Homomorphisms.Noether](Homomorphisms.Noether.html)
<span style="float:right;">[Homomorphisms.HomomorphicImages →](Homomorphisms.HomomorphicImages.html)</span>

{% include UALib.Links.md %}
















<!-- NO LONGER USED

#### <a id="embedding-tools">Embedding tools</a>

Finally, we prove some useful facts about embeddings that occasionally come in handy.

private variable 𝓘 : Level

 -- embedding-lift-nat : hfunext 𝓘 𝓤 → hfunext 𝓘 𝓦
 --   →                   {I : Type 𝓘}{A : I → Type 𝓤}{B : I → Type 𝓦}
 --                       (h : Nat A B) → (∀ i → is-embedding (h i))
 --                       ------------------------------------------
 --   →                   is-embedding(NatΠ h)

 -- embedding-lift-nat hfiu hfiw h hem = NatΠ-is-embedding hfiu hfiw h hem


 -- embedding-lift-nat' : hfunext 𝓘 𝓤 → hfunext 𝓘 𝓦
 --   →                    {I : Type 𝓘}{𝒜 : I → Algebra 𝓤 𝑆}{ℬ : I → Algebra 𝓦 𝑆}
 --                        (h : Nat(fst ∘ 𝒜)(fst ∘ ℬ)) → (∀ i → is-embedding (h i))
 --                        --------------------------------------------------------
 --   →                    is-embedding(NatΠ h)

 -- embedding-lift-nat' hfiu hfiw h hem = NatΠ-is-embedding hfiu hfiw h hem


 -- embedding-lift : hfunext 𝓘 𝓤 → hfunext 𝓘 𝓦
 --   →               {I : Type 𝓘} → {𝒜 : I → Algebra 𝓤 𝑆}{ℬ : I → Algebra 𝓦 𝑆}
 --   →               (h : ∀ i → ∣ 𝒜 i ∣ → ∣ ℬ i ∣) → (∀ i → is-embedding (h i))
 --                   ----------------------------------------------------------
 --   →               is-embedding(λ (x : ∣ ⨅ 𝒜 ∣) (i : I) → (h i)(x i))

 -- embedding-lift hfiu hfiw {I}{𝒜}{ℬ} h hem = embedding-lift-nat' hfiu hfiw {I}{𝒜}{ℬ} h hem


 -- iso→embedding : {𝑨 : Algebra 𝓤 𝑆}{𝑩 : Algebra 𝓦 𝑆} → (ϕ : 𝑨 ≅ 𝑩) → is-embedding (fst ∣ ϕ ∣)
 -- iso→embedding ϕ = equiv-is-embedding (fst ∣ ϕ ∣) {!!} -- (invertible-is-equiv (fst ∣ ϕ ∣) finv)
 --  where
 --  finv : invertible (fst ∣ ϕ ∣)
 --  finv = ∣ fst ∥ ϕ ∥ ∣ , (snd ∥ snd ϕ ∥ , fst ∥ snd ϕ ∥)

