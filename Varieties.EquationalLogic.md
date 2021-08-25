---
layout: default
title : Varieties.EquationalLogic module (The Agda Universal Algebra Library)
date : 2021-01-14
author: [agda-algebras development team][]
---

### <a id="varieties-model-theory-and-equational-logic">Varieties, Model Theory, and Equational Logic</a>

This is the [Varieties.EquationalLogic][] module of the [Agda Universal Algebra Library][] where the binary "models" relation ⊧, relating algebras (or classes of algebras) to the identities that they satisfy, is defined.

Let 𝑆 be a signature. By an **identity** or **equation** in 𝑆 we mean an ordered pair of terms, written 𝑝 ≈ 𝑞, from the term algebra 𝑻 X. If 𝑨 is an 𝑆-algebra we say that 𝑨 **satisfies** 𝑝 ≈ 𝑞 provided 𝑝 ̇ 𝑨 ≡ 𝑞 ̇ 𝑨 holds. In this situation, we write 𝑨 ⊧ 𝑝 ≈ 𝑞 and say that 𝑨 **models** the identity 𝑝 ≈ q. If 𝒦 is a class of algebras, all of the same signature, we write 𝒦 ⊧ p ≈ q if, for every 𝑨 ∈ 𝒦, 𝑨 ⊧ 𝑝 ≈ 𝑞.

Because a class of structures has a different type than a single structure, we must use a slightly different syntax to avoid overloading the relations ⊧ and ≈. As a reasonable alternative to what we would normally express informally as 𝒦 ⊧ 𝑝 ≈ 𝑞, we have settled on 𝒦 ⊫ p ≈ q to denote this relation.  To reiterate, if 𝒦 is a class of 𝑆-algebras, we write 𝒦 ⊫ 𝑝 ≈ 𝑞 if every 𝑨 ∈ 𝒦 satisfies 𝑨 ⊧ 𝑝 ≈ 𝑞.

<pre class="Agda">

