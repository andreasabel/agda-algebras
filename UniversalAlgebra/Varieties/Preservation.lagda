---
layout: default
title : Varieties.Preservation (The Agda Universal Algebra Library)
date : 2021-01-14
author: William DeMeo
---

### <a id="Equation preservation">Equation preservation</a>

This section presents the [Varieties.Preservation][] module of the [Agda Universal Algebra Library][]. In this module we show that identities are preserved by closure operators H, S, and P.  This will establish the easy direction of Birkhoff's HSP Theorem.


\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}

-- Imports from Agda (builtin/primitive) and the Agda Standard Library
open import Agda.Builtin.Equality using (_≡_; refl)
open import Data.Product using (_,_; Σ; _×_)
open import Data.Sum.Base using (_⊎_)
open import Function.Base  using (_∘_)
open import Level renaming (suc to lsuc; zero to lzero)
open import Relation.Binary.PropositionalEquality.Core using (cong; cong-app)
open import Relation.Unary using (Pred; _∈_; _⊆_; ｛_｝; _∪_)

-- Imports from the Agda Universal Algebra Library
open import Algebras.Basic
open import Overture.Preliminaries
 using (Type; 𝓞; 𝓤; 𝓥; 𝓦; 𝓧; Π; -Π; -Σ; _≡⟨_⟩_; _∎; _∙_;_⁻¹; ∣_∣; ∥_∥; snd; fst)
open import Overture.Inverses -- using (Inv; InvIsInv)
open import Relations.Extensionality using (DFunExt; SwellDef)


module Varieties.Preservation  {𝑆 : Signature 𝓞 𝓥} where



open import Algebras.Products{𝑆 = 𝑆} using (ov)
open import Homomorphisms.Isomorphisms {𝑆 = 𝑆} using (_≅_; ≅-refl)
open import Terms.Basic {𝑆 = 𝑆} using (Term; 𝑻; lift-hom)
open import Terms.Operations {𝑆 = 𝑆} using (_⟦_⟧; comm-hom-term)
open import Subalgebras.Subalgebras {𝑆 = 𝑆} using (SubalgebraOfClass)
open import Varieties.EquationalLogic{𝑆 = 𝑆}
 using (_⊧_≋_; _⊧_≈_; Th; ⊧-I-invar; ⊧-Lift-invar; ⊧-lower-invar; ⊧-S-invar; ⊧-S-class-invar; ⊧-P-lift-invar; ⊧-P-invar)
open import Varieties.Varieties {𝑆 = 𝑆} using (H; S; P; V)

open H
open S
open P
open V
open Term
open _⊎_

\end{code}



#### <a id="h-preserves-identities">H preserves identities</a>

First we prove that the closure operator H is compatible with identities that hold in the given class.

\begin{code}

module _ (wd : SwellDef){X : Type 𝓧} {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 H-id1 : (p q : Term X) → 𝒦 ⊧ p ≋ q → H{𝓦 = 𝓤} 𝒦 ⊧ p ≋ q
 H-id1 p q α (hbase x) = ⊧-Lift-invar wd p q (α x)
 H-id1 p q α (hlift{𝑨} x) = ⊧-Lift-invar wd p q (H-id1 p q α x)

 H-id1 p q α (hhimg{𝑨}{𝑪} HA (𝑩 , ((φ , φh) , φE))) b = γ
  where
  IH : 𝑨 ⊧ p ≈ q
  IH = (H-id1 p q α) HA

  preim : X → ∣ 𝑨 ∣
  preim x = Inv φ (φE (b x))

  ζ : ∀ x → φ (preim x) ≡ b x
  ζ x = InvIsInv φ (φE (b x))

  γ : (𝑩 ⟦ p ⟧) b ≡ (𝑩 ⟦ q ⟧) b
  γ = (𝑩 ⟦ p ⟧) b          ≡⟨ wd 𝓧 𝓤 (𝑩 ⟦ p ⟧) b (φ ∘ preim )(λ i → (ζ i)⁻¹)⟩
      (𝑩 ⟦ p ⟧)(φ ∘ preim) ≡⟨(comm-hom-term (wd 𝓥 𝓤) 𝑩 (φ , φh) p preim)⁻¹ ⟩
      φ((𝑨 ⟦ p ⟧) preim)   ≡⟨ cong φ (IH preim) ⟩
      φ((𝑨 ⟦ q ⟧) preim)   ≡⟨ comm-hom-term (wd 𝓥 𝓤) 𝑩 (φ , φh) q preim ⟩
      (𝑩 ⟦ q ⟧)(φ ∘ preim) ≡⟨ wd 𝓧 𝓤 (𝑩 ⟦ q ⟧)(φ ∘ preim) b ζ ⟩
      (𝑩 ⟦ q ⟧) b          ∎

