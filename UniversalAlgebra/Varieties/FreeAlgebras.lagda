---
layout: default
title : Varieties.FreeAlgebras module (Agda Universal Algebra Library)
date : 2021-03-01
author: William DeMeo
---

## <a id="free-algebras-and-birkhoffs-theorem">Free Algebras and Birkhoff's Theorem</a>

This section presents the [Varieties.FreeAlgebras][] module of the [Agda Universal Algebra Library][].

First we will define the relatively free algebra in a variety, which is the "freest" algebra among (universal for) those algebras that model all identities holding in the variety. Then we give a formal proof of Birkhoff's theorem which says that a variety is an equational class. In other terms, a class `𝒦` of algebras is closed under the operators `H`, `S`, and `P` if and only if 𝒦 is the class of algebras that satisfy some set of identities.

#### <a id="the-free-algebra-in-theory">The free algebra in theory</a>

Recall, we proved in [the universal property](Terms.Basic.html#the-universal-property) section of the [Terms.Basic][] module that the term algebra `𝑻 X` is the absolutely free algebra in the class of all `𝑆`-structures. In this section, we formalize, for a given class `𝒦` of `𝑆`-algebras, the (relatively) free algebra in `S(P 𝒦)` over `X`.

We use the next definition to take a free algebra *for* a class `𝒦` and produce the free algebra *in* `𝒦`.

`Θ(𝒦, 𝑨) := {θ ∈ Con 𝑨 : 𝑨 / θ ∈ (S 𝒦)}` &nbsp; &nbsp; and &nbsp; &nbsp; `ψ(𝒦, 𝑨) := ⋂ Θ(𝒦, 𝑨)`.

Notice that `Θ(𝒦, 𝑨)` may be empty, in which case `ψ(𝒦, 𝑨) = 1` and then `𝑨 / ψ(𝒦, 𝑨)` is trivial.

The free algebra is constructed by applying the above definitions to the special case in which `𝑨` is the term algebra `𝑻 X` of `𝑆`-terms over `X`.

Since `𝑻 X` is free for (and in) the class of all `𝑆`-algebras, it follows that `𝑻 X` is free for every class `𝒦` of `𝑆`-algebras. Of course, `𝑻 X` is not necessarily a member of `𝒦`, but if we form the quotient of `𝑻 X` modulo the congruence `ψ(𝒦, 𝑻 X)`, which we denote by `𝔉 := (𝑻 X) / ψ(𝒦, 𝑻 X)`, then it's not hard to see that `𝔉` is a subdirect product of the algebras in `{(𝑻 𝑋) / θ}`, where `θ` ranges over `Θ(𝒦, 𝑻 X)`, so `𝔉` belongs to `S(P 𝒦)`, and it follows that `𝔉` satisfies all the identities satisfied by all members of `𝒦`.  Indeed, for each pair `p q : 𝑻 X`, if `𝒦 ⊧ p ≈ q`, then `p` and `q` must belong to the same `ψ(𝒦, 𝑻 X)`-class, so `p` and `q` are identified in the quotient `𝔉`.

The `𝔉` that we have just defined is called the **free algebra over** `𝒦` **generated by** `X` and (because of what we just observed) we may say that `𝔉` is free *in* `S(P 𝒦)`.<sup>[1](Varieties.FreeAlgebras.html#fn1)</sup>

\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}

-- Imports from Agda (builtin/primitive) and the Agda Standard Library
open import Agda.Builtin.Equality using (_≡_; refl)
open import Axiom.Extensionality.Propositional renaming (Extensionality to funext)
open import Data.Product using (_,_; Σ; _×_)
open import Data.Sum.Base using (_⊎_)
open import Function.Base  using (_∘_)
open import Level renaming (suc to lsuc; zero to lzero)
open import Relation.Binary using (Rel; IsEquivalence)
open import Relation.Binary.PropositionalEquality.Core using (cong; cong-app)
open import Relation.Unary using (Pred; _∈_; _⊆_)

-- Imports from the Agda Universal Algebra Library
open import Algebras.Basic
open import Overture.Preliminaries
 using (Type; 𝓞; 𝓤; 𝓥; 𝓦; 𝓧; Π; -Π; -Σ; _≡⟨_⟩_; _∎; _∙_;_⁻¹; ∣_∣; ∥_∥; snd; fst; _≈_; id)
open import Overture.Inverses using (Inv; InvIsInv; IsSurjective; Image_∋_; SurjInv; SurjInvIsRightInv≈; IsInjective; InjInv)
open import Relations.Quotients using (⟪_⟫)
open import Relations.Extensionality using (DFunExt; SwellDef; pred-ext; swelldef)
open import Relations.Discrete using (kernel; ker)
open import Relations.Truncation using (is-set; blk-uip; hfunext)


module Varieties.FreeAlgebras {𝑆 : Signature 𝓞 𝓥}{𝓤 : Level} where


open import Algebras.Congruences{𝑆 = 𝑆} using (Con; IsCongruence; mkcon)
open import Algebras.Products{𝑆 = 𝑆} as PRODUCTS using (ov; ⨅)
open import Subalgebras.Subalgebras{𝑆 = 𝑆} using (_≤_; FirstHomCorollary|Set)
open import Homomorphisms.Basic{𝑆 = 𝑆} using (hom; ∘-hom; ⨅-hom-co; ker[_⇒_]_↾_; epi; πker; epi-to-hom; ker-in-con; kercon)
open import Homomorphisms.Noether using (HomFactor≈; HomFactorEpi≈)
open import Homomorphisms.Isomorphisms {𝑆 = 𝑆} using (_≅_; ≅-refl; ≅-sym; Lift-≅)
open import Homomorphisms.HomomorphicImages {𝑆 = 𝑆} using (epi-to-IsHomImage; IsHomImage)
open import Terms.Basic {𝑆 = 𝑆} using (Term; 𝑻; lift-hom; free-lift; free-unique; lift-of-epi-is-epi)
open import Terms.Operations {𝑆 = 𝑆} using (_⟦_⟧; comm-hom-term; free-lift-interp)
open import Varieties.EquationalLogic{𝑆 = 𝑆} using (_⊧_≋_; _⊧_≈_; Th; Mod)
open import Varieties.Preservation {𝑆 = 𝑆}
open import Varieties.Varieties {𝑆 = 𝑆}

open Term


-- NOTATION FOR COMMON UNIVERSE LEVELS --
-- 𝓕 𝓕⁺ : Level
-- 𝓕 = ov 𝓤
-- 𝓕⁺ = lsuc (ov 𝓤)    -- (this will be the level of the relatively free algebra)


\end{code}





We begin by constructing `ℭ`, using the techniques described in the section on <a href="https://ualib.gitlab.io/Varieties.Varieties.html#products-of-classes">products of classes</a>.

\begin{code}

module _ (fe : DFunExt)(wd : SwellDef)  -- extensionality assumptions (can we remove fe?)
         {𝒦 : Pred (Algebra 𝓤 𝑆) (𝓞 ⊔ 𝓥 ⊔ lsuc 𝓤)}
         where

 open PRODUCTS.class-product{𝒦 = S{𝓤}{𝓤} 𝒦}
 open Vlift 𝒦

  -- ℭ is the product of all subalgebras of algebras in 𝒦.
 ℭ : Algebra 𝓕 𝑆
 ℭ = ⨅ 𝔄 -- {𝓤 = 𝓤}{𝒦 = 𝒦})

 X : Type (ov 𝓤)  -- variable symbols
 X = ∣ ℭ ∣

 proj : (i : ℑ) → X → fst ∣ i ∣
 proj i x = x i

 project : (X → ∣ ℭ ∣) → ((𝑨 , _) : ℑ) → X → ∣ 𝑨 ∣
 project h i x = h x i

 proj-id : ((𝑨 , _) : ℑ) → X → ∣ 𝑨 ∣
 proj-id = project id

 𝕋 : Algebra 𝓕⁺ 𝑆
 𝕋 = 𝑻 X
 open class-product-inclusion 𝒦