<a id="1326" class="Symbol">{-#</a> <a id="1330" class="Keyword">OPTIONS</a> <a id="1338" class="Pragma">--without-K</a> <a id="1350" class="Pragma">--exact-split</a> <a id="1364" class="Pragma">--safe</a> <a id="1371" class="Symbol">#-}</a>


<a id="1377" class="Keyword">open</a> <a id="1382" class="Keyword">import</a> <a id="1389" href="Algebras.Basic.html" class="Module">Algebras.Basic</a> <a id="1404" class="Keyword">using</a> <a id="1410" class="Symbol">(</a> <a id="1412" href="Algebras.Basic.html#1155" class="Generalizable">𝓞</a> <a id="1414" class="Symbol">;</a> <a id="1416" href="Algebras.Basic.html#1157" class="Generalizable">𝓥</a> <a id="1418" class="Symbol">;</a> <a id="1420" href="Algebras.Basic.html#3581" class="Function">Signature</a> <a id="1430" class="Symbol">)</a>

<a id="1433" class="Keyword">module</a> <a id="1440" href="Varieties.EquationalLogic.html" class="Module">Varieties.EquationalLogic</a> <a id="1466" class="Symbol">{</a><a id="1467" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a> <a id="1469" class="Symbol">:</a> <a id="1471" href="Algebras.Basic.html#3581" class="Function">Signature</a> <a id="1481" href="Algebras.Basic.html#1155" class="Generalizable">𝓞</a> <a id="1483" href="Algebras.Basic.html#1157" class="Generalizable">𝓥</a><a id="1484" class="Symbol">}</a> <a id="1486" class="Keyword">where</a>

<a id="1493" class="Comment">-- imports from Agda and the Agda Standard Library -------------------------------------------</a>
<a id="1588" class="Keyword">open</a> <a id="1593" class="Keyword">import</a> <a id="1600" href="Agda.Primitive.html" class="Module">Agda.Primitive</a> <a id="1615" class="Keyword">using</a> <a id="1621" class="Symbol">(</a> <a id="1623" href="Agda.Primitive.html#810" class="Primitive Operator">_⊔_</a> <a id="1627" class="Symbol">;</a>  <a id="1630" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="1635" class="Symbol">;</a> <a id="1637" href="Agda.Primitive.html#597" class="Postulate">Level</a> <a id="1643" class="Symbol">)</a> <a id="1645" class="Keyword">renaming</a> <a id="1654" class="Symbol">(</a> <a id="1656" href="Agda.Primitive.html#326" class="Primitive">Set</a> <a id="1660" class="Symbol">to</a> <a id="1663" class="Primitive">Type</a> <a id="1668" class="Symbol">)</a>
<a id="1670" class="Keyword">open</a> <a id="1675" class="Keyword">import</a> <a id="1682" href="Data.Product.html" class="Module">Data.Product</a>   <a id="1697" class="Keyword">using</a> <a id="1703" class="Symbol">(</a> <a id="1705" href="Data.Product.html#1167" class="Function Operator">_×_</a> <a id="1709" class="Symbol">;</a> <a id="1711" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">_,_</a> <a id="1715" class="Symbol">;</a> <a id="1717" href="Data.Product.html#916" class="Function">Σ-syntax</a><a id="1725" class="Symbol">)</a> <a id="1727" class="Keyword">renaming</a> <a id="1736" class="Symbol">(</a> <a id="1738" href="Agda.Builtin.Sigma.html#252" class="Field">proj₁</a> <a id="1744" class="Symbol">to</a> <a id="1747" class="Field">fst</a> <a id="1751" class="Symbol">;</a> <a id="1753" href="Agda.Builtin.Sigma.html#264" class="Field">proj₂</a> <a id="1759" class="Symbol">to</a> <a id="1762" class="Field">snd</a> <a id="1766" class="Symbol">)</a>
<a id="1768" class="Keyword">open</a> <a id="1773" class="Keyword">import</a> <a id="1780" href="Relation.Unary.html" class="Module">Relation.Unary</a> <a id="1795" class="Keyword">using</a> <a id="1801" class="Symbol">(</a> <a id="1803" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="1808" class="Symbol">;</a> <a id="1810" href="Relation.Unary.html#1523" class="Function Operator">_∈_</a> <a id="1814" class="Symbol">)</a>

<a id="1817" class="Comment">-- imports from agda-algebras --------------------------------------------------------------</a>
<a id="1910" class="Keyword">open</a> <a id="1915" class="Keyword">import</a> <a id="1922" href="Overture.Preliminaries.html" class="Module">Overture.Preliminaries</a>    <a id="1948" class="Keyword">using</a> <a id="1954" class="Symbol">(</a> <a id="1956" href="Overture.Preliminaries.html#9370" class="Function Operator">_≈_</a> <a id="1960" class="Symbol">)</a>
<a id="1962" class="Keyword">open</a> <a id="1967" class="Keyword">import</a> <a id="1974" href="Algebras.Basic.html" class="Module">Algebras.Basic</a>            <a id="2000" class="Keyword">using</a> <a id="2006" class="Symbol">(</a> <a id="2008" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="2016" class="Symbol">)</a>
<a id="2018" class="Keyword">open</a> <a id="2023" class="Keyword">import</a> <a id="2030" href="Algebras.Products.html" class="Module">Algebras.Products</a> <a id="2048" class="Symbol">{</a><a id="2049" class="Argument">𝑆</a> <a id="2051" class="Symbol">=</a> <a id="2053" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="2054" class="Symbol">}</a> <a id="2056" class="Keyword">using</a> <a id="2062" class="Symbol">(</a> <a id="2064" href="Algebras.Products.html#3004" class="Function">ov</a> <a id="2067" class="Symbol">)</a>
<a id="2069" class="Keyword">open</a> <a id="2074" class="Keyword">import</a> <a id="2081" href="Terms.Basic.html" class="Module">Terms.Basic</a>       <a id="2099" class="Symbol">{</a><a id="2100" class="Argument">𝑆</a> <a id="2102" class="Symbol">=</a> <a id="2104" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="2105" class="Symbol">}</a> <a id="2107" class="Keyword">using</a> <a id="2113" class="Symbol">(</a> <a id="2115" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="2120" class="Symbol">;</a> <a id="2122" href="Terms.Basic.html#3125" class="Function">𝑻</a> <a id="2124" class="Symbol">)</a>
<a id="2126" class="Keyword">open</a> <a id="2131" class="Keyword">import</a> <a id="2138" href="Terms.Operations.html" class="Module">Terms.Operations</a>  <a id="2156" class="Symbol">{</a><a id="2157" class="Argument">𝑆</a> <a id="2159" class="Symbol">=</a> <a id="2161" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="2162" class="Symbol">}</a> <a id="2164" class="Keyword">using</a> <a id="2170" class="Symbol">(</a> <a id="2172" href="Terms.Operations.html#2527" class="Function Operator">_⟦_⟧</a> <a id="2177" class="Symbol">)</a>

<a id="2180" class="Keyword">private</a> <a id="2188" class="Keyword">variable</a> <a id="2197" href="Varieties.EquationalLogic.html#2197" class="Generalizable">χ</a> <a id="2199" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a> <a id="2201" href="Varieties.EquationalLogic.html#2201" class="Generalizable">ρ</a> <a id="2203" href="Varieties.EquationalLogic.html#2203" class="Generalizable">ι</a> <a id="2205" class="Symbol">:</a> <a id="2207" href="Agda.Primitive.html#597" class="Postulate">Level</a>
                 <a id="2230" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="2232" class="Symbol">:</a> <a id="2234" href="Varieties.EquationalLogic.html#1663" class="Primitive">Type</a> <a id="2239" href="Varieties.EquationalLogic.html#2197" class="Generalizable">χ</a>

</pre>


#### <a id="the-models-relation">The models relation</a>

We define the binary "models" relation `⊧` using infix syntax so that we may
write, e.g., `𝑨 ⊧ p ≈ q` or `𝒦 ⊫ p ≈ q`, relating algebras (or classes of
algebras) to the identities that they satisfy. We also prove a couple of useful
facts about ⊧.  More will be proved about ⊧ in the next module,
Varieties.EquationalLogic.

<pre class="Agda">

<a id="_⊧_≈_"></a><a id="2650" href="Varieties.EquationalLogic.html#2650" class="Function Operator">_⊧_≈_</a> <a id="2656" class="Symbol">:</a> <a id="2658" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="2666" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a> <a id="2668" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a> <a id="2670" class="Symbol">→</a> <a id="2672" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="2677" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="2679" class="Symbol">→</a> <a id="2681" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="2686" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="2688" class="Symbol">→</a> <a id="2690" href="Varieties.EquationalLogic.html#1663" class="Primitive">Type</a> <a id="2695" class="Symbol">_</a>
<a id="2697" href="Varieties.EquationalLogic.html#2697" class="Bound">𝑨</a> <a id="2699" href="Varieties.EquationalLogic.html#2650" class="Function Operator">⊧</a> <a id="2701" href="Varieties.EquationalLogic.html#2701" class="Bound">p</a> <a id="2703" href="Varieties.EquationalLogic.html#2650" class="Function Operator">≈</a> <a id="2705" href="Varieties.EquationalLogic.html#2705" class="Bound">q</a> <a id="2707" class="Symbol">=</a> <a id="2709" href="Varieties.EquationalLogic.html#2697" class="Bound">𝑨</a> <a id="2711" href="Terms.Operations.html#2527" class="Function Operator">⟦</a> <a id="2713" href="Varieties.EquationalLogic.html#2701" class="Bound">p</a> <a id="2715" href="Terms.Operations.html#2527" class="Function Operator">⟧</a> <a id="2717" href="Overture.Preliminaries.html#9370" class="Function Operator">≈</a> <a id="2719" href="Varieties.EquationalLogic.html#2697" class="Bound">𝑨</a> <a id="2721" href="Terms.Operations.html#2527" class="Function Operator">⟦</a> <a id="2723" href="Varieties.EquationalLogic.html#2705" class="Bound">q</a> <a id="2725" href="Terms.Operations.html#2527" class="Function Operator">⟧</a>

<a id="_⊫_≈_"></a><a id="2728" href="Varieties.EquationalLogic.html#2728" class="Function Operator">_⊫_≈_</a> <a id="2734" class="Symbol">:</a> <a id="2736" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="2740" class="Symbol">(</a><a id="2741" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="2749" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a> <a id="2751" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="2752" class="Symbol">)</a> <a id="2754" href="Varieties.EquationalLogic.html#2201" class="Generalizable">ρ</a> <a id="2756" class="Symbol">→</a> <a id="2758" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="2763" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="2765" class="Symbol">→</a> <a id="2767" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="2772" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="2774" class="Symbol">→</a> <a id="2776" href="Varieties.EquationalLogic.html#1663" class="Primitive">Type</a> <a id="2781" class="Symbol">_</a>
<a id="2783" href="Varieties.EquationalLogic.html#2783" class="Bound">𝒦</a> <a id="2785" href="Varieties.EquationalLogic.html#2728" class="Function Operator">⊫</a> <a id="2787" href="Varieties.EquationalLogic.html#2787" class="Bound">p</a> <a id="2789" href="Varieties.EquationalLogic.html#2728" class="Function Operator">≈</a> <a id="2791" href="Varieties.EquationalLogic.html#2791" class="Bound">q</a> <a id="2793" class="Symbol">=</a> <a id="2795" class="Symbol">{</a><a id="2796" href="Varieties.EquationalLogic.html#2796" class="Bound">𝑨</a> <a id="2798" class="Symbol">:</a> <a id="2800" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="2808" class="Symbol">_</a> <a id="2810" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="2811" class="Symbol">}</a> <a id="2813" class="Symbol">→</a> <a id="2815" href="Varieties.EquationalLogic.html#2783" class="Bound">𝒦</a> <a id="2817" href="Varieties.EquationalLogic.html#2796" class="Bound">𝑨</a> <a id="2819" class="Symbol">→</a> <a id="2821" href="Varieties.EquationalLogic.html#2796" class="Bound">𝑨</a> <a id="2823" href="Varieties.EquationalLogic.html#2650" class="Function Operator">⊧</a> <a id="2825" href="Varieties.EquationalLogic.html#2787" class="Bound">p</a> <a id="2827" href="Varieties.EquationalLogic.html#2650" class="Function Operator">≈</a> <a id="2829" href="Varieties.EquationalLogic.html#2791" class="Bound">q</a>

</pre>

The expression `𝑨 ⊧ p ≈ q` represents the assertion that the identity `p ≈ q`
holds when interpreted in the algebra `𝑨`; syntactically, `𝑨 ⟦ p ⟧ ≈ 𝑨 ⟦ q ⟧`.

The expression `𝑨 ⟦ p ⟧ ≈ 𝑨 ⟦ q ⟧` denotes *extensional equality*; that is,
for each "environment" `η :  X → ∣ 𝑨 ∣` (assigning values in the domain of `𝑨`
to the variable symbols in `X`) the (intensional) equality `𝑨 ⟦ p ⟧ η ≡ 𝑨 ⟦ q ⟧ η`
holds.


#### <a id="equational-theories-and-models">Equational theories and models</a>

If 𝒦 denotes a class of structures, then `Th 𝒦` represents the set of identities
modeled by the members of 𝒦.

<pre class="Agda">

<a id="Th"></a><a id="3454" href="Varieties.EquationalLogic.html#3454" class="Function">Th</a> <a id="3457" class="Symbol">:</a> <a id="3459" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="3464" class="Symbol">(</a><a id="3465" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="3473" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a> <a id="3475" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="3476" class="Symbol">)</a> <a id="3478" class="Symbol">(</a><a id="3479" href="Algebras.Products.html#3004" class="Function">ov</a> <a id="3482" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a><a id="3483" class="Symbol">)</a> <a id="3485" class="Symbol">→</a> <a id="3487" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="3491" class="Symbol">(</a><a id="3492" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="3497" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="3499" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="3501" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="3506" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a><a id="3507" class="Symbol">)</a> <a id="3509" class="Symbol">_</a>
<a id="3511" href="Varieties.EquationalLogic.html#3454" class="Function">Th</a> <a id="3514" href="Varieties.EquationalLogic.html#3514" class="Bound">𝒦</a> <a id="3516" class="Symbol">=</a> <a id="3518" class="Symbol">λ</a> <a id="3520" class="Symbol">(</a><a id="3521" href="Varieties.EquationalLogic.html#3521" class="Bound">p</a> <a id="3523" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3525" href="Varieties.EquationalLogic.html#3525" class="Bound">q</a><a id="3526" class="Symbol">)</a> <a id="3528" class="Symbol">→</a> <a id="3530" href="Varieties.EquationalLogic.html#3514" class="Bound">𝒦</a> <a id="3532" href="Varieties.EquationalLogic.html#2728" class="Function Operator">⊫</a> <a id="3534" href="Varieties.EquationalLogic.html#3521" class="Bound">p</a> <a id="3536" href="Varieties.EquationalLogic.html#2728" class="Function Operator">≈</a> <a id="3538" href="Varieties.EquationalLogic.html#3525" class="Bound">q</a>

</pre>

Perhaps we want to represent Th 𝒦 as an indexed collection.  We do so
essentially by taking `Th 𝒦` itself to be the index set, as follows.

<pre class="Agda">

<a id="3707" class="Keyword">module</a> <a id="3714" href="Varieties.EquationalLogic.html#3714" class="Module">_</a> <a id="3716" class="Symbol">{</a><a id="3717" href="Varieties.EquationalLogic.html#3717" class="Bound">X</a> <a id="3719" class="Symbol">:</a> <a id="3721" href="Varieties.EquationalLogic.html#1663" class="Primitive">Type</a> <a id="3726" href="Varieties.EquationalLogic.html#2197" class="Generalizable">χ</a><a id="3727" class="Symbol">}{</a><a id="3729" href="Varieties.EquationalLogic.html#3729" class="Bound">𝒦</a> <a id="3731" class="Symbol">:</a> <a id="3733" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="3738" class="Symbol">(</a><a id="3739" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="3747" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a> <a id="3749" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="3750" class="Symbol">)</a> <a id="3752" class="Symbol">(</a><a id="3753" href="Algebras.Products.html#3004" class="Function">ov</a> <a id="3756" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a><a id="3757" class="Symbol">)}</a> <a id="3760" class="Keyword">where</a>

 <a id="3768" href="Varieties.EquationalLogic.html#3768" class="Function">ℐ</a> <a id="3770" class="Symbol">:</a> <a id="3772" href="Varieties.EquationalLogic.html#1663" class="Primitive">Type</a> <a id="3777" class="Symbol">(</a><a id="3778" href="Algebras.Products.html#3004" class="Function">ov</a><a id="3780" class="Symbol">(</a><a id="3781" href="Varieties.EquationalLogic.html#3747" class="Bound">α</a> <a id="3783" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="3785" href="Varieties.EquationalLogic.html#3726" class="Bound">χ</a><a id="3786" class="Symbol">))</a>
 <a id="3790" href="Varieties.EquationalLogic.html#3768" class="Function">ℐ</a> <a id="3792" class="Symbol">=</a> <a id="3794" href="Data.Product.html#916" class="Function">Σ[</a> <a id="3797" href="Varieties.EquationalLogic.html#3797" class="Bound">(</a><a id="3798" href="Varieties.EquationalLogic.html#3798" class="Bound">p</a> <a id="3800" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3802" href="Varieties.EquationalLogic.html#3802" class="Bound">q</a><a id="3803" href="Varieties.EquationalLogic.html#3797" class="Bound">)</a> <a id="3805" href="Data.Product.html#916" class="Function">∈</a> <a id="3807" class="Symbol">(</a><a id="3808" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="3813" href="Varieties.EquationalLogic.html#3717" class="Bound">X</a> <a id="3815" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="3817" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="3822" href="Varieties.EquationalLogic.html#3717" class="Bound">X</a><a id="3823" class="Symbol">)</a> <a id="3825" href="Data.Product.html#916" class="Function">]</a> <a id="3827" href="Varieties.EquationalLogic.html#3729" class="Bound">𝒦</a> <a id="3829" href="Varieties.EquationalLogic.html#2728" class="Function Operator">⊫</a> <a id="3831" href="Varieties.EquationalLogic.html#3798" class="Bound">p</a> <a id="3833" href="Varieties.EquationalLogic.html#2728" class="Function Operator">≈</a> <a id="3835" href="Varieties.EquationalLogic.html#3802" class="Bound">q</a>

 <a id="3839" href="Varieties.EquationalLogic.html#3839" class="Function">ℰ</a> <a id="3841" class="Symbol">:</a> <a id="3843" href="Varieties.EquationalLogic.html#3768" class="Function">ℐ</a> <a id="3845" class="Symbol">→</a> <a id="3847" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="3852" href="Varieties.EquationalLogic.html#3717" class="Bound">X</a> <a id="3854" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="3856" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="3861" href="Varieties.EquationalLogic.html#3717" class="Bound">X</a>
 <a id="3864" href="Varieties.EquationalLogic.html#3839" class="Function">ℰ</a> <a id="3866" class="Symbol">((</a><a id="3868" href="Varieties.EquationalLogic.html#3868" class="Bound">p</a> <a id="3870" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3872" href="Varieties.EquationalLogic.html#3872" class="Bound">q</a><a id="3873" class="Symbol">)</a> <a id="3875" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3877" class="Symbol">_)</a> <a id="3880" class="Symbol">=</a> <a id="3882" class="Symbol">(</a><a id="3883" href="Varieties.EquationalLogic.html#3868" class="Bound">p</a> <a id="3885" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3887" href="Varieties.EquationalLogic.html#3872" class="Bound">q</a><a id="3888" class="Symbol">)</a>


</pre>

If `ℰ` denotes a set of identities, then `Mod ℰ` is the class of structures
satisfying the identities in `ℰ`.

<pre class="Agda">

<a id="Mod"></a><a id="4029" href="Varieties.EquationalLogic.html#4029" class="Function">Mod</a> <a id="4033" class="Symbol">:</a> <a id="4035" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="4039" class="Symbol">(</a><a id="4040" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="4045" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="4047" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="4049" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="4054" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a><a id="4055" class="Symbol">)</a> <a id="4057" class="Symbol">(</a><a id="4058" href="Algebras.Products.html#3004" class="Function">ov</a> <a id="4061" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a><a id="4062" class="Symbol">)</a> <a id="4064" class="Symbol">→</a> <a id="4066" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="4070" class="Symbol">(</a><a id="4071" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="4079" href="Varieties.EquationalLogic.html#2199" class="Generalizable">α</a> <a id="4081" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="4082" class="Symbol">)</a> <a id="4084" class="Symbol">_</a>
<a id="4086" href="Varieties.EquationalLogic.html#4029" class="Function">Mod</a> <a id="4090" href="Varieties.EquationalLogic.html#4090" class="Bound">ℰ</a> <a id="4092" class="Symbol">=</a> <a id="4094" class="Symbol">λ</a> <a id="4096" href="Varieties.EquationalLogic.html#4096" class="Bound">𝑨</a> <a id="4098" class="Symbol">→</a> <a id="4100" class="Symbol">∀</a> <a id="4102" href="Varieties.EquationalLogic.html#4102" class="Bound">p</a> <a id="4104" href="Varieties.EquationalLogic.html#4104" class="Bound">q</a> <a id="4106" class="Symbol">→</a> <a id="4108" class="Symbol">(</a><a id="4109" href="Varieties.EquationalLogic.html#4102" class="Bound">p</a> <a id="4111" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="4113" href="Varieties.EquationalLogic.html#4104" class="Bound">q</a><a id="4114" class="Symbol">)</a> <a id="4116" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="4118" href="Varieties.EquationalLogic.html#4090" class="Bound">ℰ</a> <a id="4120" class="Symbol">→</a> <a id="4122" href="Varieties.EquationalLogic.html#4096" class="Bound">𝑨</a> <a id="4124" href="Varieties.EquationalLogic.html#2650" class="Function Operator">⊧</a> <a id="4126" href="Varieties.EquationalLogic.html#4102" class="Bound">p</a> <a id="4128" href="Varieties.EquationalLogic.html#2650" class="Function Operator">≈</a> <a id="4130" href="Varieties.EquationalLogic.html#4104" class="Bound">q</a>
<a id="4132" class="Comment">-- (tupled version)</a>
<a id="Modᵗ"></a><a id="4152" href="Varieties.EquationalLogic.html#4152" class="Function">Modᵗ</a> <a id="4157" class="Symbol">:</a> <a id="4159" class="Symbol">{</a><a id="4160" href="Varieties.EquationalLogic.html#4160" class="Bound">I</a> <a id="4162" class="Symbol">:</a> <a id="4164" href="Varieties.EquationalLogic.html#1663" class="Primitive">Type</a> <a id="4169" href="Varieties.EquationalLogic.html#2203" class="Generalizable">ι</a><a id="4170" class="Symbol">}</a> <a id="4172" class="Symbol">→</a> <a id="4174" class="Symbol">(</a><a id="4175" href="Varieties.EquationalLogic.html#4160" class="Bound">I</a> <a id="4177" class="Symbol">→</a> <a id="4179" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="4184" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a> <a id="4186" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="4188" href="Terms.Basic.html#1853" class="Datatype">Term</a> <a id="4193" href="Varieties.EquationalLogic.html#2230" class="Generalizable">X</a><a id="4194" class="Symbol">)</a> <a id="4196" class="Symbol">→</a> <a id="4198" class="Symbol">{</a><a id="4199" href="Varieties.EquationalLogic.html#4199" class="Bound">α</a> <a id="4201" class="Symbol">:</a> <a id="4203" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="4208" class="Symbol">}</a> <a id="4210" class="Symbol">→</a> <a id="4212" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="4216" class="Symbol">(</a><a id="4217" href="Algebras.Basic.html#6023" class="Function">Algebra</a> <a id="4225" href="Varieties.EquationalLogic.html#4199" class="Bound">α</a> <a id="4227" href="Varieties.EquationalLogic.html#1467" class="Bound">𝑆</a><a id="4228" class="Symbol">)</a> <a id="4230" class="Symbol">_</a>
<a id="4232" href="Varieties.EquationalLogic.html#4152" class="Function">Modᵗ</a> <a id="4237" href="Varieties.EquationalLogic.html#4237" class="Bound">ℰ</a> <a id="4239" class="Symbol">=</a> <a id="4241" class="Symbol">λ</a> <a id="4243" href="Varieties.EquationalLogic.html#4243" class="Bound">𝑨</a> <a id="4245" class="Symbol">→</a> <a id="4247" class="Symbol">∀</a> <a id="4249" href="Varieties.EquationalLogic.html#4249" class="Bound">i</a> <a id="4251" class="Symbol">→</a> <a id="4253" href="Varieties.EquationalLogic.html#4243" class="Bound">𝑨</a> <a id="4255" href="Varieties.EquationalLogic.html#2650" class="Function Operator">⊧</a> <a id="4257" class="Symbol">(</a><a id="4258" href="Varieties.EquationalLogic.html#1747" class="Field">fst</a> <a id="4262" class="Symbol">(</a><a id="4263" href="Varieties.EquationalLogic.html#4237" class="Bound">ℰ</a> <a id="4265" href="Varieties.EquationalLogic.html#4249" class="Bound">i</a><a id="4266" class="Symbol">))</a> <a id="4269" href="Varieties.EquationalLogic.html#2650" class="Function Operator">≈</a> <a id="4271" class="Symbol">(</a><a id="4272" href="Varieties.EquationalLogic.html#1762" class="Field">snd</a> <a id="4276" class="Symbol">(</a><a id="4277" href="Varieties.EquationalLogic.html#4237" class="Bound">ℰ</a> <a id="4279" href="Varieties.EquationalLogic.html#4249" class="Bound">i</a><a id="4280" class="Symbol">))</a>

</pre>

-------------------------------------

<br>

[↑ Varieties](Varieties.html)
<span style="float:right;">[Varieties.Closure →](Varieties.Closure.html)</span>

{% include UALib.Links.md %}


[agda-algebras development team]: https://github.com/ualib/agda-algebras#the-agda-algebras-development-team





<!--

  -- open import Relation.Binary.Core using (_⇔_)

  -- ⊧-H : DFunExt → {p q : Term X} → 𝒦 ⊫ p ≈ q ⇔ (∀ 𝑨 φ → 𝑨 ∈ 𝒦 → ∣ φ ∣ ∘ (𝑻 X ⟦ p ⟧) ≡ ∣ φ ∣ ∘(𝑻 X ⟦ q ⟧))
  -- ⊧-H fe {p}{q} = ⊧-H-class-invar fe {p}{q} , ⊧-H-class-coinvar fe {p}{q}


-->