 H-id1 p q α (hiso{𝑨}{𝑩} x x₁) = ⊧-I-invar wd 𝑩 p q (H-id1 p q α x) x₁

\end{code}

The converse of the foregoing result is almost too obvious to bother with. Nonetheless, we formalize it for completeness.

\begin{code}

module _ (wd : SwellDef){X : Type 𝓧} {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 H-id2 : ∀ {𝓦} → (p q : Term X) → H{𝓦 = 𝓦} 𝒦 ⊧ p ≋ q → 𝒦 ⊧ p ≋ q

 H-id2 p q Hpq KA = ⊧-lower-invar wd p q (Hpq (hbase KA))

\end{code}


#### <a id="s-preserves-identities">S preserves identities</a>

\begin{code}

 S-id1 : (p q : Term X) → 𝒦 ⊧ p ≋ q → S{𝓦 = 𝓤} 𝒦 ⊧ p ≋ q

 S-id1 p q α (sbase x) = ⊧-Lift-invar wd p q (α x)
 S-id1 p q α (slift x) = ⊧-Lift-invar wd p q ((S-id1 p q α) x)

 S-id1 p q α (ssub{𝑨}{𝑩} sA B≤A) = ⊧-S-class-invar wd p q γ ν
  where --Apply S-⊧ to the class 𝒦 ∪ ｛ 𝑨 ｝
  β : 𝑨 ⊧ p ≈ q
  β = S-id1 p q α sA

  Apq : ｛ 𝑨 ｝ ⊧ p ≋ q
  Apq refl = β

  γ : (𝒦 ∪ ｛ 𝑨 ｝) ⊧ p ≋ q
  γ {𝑩} (inj₁ x) = α x
  γ {𝑩} (inj₂ y) = Apq y

  ν : SubalgebraOfClass (λ z → (𝒦 ∪ ｛ 𝑨 ｝) (Data.Product.proj₁ z , Data.Product.proj₂ z))
  ν = (𝑩 , 𝑨 , (𝑩 , B≤A) , _⊎_.inj₂ refl , ≅-refl)

 S-id1 p q α (ssubw{𝑨}{𝑩} sA B≤A) = ⊧-S-class-invar wd p q γ (𝑩 , 𝑨 , (𝑩 , B≤A) , inj₂ refl , ≅-refl)
  where  --Apply S-⊧ to the class 𝒦 ∪ ｛ 𝑨 ｝
  β : 𝑨 ⊧ p ≈ q
  β = S-id1 p q α sA

  Apq : ｛ 𝑨 ｝ ⊧ p ≋ q
  Apq refl = β

  γ : (𝒦 ∪ ｛ 𝑨 ｝) ⊧ p ≋ q
  γ {𝑩} (inj₁ x) = α x
  γ {𝑩} (inj₂ y) = Apq y

 S-id1 p q α (siso{𝑨}{𝑩} x x₁) = ⊧-I-invar wd 𝑩 p q (S-id1 p q α x) x₁

\end{code}

Again, the obvious converse is barely worth the bits needed to formalize it.

\begin{code}

 S-id2 : ∀{𝓦}(p q : Term X) → S{𝓦 = 𝓦}𝒦 ⊧ p ≋ q → 𝒦 ⊧ p ≋ q

 S-id2 p q Spq {𝑨} KA = ⊧-lower-invar wd p q (Spq (sbase KA))

\end{code}


#### <a id="p-preserves-identities">P preserves identities</a>

Notice that the submodule in this section requires a **function extensionality** postulate `DFunExt`, unlike the other submodules of the [Varieties.Preservation][] module (which, with one other exception, only require strong well-definedness of functions, `SwellDef`).

\begin{code}

module _ (fe : DFunExt) (wd : SwellDef){X : Type 𝓧} {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 P-id1 : (p q : Term X) → 𝒦 ⊧ p ≋ q → P{𝓦 = 𝓤} 𝒦 ⊧ p ≋ q

