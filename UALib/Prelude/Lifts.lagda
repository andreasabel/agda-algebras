---
layout: default
title : Prelude.Lifts module (Agda Universal Algebra Library)
date : 2021-02-18
author: William DeMeo
---

### <a id="agdas-universe-hierarchy">Agda's Universe Hierarchy</a>

This section presents the [UALib.Prelude.Lifts][] module of the [Agda Universal Algebra Library][].

\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}

module Prelude.Lifts where

open import Prelude.Inverses public

\end{code}

#### <a id="agdas-universe-hierarchy">Agda's universe hierarchy</a>

The hierarchy of universes in Agda is structured as follows:

```agda
𝓤 ̇ : 𝓤 ⁺ ̇,   𝓤 ⁺ ̇ : 𝓤 ⁺ ⁺ ̇,  etc.
```

This means that the universe `𝓤 ̇` has type `𝓤 ⁺ ̇`, and  `𝓤 ⁺ ̇` has type  `𝓤 ⁺ ⁺ ̇`, and so on.  It is important to note, however, this does *not* imply that  `𝓤 ̇ : 𝓤 ⁺ ⁺ ̇`. In other words, Agda's universe hierarchy is *noncummulative*. This makes it possible to treat universe levels more generally and precisely, which is nice. On the other hand, a noncummulative hierarchy can sometimes make for a nonfun proof assistant. Specifically, in certain situations, the noncummulativity makes it unduly difficult to convince Agda that a program or proof is correct.

Presently, we will describe general lifting and lowering functions that help us overcome this technical issue. Later (in the [Lifts of Algebras](Algebras.Algebras.html#lifts-of-algebras) section) we provide some domain-specific analogs of these tools. We will prove some nice properties that make these effective mechanisms for resolving universe level problems when working with algebra types.

#### <a id="lifting-and-lowering">Lifting and lowering</a>

Let us be more concrete about what is at issue here by considering a typical example. Agda will often complain with errors like the following:

<samp>
Birkhoff.lagda:498,20-23 <br>
𝓤 != 𝓞 ⊔ 𝓥 ⊔ (𝓤 ⁺) when checking that the expression... has type...
</samp>

This error message means that Agda encountered the universe level `𝓤 ⁺`, on line 498 (columns 20--23) of the file `Birkhoff.lagda`, but was expecting a type at level `𝓞 ⁺ ⊔ 𝓥 ⁺ ⊔ 𝓤 ⁺ ⁺` instead.

There are some general "lifting and lowering" tools that make these situations easier to deal with. These must be applied with some care to avoid making the type theory inconsistent. In particular, we cannot lower the level of a type unless it was previously lifted to a (higher than necessary) universe level.

A general `Lift` record type, similar to the one found in the `Level` module of the [Agda Standard Library][], is defined as follows.

\begin{code}

record Lift {𝓦 𝓤 : Universe} (A : 𝓤 ̇) : 𝓤 ⊔ 𝓦 ̇  where
 constructor lift
 field lower : A
open Lift

\end{code}

The point of having a ramified hierarchy of universes is to avoid Russell's paradox, and this would be subverted if we were to lower the universe of a type that wasn't previously lifted.  However, we can prove that if an application of `lower` is immediately followed by an application of `lift`, then the result is the identity transformation. Similarly, `lift` followed by `lower` is the identity.

\begin{code}

lift∼lower : {𝓦 𝓤 : Universe}{A : 𝓤 ̇} → lift ∘ lower ≡ 𝑖𝑑 (Lift{𝓦} A)
lift∼lower = refl

lower∼lift : {𝓦 𝓤 : Universe}{A : 𝓤 ̇} → lower{𝓦}{𝓤} ∘ lift ≡ 𝑖𝑑 A
lower∼lift = refl

\end{code}

The proofs are trivial. Nonetheless, we'll find a few holes that these observations can fill.

---------------

<p></p>

[← Prelude.Inverses](Prelude.Inverses.html)
<span style="float:right;">[Relations →](Relations.html)</span>

{% include UALib.Links.md %}