\end{code}

Observe that the inhabitants of `ℭ` are maps from `ℑ` to `{𝔄 i : i ∈ ℑ}`.  A homomorphism from `𝑻 X` to `ℭ` is obtained as follows.

\begin{code}

 -- homℭ : (X → ∣ ℭ ∣) → hom 𝕋 ℭ
 -- homℭ h = ⨅-hom-co 𝔄 (fe (ov 𝓤) 𝓤){𝓕⁺} 𝕋 λ i → lift-hom (𝔄 i) (λ x → (h x) i)
 homℭ' : hom 𝕋 ℭ
 homℭ' = ⨅-hom-co 𝔄 (fe (ov 𝓤) 𝓤){𝓕⁺} 𝕋 λ i → lift-hom (𝔄 i) (λ x → (h x) i)
  where
  h : X → ∣ ℭ ∣
  h = λ z → z

 homℭ : hom 𝕋 ℭ
 homℭ = ⨅-hom-co 𝔄 (fe 𝓕 𝓤){𝓕⁺} 𝕋 λ i → lift-hom (𝔄 i) (proj i)

\end{code}

#### The universal property of the identity environment

Fix an algebra `𝑨 ∈ S 𝒦`, let `𝔥₀ : X → ∣ 𝑨 ∣` be defined by `𝔥₀ = proj (𝑨 , skA) = λ x → x (𝑨 , skA)`, and let `h : X → ∣ 𝑨 ∣` be any map. We want to show that:

(free-lift 𝑨 𝔥₀) p ≡ (free-lift 𝑨 𝔥₀) q  implies  (free-lift 𝑨 h) p  ≡ (free-lift 𝑨 h) q

We need to prove that projection `𝔥 : X → ∣ 𝑨 ∣` of `X` onto component `𝑨` is "below" every map `h : X → ∣ 𝑨 ∣` in the sense that `kernel 𝔥 ⊆ kernel h`.
  {- if h p ≢ h q  then  𝔥₀ p ≢ 𝔥₀ q -}
Every `h : X → ∣ 𝑨 ∣` can be decomposed as `h = g ∘ 𝔥`, where `g : ∣ 𝑨 ∣ → ∣ 𝑨 ∣`.  Specifically, since `𝔥` is surjective, it has a right inverse 𝔥⁻¹, so `h ∘ 𝔥⁻¹ = g`.  Therefore, `h = (h ∘ 𝔥⁻¹) ∘ 𝔥`.

\begin{code}


 module _ {𝑨 : Algebra 𝓤 𝑆}{skA : 𝑨 ∈ S{𝓤}{𝓤} 𝒦} where
  𝔥₀ : X → ∣ 𝑨 ∣
  𝔥₀ x = x (𝑨 , skA)

  open Image_∋_
  homℭker : Term X → Term X → Type 𝓤
  homℭker p q = (free-lift 𝑨 𝔥₀) p ≡ (free-lift 𝑨 𝔥₀) q

  lemker : ∀ (h : X → ∣ 𝑨 ∣) → kernel 𝔥₀ ⊆ kernel h
  lemker h {(p , q)} pKq = γ
   where
   ξ : p (𝑨 , skA) ≡ q (𝑨 , skA)
   ξ = pKq

   h₀Inv : (a : ∣ 𝑨 ∣) → Image 𝔥₀ ∋ a → X
   h₀Inv .(x (𝑨 , skA)) (im x) = x
   h₀Inv a (eq _ x _) = x

   ζ : ∀ x y a → (ahx : a ≡ 𝔥₀ x)(ahy : a ≡ 𝔥₀ y)
    →  (h₀Inv (𝔥₀ x) (eq (𝔥₀ x) x refl)) ≡ (h₀Inv (𝔥₀ y) (eq (𝔥₀ y) y refl))
   ζ x y a ahx ahy = {!!}

   --  eq : (b : B) → (a : A) → b ≡ f a → Image f ∋ b

   γ : h p ≡ h q
   γ = h (h₀Inv (𝔥₀ p) (eq (𝔥₀ p) p refl)) ≡⟨ cong h ((ζ p q (𝔥₀ q) (pKq ⁻¹) refl )) ⟩
       h (h₀Inv (𝔥₀ q) (eq (𝔥₀ q) q refl)) ∎

\end{code}



#### <a id="the-free-algebra">The free algebra</a>

 As mentioned above, the initial version of the [Agda UniversalAlgebra][] used the free algebra `𝔉` developed above.  However, our new, more direct proof uses the algebra `𝔽`, which we now define, along with the natural epimorphism `epi𝔽 : epi (𝑻 X) 𝔽` from `𝑻 X` to `𝔽`.

 We now define the algebra `𝔽`, which plays the role of the free algebra, along with the natural epimorphism `epi𝔽 : epi (𝑻 X) 𝔽` from `𝑻 X` to `𝔽`.

\begin{code}

 𝔽 : (X → ∣ ℭ ∣) → Algebra 𝓕⁺ 𝑆
 𝔽 h = ker[ 𝕋 ⇒ ℭ ] homℭ ↾ (wd 𝓥 𝓕)

 epi𝔽 : (h : X → ∣ ℭ ∣) → epi 𝕋 (𝔽 h)
 epi𝔽 h = πker (wd 𝓥 𝓕) {ℭ} homℭ

 hom𝔽 : (h : X → ∣ ℭ ∣) → hom 𝕋 (𝔽 h)
 hom𝔽 h = epi-to-hom (𝔽 h) (epi𝔽 h)

 hom𝔽-is-epic : (h : X → ∣ ℭ ∣) → IsSurjective ∣ hom𝔽  h ∣
 hom𝔽-is-epic h = snd ∥ epi𝔽 h ∥


\end{code}




#### <a id="the-free-algebra-in-agda">The free algebra in Agda</a>