 P-id1 p q α (pbase x) = ⊧-Lift-invar wd p q (α x)
 P-id1 p q α (pliftu x) = ⊧-Lift-invar wd p q ((P-id1 p q α) x)
 P-id1 p q α (pliftw x) = ⊧-Lift-invar wd p q ((P-id1 p q α) x)

 P-id1 p q α (produ{I}{𝒜} x) = ⊧-P-lift-invar fe wd 𝒜  p q IH
  where
  IH : ∀ i → (Lift-alg (𝒜 i) 𝓤) ⊧ p ≈ q
  IH i = ⊧-Lift-invar wd  p q ((P-id1 p q α) (x i))

 P-id1 p q α (prodw{I}{𝒜} x) = ⊧-P-lift-invar fe wd 𝒜  p q IH
  where
  IH : ∀ i → (Lift-alg (𝒜 i) 𝓤) ⊧ p ≈ q
  IH i = ⊧-Lift-invar wd  p q ((P-id1 p q α) (x i))

 P-id1 p q α (pisou{𝑨}{𝑩} x y) = ⊧-I-invar wd 𝑩 p q (P-id1 p q α x) y
 P-id1 p q α (pisow{𝑨}{𝑩} x y) = ⊧-I-invar wd 𝑩 p q (P-id1 p q α x) y

\end{code}

...and conversely...

\begin{code}

module _  (wd : SwellDef){X : Type 𝓧} {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 P-id2 : ∀ {𝓦}(p q : Term X) → P{𝓦 = 𝓦} 𝒦 ⊧ p ≋ q → 𝒦 ⊧ p ≋ q
 P-id2 p q PKpq KA = ⊧-lower-invar wd p q (PKpq (pbase KA))

\end{code}


#### <a id="v-preserves-identities">V preserves identities</a>

Finally, we prove the analogous preservation lemmas for the closure operator `V`.

\begin{code}

module Vid (fe : DFunExt)(wd : SwellDef){𝓤 𝓧 : Level} {X : Type 𝓧} {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 V-id1 : (p q : Term X) → 𝒦 ⊧ p ≋ q → V{𝓦 = 𝓤} 𝒦 ⊧ p ≋ q
 V-id1 p q α (vbase x) = ⊧-Lift-invar wd p q (α x)
 V-id1 p q α (vlift{𝑨} x) = ⊧-Lift-invar wd p q ((V-id1 p q α) x)
 V-id1 p q α (vliftw{𝑨} x) = ⊧-Lift-invar wd p q ((V-id1 p q α) x)

 V-id1 p q α (vhimg{𝑨}{𝑪}VA (𝑩 , ((φ , φh) , φE))) b = γ
  where
  IH : 𝑨 ⊧ p ≈ q
  IH = V-id1 p q α VA

  preim : X → ∣ 𝑨 ∣
  preim x = Inv φ (φE (b x))

  ζ : ∀ x → φ (preim x) ≡ b x
  ζ x = InvIsInv φ (φE (b x))

  γ : (𝑩 ⟦ p ⟧) b ≡ (𝑩 ⟦ q ⟧) b
  γ = (𝑩 ⟦ p ⟧) b          ≡⟨ wd 𝓧 𝓤 (𝑩 ⟦ p ⟧) b (φ ∘ preim )(λ i → (ζ i)⁻¹)⟩
      (𝑩 ⟦ p ⟧)(φ ∘ preim) ≡⟨(comm-hom-term (wd 𝓥 𝓤) 𝑩 (φ , φh) p preim)⁻¹ ⟩
      φ((𝑨 ⟦ p ⟧) preim)   ≡⟨ cong φ (IH preim) ⟩
      φ((𝑨 ⟦ q ⟧) preim)   ≡⟨ comm-hom-term (wd 𝓥 𝓤) 𝑩 (φ , φh) q preim ⟩
      (𝑩 ⟦ q ⟧)(φ ∘ preim) ≡⟨ wd 𝓧 𝓤 (𝑩 ⟦ q ⟧)(φ ∘ preim) b ζ ⟩
      (𝑩 ⟦ q ⟧) b          ∎

 V-id1 p q α (vssub {𝑨}{𝑩} VA B≤A) = ⊧-S-class-invar wd p q γ (𝑩 , 𝑨 , (𝑩 , B≤A) , inj₂ refl , ≅-refl)
   where
   IH : 𝑨 ⊧ p ≈ q
   IH = V-id1 p q α VA

   Asinglepq : ｛ 𝑨 ｝ ⊧ p ≋ q
   Asinglepq refl = IH

   γ : (𝒦 ∪ ｛ 𝑨 ｝) ⊧ p ≋ q
   γ {𝑩} (inj₁ x) = α x
   γ {𝑩} (inj₂ y) = Asinglepq y

 V-id1 p q α ( vssubw {𝑨}{𝑩} VA B≤A ) =
  ⊧-S-class-invar wd p q γ (𝑩 , 𝑨 , (𝑩 , B≤A) , inj₂ refl , ≅-refl)
   where
   IH : 𝑨 ⊧ p ≈ q
   IH = V-id1 p q α VA

   Asinglepq : ｛ 𝑨 ｝ ⊧ p ≋ q
   Asinglepq refl = IH

   γ : (𝒦 ∪ ｛ 𝑨 ｝) ⊧ p ≋ q
   γ {𝑩} (inj₁ x) = α x
   γ {𝑩} (inj₂ y) = Asinglepq y

 V-id1 p q α (vprodu{I}{𝒜} V𝒜) = ⊧-P-invar fe wd 𝒜  p q λ i → V-id1 p q α (V𝒜 i)
 V-id1 p q α (vprodw{I}{𝒜} V𝒜) = ⊧-P-invar fe wd 𝒜  p q λ i → V-id1 p q α (V𝒜 i)
 V-id1 p q α (visou{𝑨}{𝑩} VA A≅B) = ⊧-I-invar wd 𝑩 p q (V-id1 p q α VA) A≅B
 V-id1 p q α (visow{𝑨}{𝑩} VA A≅B) = ⊧-I-invar wd 𝑩 p q (V-id1 p q α VA) A≅B

module Vid' (fe : DFunExt)(wd : SwellDef){𝓤 𝓧 : Level} {X : Type 𝓧} {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 open Vid fe wd {𝓤}{𝓧}{X}{𝒦} public
 V-id1' : {𝓦 : Level}(p q : Term X) → 𝒦 ⊧ p ≋ q → V{𝓦 = 𝓦} 𝒦 ⊧ p ≋ q
 V-id1' p q α (vbase x) = ⊧-Lift-invar wd p q (α x)
 V-id1' p q α (vlift{𝑨} x) = ⊧-Lift-invar wd p q ((V-id1 p q α) x)
 V-id1' p q α (vliftw{𝑨} x) = ⊧-Lift-invar wd p q ((V-id1' p q α) x)
 V-id1' {𝓦} p q α (vhimg{𝑨}{𝑪} VA (𝑩 , ((φ , φh) , φE))) b = γ
  where
  IH : 𝑨 ⊧ p ≈ q
  IH = V-id1' p q α VA

  preim : X → ∣ 𝑨 ∣
  preim x = Inv φ (φE (b x))

  ζ : ∀ x → φ (preim x) ≡ b x
  ζ x = InvIsInv φ (φE (b x))

  γ : (𝑩 ⟦ p ⟧) b ≡ (𝑩 ⟦ q ⟧) b
  γ = (𝑩 ⟦ p ⟧) b          ≡⟨ wd 𝓧 (𝓤 ⊔ 𝓦) (𝑩 ⟦ p ⟧) b (φ ∘ preim )(λ i → (ζ i)⁻¹)⟩
      (𝑩 ⟦ p ⟧)(φ ∘ preim) ≡⟨(comm-hom-term (wd 𝓥 (𝓤 ⊔ 𝓦)) 𝑩 (φ , φh) p preim)⁻¹ ⟩
      φ((𝑨 ⟦ p ⟧) preim)   ≡⟨ cong φ (IH preim) ⟩
      φ((𝑨 ⟦ q ⟧) preim)   ≡⟨ comm-hom-term (wd 𝓥 (𝓤 ⊔ 𝓦)) 𝑩 (φ , φh) q preim ⟩
      (𝑩 ⟦ q ⟧)(φ ∘ preim) ≡⟨ wd 𝓧 (𝓤 ⊔ 𝓦) (𝑩 ⟦ q ⟧)(φ ∘ preim) b ζ ⟩
      (𝑩 ⟦ q ⟧) b          ∎