Before we attempt to represent the free algebra in Agda we construct the congruence `ψ(𝒦, 𝑻 𝑋)` described above.
First, we represent the congruence relation `ψCon`, modulo which `𝑻 X` yields the relatively free algebra, `𝔉 𝒦 X := 𝑻 X ╱ ψCon`.  We let `ψ` be the collection of identities `(p, q)` satisfied by all subalgebras of algebras in `𝒦`.

\begin{code}

 ψ : Pred (∣ 𝕋 ∣ × ∣ 𝕋 ∣) 𝓕
 ψ (p , q) = ∀(𝑨 : Algebra 𝓤 𝑆)(sA : 𝑨 ∈ S{𝓤}{𝓤} 𝒦) →  𝑨 ⟦ p ⟧ ≈ 𝑨 ⟦ q ⟧

\end{code}

We convert the predicate ψ into a relation by [currying](https://en.wikipedia.org/wiki/Currying).

\begin{code}

 ψRel : Rel ∣ 𝕋 ∣ 𝓕
 ψRel p q = ψ (p , q)

\end{code}

To express `ψRel` as a congruence of the term algebra `𝑻 X`, we must prove that

1. `ψRel` is compatible with the operations of `𝑻 X` (which are jsut the terms themselves) and
2. `ψRel` it is an equivalence relation.

\begin{code}

 ψcompatible : compatible 𝕋 ψRel
 ψcompatible 𝑓 {p} {q} ψpq 𝑨 sA h = γ
  where
  φ : hom 𝕋 𝑨
  φ = lift-hom 𝑨 h

  γ : (𝑓 ̂ 𝑨)(λ i → (𝑨 ⟦ p i ⟧) h) ≡ (𝑓 ̂ 𝑨)(λ i → (𝑨 ⟦ q i ⟧) h)
  γ = wd 𝓥 𝓤 (𝑓 ̂ 𝑨) (λ i → (𝑨 ⟦ p i ⟧) h) (λ i → (𝑨 ⟦ q i ⟧) h) λ i → ψpq i 𝑨 sA h


 ψIsEquivalence : IsEquivalence ψRel
 ψIsEquivalence = record { refl = λ 𝑨 sA h → refl
                         ; sym = λ x 𝑨 sA h → (x 𝑨 sA h)⁻¹
                         ; trans = λ pψq qψr 𝑨 sA h → (pψq 𝑨 sA h) ∙ (qψr 𝑨 sA h) }
\end{code}

We have collected all the pieces necessary to express the collection of identities satisfied by all subalgebras of algebras in the class as a congruence relation of the term algebra. We call this congruence `ψCon` and define it using the Congruence constructor `mkcon`.

\begin{code}

 ψCon : Con 𝕋
 ψCon = ψRel , mkcon ψIsEquivalence ψcompatible

\end{code}





#### <a id="hsp-theorem">HSP Theorem</a>

This section presents a formal proof of the Birkhoff HSP theorem.

To complete the proof of Birkhoff's HSP theorem, it remains to show that `Mod X (Th (V 𝒦))` is contained in `V 𝒦`; that is, every algebra that models the equations in `Th (V 𝒦)` belongs to `V 𝒦`.  This will prove that `V 𝒦` is an equational class.  (The converse, that every equational class is a variety was already proved; see the remarks at the end of this module.)

We accomplish this goal by constructing an algebra `𝔽` with the following properties:

1. `𝔽 ∈ V 𝒦` and

2. Every `𝑨 ∈ Mod X (Th (V 𝒦))` is a homomorphic image of `𝔽`.

We denote by `ℭ` the product of all subalgebras of algebras in `𝒦`, and by `homℭ` the homomorphism from `𝑻 X` to `ℭ` defined as follows: `homℭ := ⨅-hom-co (𝑻 X) 𝔄s hom𝔄`.

Here, `⨅-hom-co` (defined in [Homomorphisms.Basic](Homomorphisms.Basic.html#product-homomorphisms)) takes the term algebra `𝑻 X`, a family `{𝔄s : I → Algebra 𝓤 𝑆}` of `𝑆`-algebras, and a family `hom𝔄 : ∀ i → hom (𝑻 X) (𝔄s i)` of homomorphisms and constructs the natural homomorphism `homℭ` from `𝑻 X` to the product `ℭ := ⨅ 𝔄`.  The homomorphism `homℭ : hom (𝑻 X) (⨅ ℭ)` is natural in the sense that the `i`-th component of the image of `𝑡 : Term X` under `homℭ` is the image `∣ hom𝔄 i ∣ 𝑡` of 𝑡 under the i-th homomorphism `hom𝔄 i`.





#### <a id="F-in-classproduct">𝔽 ≤  ⨅ S(𝒦)</a>
Now we come to a step in the Agda formalization of Birkhoff's theorem that is highly nontrivial. We must prove that the free algebra embeds in the product ℭ of all subalgebras of algebras in the class `𝒦`.  This is really the only stage in the proof of Birkhoff's theorem that requires the truncation assumption that `ℭ` be a *set* (that is, `ℭ` has the [UIP][] property).  We will also need to assume several local function extensionality postulates and, as a result, the next submodule will take as given the parameter `fe : DFunExt`.  This allows us to postulate local function extensionality when and where we need it in the proof. For example, if we want to assume function extensionality at universe levels 𝓥 and 𝓤, we simply apply `fe` to those universes: `fe 𝓥 𝓤`. (Earlier versions of the library used just a single *global* function extensionality postulate at the start of most modules, but we have since decided to exchange that elegant but crude option for greater precision and transparency.)

We will need the following facts relating `homℭ`, `hom𝔽`, `and ψ`.

\begin{code}

 ψlemma0 : ∀ p q → ∣ homℭ ∣ p ≡ ∣ homℭ ∣ q → (p , q) ∈ ψ
 ψlemma0 p q phomℭq 𝑨 sA h = γ -- cong-app phomℭq (𝑨 , sA)
  where
  γ : (𝑨 ⟦ p ⟧) h ≡ (𝑨 ⟦ q ⟧) h
  γ = (𝑨 ⟦ p ⟧) h ≡⟨ free-lift-interp (wd 𝓥 𝓤) 𝑨 h p ⟩
      (free-lift 𝑨 h) p  ≡⟨ {!!} ⟩ -- cong-app phomℭq ((𝑨 , sA)) ⟩
      (free-lift 𝑨 h) q ≡⟨ (free-lift-interp (wd 𝓥 𝓤) 𝑨 h q)⁻¹ ⟩
      (𝑨 ⟦ q ⟧) h        ∎

 ψlemma0-ap : {𝑨 : Algebra 𝓤 𝑆}{h : X → ∣ ℭ ∣}(skA : 𝑨 ∈ S{𝓤}{𝓤} 𝒦)
  →           kernel ∣ hom𝔽 h ∣ ⊆ kernel (free-lift 𝑨 (project h (𝑨 , skA)))

 ψlemma0-ap {𝑨}{h} skA {p , q} x = γ where

  ν : ∣ homℭ ∣ p ≡ ∣ homℭ ∣ q
  ν = ker-in-con {𝑨 = 𝕋}{wd 𝓥 𝓕⁺}(kercon (wd 𝓥 𝓕) {ℭ} homℭ) {p}{q} x
  ζ : ∀ 𝑨 sA h → (𝑨 ⟦ p ⟧) h ≡ (𝑨 ⟦ q ⟧) h
  ζ = ψlemma0 p q ν

  𝔥 : X → ∣ 𝑨 ∣
  𝔥 = (project h (𝑨 , skA))
  γ : (p , q) ∈ kernel (free-lift 𝑨 𝔥)
  γ = (free-lift 𝑨 𝔥 p) ≡⟨ (free-lift-interp (wd 𝓥 𝓤) 𝑨 𝔥 p)⁻¹ ⟩
      (𝑨 ⟦ p ⟧) 𝔥 ≡⟨ ζ 𝑨 skA 𝔥 ⟩
      (𝑨 ⟦ q ⟧) 𝔥 ≡⟨ free-lift-interp (wd 𝓥 𝓤) 𝑨 𝔥 q ⟩
      (free-lift 𝑨 𝔥 q) ∎


\end{code}

We now use `ψlemma0-ap` to prove that every map `h : X → ∣ 𝑨 ∣`, from `X` to a subalgebra `𝑨 ∈ S 𝒦` of `𝒦`, lifts to a homomorphism from `𝔽` to `𝑨`.

\begin{code}

 𝔽-lift-hom : (𝑨 : Algebra 𝓤 𝑆) → 𝑨 ∈ S{𝓤}{𝓤} 𝒦 → (h : X → ∣ ℭ ∣) → hom (𝔽 h) 𝑨
 𝔽-lift-hom 𝑨 skA h = fst(HomFactor≈ (wd 𝓥 𝓕⁺) 𝑨 (lift-hom 𝑨 (project h (𝑨 , skA)))
                                                (hom𝔽 h) (ψlemma0-ap skA) (hom𝔽-is-epic h))

\end{code}


#### <a id="k-models-psi">𝒦 models ψ</a>

The goal of this subsection is to prove that `𝒦` models `ψ 𝒦`. In other terms, for all pairs `(p , q) ∈ Term X × Term X` of terms, if `(p , q) ∈ ψ 𝒦`, then `𝒦 ⊧ p ≋ q`.

Next we define the lift of the natural embedding from `X` into 𝔽. We denote this homomorphism by `𝔑 : hom (𝑻 X) 𝔽` and define it as follows.

\begin{code}

 open IsCongruence

 X↪𝔽 : (h : X → ∣ ℭ ∣) → X → ∣ 𝔽 h ∣
 X↪𝔽 h x = ⟪ ℊ x ⟫ -- (the implicit relation here is  ⟨ kercon (fe 𝓥 𝓕) ℭ homℭ ⟩ )

 𝔑 : (h : X → ∣ ℭ ∣) → hom 𝕋 (𝔽 h)
 𝔑 h = lift-hom (𝔽 h) (X↪𝔽 h)

\end{code}

It turns out that the homomorphism so defined is equivalent to `hom𝔽`.

\begin{code}

 hom𝔽-is-lift-hom : (h : X → ∣ ℭ ∣) → ∀ p → ∣ 𝔑 h ∣ p ≡ ∣ hom𝔽 h ∣ p
 hom𝔽-is-lift-hom h (ℊ x) = refl
 hom𝔽-is-lift-hom h (node 𝑓 t) =
  ∣ 𝔑 h ∣ (node 𝑓 t)                  ≡⟨ ∥ 𝔑 h ∥ 𝑓 t ⟩
  (𝑓 ̂ (𝔽 h))(λ i → ∣ 𝔑 h ∣(t i))     ≡⟨ wd 𝓥 𝓕⁺ (𝑓 ̂ (𝔽 h))(λ i → ∣ 𝔑 h ∣(t i))(λ i → ∣ hom𝔽 h ∣(t i)) ξ ⟩
  (𝑓 ̂ (𝔽 h))(λ i → ∣ hom𝔽 h ∣ (t i)) ≡⟨ (∥ hom𝔽 h ∥ 𝑓 t)⁻¹ ⟩
  ∣ hom𝔽 h ∣ (node 𝑓 t)           ∎
  where
  ξ : ∣ 𝔑 h ∣ ∘ t ≈ ∣ hom𝔽 h ∣ ∘ t
  ξ = λ i → hom𝔽-is-lift-hom (λ z → z) (t i)

\end{code}

We need a three more lemmas before we are ready to tackle our main goal.

\begin{code}

 ψlemma1 : (ℎ : X → ∣ ℭ ∣) → kernel ∣ 𝔑 ℎ ∣ ⊆ ψ
 ψlemma1 ℎ {p , q} 𝔑pq 𝑨 sA = γ
  where
  f : hom (𝔽 ℎ) 𝑨
  f = 𝔽-lift-hom 𝑨 sA ℎ

  h' φ : hom 𝕋 𝑨
  h' = ∘-hom 𝕋 𝑨 (𝔑 ℎ) f
  φ = lift-hom 𝑨 (project ℎ (𝑨 , sA))

  h≡φ : ∀ t → (∣ f ∣ ∘ ∣ 𝔑 ℎ ∣) t ≡ ∣ φ ∣ t
  h≡φ t = free-unique (fe 𝓥 𝓤) 𝑨 h' φ (λ x → refl) t

  γ' : ∣ φ ∣ p ≡ ∣ φ ∣ q
  γ' = ∣ φ ∣ p             ≡⟨ (h≡φ p)⁻¹ ⟩
       ∣ f ∣ ( ∣ 𝔑 ℎ ∣ p )   ≡⟨ cong ∣ f ∣ 𝔑pq ⟩
       ∣ f ∣ ( ∣ 𝔑 ℎ ∣ q )   ≡⟨ h≡φ q ⟩
       ∣ φ ∣ q             ∎


  γ : 𝑨 ⟦ p ⟧ ≈ 𝑨 ⟦ q ⟧
  γ a = (𝑨 ⟦ p ⟧) a ≡⟨ free-lift-interp (wd 𝓥 𝓤) 𝑨 a p ⟩
      (free-lift 𝑨 a) p  ≡⟨ {!!} ⟩
      (free-lift 𝑨 a) q ≡⟨ (free-lift-interp (wd 𝓥 𝓤) 𝑨 a q)⁻¹ ⟩
      (𝑨 ⟦ q ⟧) a        ∎

 ψlemma2 : (ℎ : X → ∣ ℭ ∣) → kernel ∣ hom𝔽 ℎ ∣ ⊆ ψ
 ψlemma2 ℎ {p , q} hyp = ψlemma1 ℎ {p , q} γ
   where
    γ : (free-lift (𝔽 ℎ) (X↪𝔽 ℎ)) p ≡ (free-lift (𝔽 ℎ) (X↪𝔽 ℎ)) q
    γ = (hom𝔽-is-lift-hom ℎ p) ∙ hyp ∙ (hom𝔽-is-lift-hom ℎ q)⁻¹


 ψlemma3 : ∀ p q → (p , q) ∈ ψ → 𝒦 ⊧ p ≋ q
 ψlemma3 p q pψq {𝑨} kA = pψq 𝑨 (siso (sbase kA) (≅-sym Lift-≅))

\end{code}

With these results in hand, it is now trivial to prove the main theorem of this subsection.

\begin{code}

 class-models-kernel :  (ℎ : X → ∣ ℭ ∣) → ∀ p q → (p , q) ∈ kernel ∣ hom𝔽 ℎ ∣ → 𝒦 ⊧ p ≋ q
 class-models-kernel ℎ p q hyp = ψlemma3 p q (ψlemma2 ℎ hyp)

 𝕍𝒦 : Pred (Algebra 𝓕⁺ 𝑆) (lsuc 𝓕⁺)
 𝕍𝒦 = V{𝓤}{𝓕⁺} 𝒦

 kernel-in-theory : (ℎ : X → ∣ ℭ ∣) → kernel ∣ hom𝔽 ℎ ∣ ⊆ Th 𝕍𝒦
 kernel-in-theory ℎ {p , q} pKq {𝑨} = ξ
  where
  Kpq : 𝒦 ⊧ p ≋ q
  Kpq kA₁ h₁ = class-models-kernel ℎ p q pKq kA₁ h₁

  ξ : (p , q) ∈ Th 𝕍𝒦
  ξ = class-ids fe wd p q Kpq

 X↠ : Algebra 𝓕⁺ 𝑆 → Type 𝓕⁺
 X↠ 𝑨 = Σ[ h ꞉ (X → ∣ 𝑨 ∣) ] IsSurjective h

 𝔽-ModTh-epi : (h : X → ∣ ℭ ∣) → (𝑨 : Algebra 𝓕⁺ 𝑆) → (X↠ 𝑨) → 𝑨 ∈ Mod{𝓤 = 𝓕⁺}{X = X} (Th 𝕍𝒦) → epi (𝔽 h) 𝑨
 𝔽-ModTh-epi h 𝑨 (η , ηE) AinMTV = γ
  where
  φ : hom (𝑻 X) 𝑨
  φ = lift-hom 𝑨 η

  φE : IsSurjective ∣ φ ∣
  φE = lift-of-epi-is-epi 𝑨 ηE

  pqlem1 : ∀ p q → (p , q) ∈ kernel ∣ hom𝔽 h ∣ → (p , q) ∈ Th 𝕍𝒦
  pqlem1 p q hyp = kernel-in-theory h hyp
  pqlem2 : ∀ p q → (p , q) ∈ Th 𝕍𝒦 → 𝑨 ⊧ p ≈ q
  pqlem2 p q hyp x = AinMTV p q hyp x

  kerincl : kernel ∣ hom𝔽 h ∣ ⊆ kernel ∣ φ ∣
  kerincl {p , q} x = ∣ φ ∣ p      ≡⟨ (free-lift-interp (wd 𝓥 𝓕⁺) 𝑨 η p)⁻¹ ⟩
                      (𝑨 ⟦ p ⟧) η  ≡⟨ pqlem2 p q (pqlem1 p q x) η ⟩
                      (𝑨 ⟦ q ⟧) η  ≡⟨ free-lift-interp (wd 𝓥 𝓕⁺) 𝑨 η q ⟩
                      ∣ φ ∣ q      ∎

  γ : epi (𝔽 h) 𝑨
  γ = fst (HomFactorEpi≈ (wd 𝓥 𝓕⁺) 𝑨 φ (hom𝔽 h) kerincl (hom𝔽-is-epic h) φE)

\end{code}





#### <a id="the-homomorphic-images-of-F">The homomorphic images of 𝔽</a>

Finally we come to one of the main theorems of this module; it asserts that every algebra in `Mod X (Th 𝕍𝒦)` is a homomorphic image of 𝔽.  We prove this below as the function (or proof object) `𝔽-ModTh-epi`.  Before that, we prove two auxiliary lemmas.

\begin{code}

 module _ (h : X → ∣ ℭ ∣)
          (pe : pred-ext 𝓕⁺ 𝓕)(wd : SwellDef)                      -- extensionality assumptions
          (Cset : is-set ∣ ℭ ∣)(kuip : blk-uip(Term X)∣ kercon (wd 𝓥 𝓕){ℭ} homℭ ∣) -- truncation assumptions
  where

  𝔽≤ℭ : (ker[ 𝑻 X ⇒ ℭ ] homℭ ↾ (wd 𝓥 𝓕)) ≤ ℭ
  𝔽≤ℭ = FirstHomCorollary|Set 𝕋 ℭ homℭ pe (wd 𝓥 𝓕) Cset kuip

\end{code}

The last piece we need to prove that every model of `Th 𝕍𝒦` is a homomorphic image of `𝔽` is a crucial assumption that is taken for granted throughout informal universal algebra---namely, that our collection `X` of variable symbols is arbitrarily large and that we have an *environment* which interprets the variable symbols in every algebra under consideration. In other terms, an environment provides, for every algebra `𝑨`, a surjective mapping `η : X → ∣ 𝑨 ∣` from `X` onto the domain of `𝑨`.

We do *not* assert that for an arbitrary type `X` such surjective maps exist.  Indeed, our `X` must is quite special to have this property.  Later, we will construct such an `X`, but for now we simply postulate its existence. Note that this assumption that an environment exists is only required in the proof of the theorem `𝔽-ModTh-epi`.

\begin{code}


\end{code}

#### <a id="F-in-VK">𝔽 ∈ V(𝒦)</a>

With this result in hand, along with what we proved earlier---namely, `PS(𝒦) ⊆ SP(𝒦) ⊆ HSP(𝒦) ≡ V 𝒦`---it is not hard to show that `𝔽` belongs to `V 𝒦`.

\begin{code}

--   open Vlift 𝒦

  𝔽∈SP : DFunExt → (𝔽 h) ∈ (S{𝓕}{𝓕⁺} (P{𝓤}{𝓕} 𝒦))
  𝔽∈SP fe = ssub (class-prod-s-∈-sp fe) 𝔽≤ℭ

  𝔽∈𝕍 : DFunExt → (𝔽 h) ∈ V 𝒦
  𝔽∈𝕍 fe = SP⊆V' fe (𝔽∈SP fe)

\end{code}

#### <a id="the-hsp-theorem"> The HSP Theorem</a>

Now that we have all of the necessary ingredients, it is all but trivial to combine them to prove Birkhoff's HSP theorem. (Note that since the proof enlists the help of the `𝔽-ModTh-epi` theorem, we must assume an environment exists, which is manifested in the premise `∀ 𝑨 → X ↠ 𝑨`.

\begin{code}

  Birkhoff : DFunExt → (∀ 𝑨 → X↠ 𝑨) → Mod (Th (V 𝒦)) ⊆  V 𝒦

  Birkhoff fe 𝕏 {𝑨} α = γ
   where
    ζ : IsHomImage 𝑨
    ζ = epi-to-IsHomImage 𝑨 (𝔽-ModTh-epi (λ z → z) 𝑨 (𝕏 𝑨) α)

    γ : 𝑨 ∈ V 𝒦
    γ = vhimg{𝑩 = 𝑨} (𝔽∈𝕍 fe) (𝑨 , ζ)

\end{code}

data V {𝓤 𝓦 : Level}(𝒦 : Pred(Algebra 𝓤 𝑆)(ov 𝓤)) : Pred(Algebra(𝓤 ⊔ 𝓦)𝑆)(ov(𝓤 ⊔ 𝓦))

The converse inclusion, `V 𝒦 ⊆ Mod X (Th (V 𝒦))`, is a simple consequence of the fact that `Mod Th` is a closure operator. Nonetheless, completeness demands that we formalize this inclusion as well, however trivial the proof.

\begin{code}

  Birkhoff-converse : V{𝓤}{𝓕} 𝒦 ⊆ Mod{𝓧 = (ov 𝓤)}{X = X} (Th (V 𝒦))
  Birkhoff-converse α p q pThq = pThq α

\end{code}

We have thus proved that every variety is an equational class.  Readers familiar with the classical formulation of the Birkhoff HSP theorem, as an "if and only if" result, might worry that we haven't completed the proof.  But recall that in the [Varieties.Preservation][] module we proved the following identity preservation lemmas:

* `𝒦 ⊧ p ≋ q → H 𝒦 ⊧ p ≋ q`
* `𝒦 ⊧ p ≋ q → S 𝒦 ⊧ p ≋ q`
* `𝒦 ⊧ p ≋ q → P 𝒦 ⊧ p ≋ q`

From these it follows that every equational class is a variety. Thus, our formal proof of Birkhoff's theorem is complete.

----------------------------


<sup>1</sup><span class="footnote" id="fn1"> Since `X` is not a subset of `𝔉`, technically it doesn't make sense to say "`X` generates `𝔉`." But as long as 𝒦 contains a nontrivial algebra, we will have `ψ(𝒦, 𝑻 𝑋) ∩ X² ≠ ∅`, and we can identify `X` with `X / ψ(𝒦, 𝑻 X)` which does belong to 𝔉.</span>

<br>
<br>


[← Varieties.Preservation](Varieties.Preservation.html)
<span style="float:right;">[Varieties ↑](Varieties.html)</span>

{% include UALib.Links.md %}