 V-id1' p q α (vssub{𝑨}{𝑩} VA B≤A) = ⊧-S-invar wd 𝑩 {p}{q}(V-id1 p q α VA) B≤A
 V-id1' p q α (vssubw {𝑨}{𝑩} VA B≤A) = ⊧-S-invar wd 𝑩 {p}{q}(V-id1' p q α VA) B≤A
 V-id1' p q α (vprodu{I}{𝒜} V𝒜) = ⊧-P-invar fe wd 𝒜  p q λ i → V-id1 p q α (V𝒜 i)
 V-id1' p q α (vprodw{I}{𝒜} V𝒜) = ⊧-P-invar fe wd 𝒜  p q λ i → V-id1' p q α (V𝒜 i)
 V-id1' p q α (visou {𝑨}{𝑩} VA A≅B) = ⊧-I-invar wd 𝑩 p q (V-id1 p q α VA) A≅B
 V-id1' p q α (visow{𝑨}{𝑩} VA A≅B) = ⊧-I-invar wd 𝑩 p q (V-id1' p q α VA)A≅B

\end{code}


#### <a id="class-identities">Class identities</a>

From `V-id1` it follows that if 𝒦 is a class of structures, then the set of identities modeled by all structures in `𝒦` is equivalent to the set of identities modeled by all structures in `V 𝒦`.  In other terms, `Th (V 𝒦)` is precisely the set of identities modeled by `𝒦`.   We formalize this observation as follows.

\begin{code}

module _ (fe : DFunExt)(wd : SwellDef){𝓤 𝓧 : Level} {X : Type 𝓧} {𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 ovu lovu : Level
 ovu = ov 𝓤
 lovu = lsuc (ov 𝓤)
 𝕍 : Pred (Algebra lovu 𝑆) (lsuc lovu)
 𝕍 = V{𝓤}{lovu} 𝒦
 𝒱 : Pred (Algebra ovu 𝑆) lovu
 𝒱 = V{𝓦 = ovu} 𝒦

 open Vid' fe wd {𝓤}{𝓧}{X}{𝒦} public
 class-ids-⇒ : (p q : ∣ 𝑻 X ∣) → 𝒦 ⊧ p ≋ q  →  (p , q) ∈ Th 𝒱
 class-ids-⇒ p q pKq VCloA = V-id1' p q pKq VCloA

 class-ids : (p q : ∣ 𝑻 X ∣) → 𝒦 ⊧ p ≋ q  →  (p , q) ∈ Th 𝕍
 class-ids p q pKq VCloA = V-id1' p q pKq VCloA


 class-ids-⇐ : (p q : ∣ 𝑻 X ∣) → (p , q) ∈ Th 𝒱 →  𝒦 ⊧ p ≋ q
 class-ids-⇐ p q Thpq {𝑨} KA = ⊧-lower-invar wd p q (Thpq (vbase KA))

\end{code}


Once again, for completeness we formalize the coverse of `V-id1`, however obvious it may be.

\begin{code}

module _ (wd : SwellDef) {𝓦 : Level}{X : Type 𝓧}{𝒦 : Pred (Algebra 𝓤 𝑆)(ov 𝓤)} where

 V-id2 : (p q : Term X) → (V{𝓦 = 𝓦} 𝒦 ⊧ p ≋ q) → (𝒦 ⊧ p ≋ q)
 V-id2 p q Vpq {𝑨} KA = ⊧-lower-invar wd p q (Vpq (vbase KA))

\end{code}


----------------------------

[← Varieties.Varieties](Varieties.Varieties.html)
<span style="float:right;">[FreeAlgebras →](Varieties.FreeAlgebras.html)</span>

{% include UALib.Links.md %}





<!-- UNUSED STUFF

class-identities : (p q : ∣ 𝑻 X ∣) → 𝒦 ⊧ p ≋ q  ⇔  ((p , q) ∈ Th 𝒱)
class-identities p q = class-ids-⇒ p q , class-ids-⇐ p q

-->
