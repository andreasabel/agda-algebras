---
layout: default
title : "Varieties.Invariants module (Agda Universal Algebra Library)"
date : "2021-06-29"
author: "the ualib/agda-algebras development team"
---

### Algebraic invariants

These are properties that are preserved under isomorphism.

<pre class="Agda">

<a id="268" class="Symbol">{-#</a> <a id="272" class="Keyword">OPTIONS</a> <a id="280" class="Pragma">--without-K</a> <a id="292" class="Pragma">--exact-split</a> <a id="306" class="Pragma">--safe</a> <a id="313" class="Symbol">#-}</a>

<a id="318" class="Keyword">open</a> <a id="323" class="Keyword">import</a> <a id="330" href="Algebras.Basic.html" class="Module">Algebras.Basic</a> <a id="345" class="Keyword">using</a> <a id="351" class="Symbol">(</a> <a id="353" href="Algebras.Basic.html#1130" class="Generalizable">𝓞</a> <a id="355" class="Symbol">;</a> <a id="357" href="Algebras.Basic.html#1132" class="Generalizable">𝓥</a> <a id="359" class="Symbol">;</a> <a id="361" href="Algebras.Basic.html#3858" class="Function">Signature</a> <a id="371" class="Symbol">;</a> <a id="373" href="Algebras.Basic.html#6222" class="Function">Algebra</a> <a id="381" class="Symbol">)</a>

<a id="384" class="Keyword">module</a> <a id="391" href="Varieties.Invariants.html" class="Module">Varieties.Invariants</a> <a id="412" class="Symbol">(</a><a id="413" href="Varieties.Invariants.html#413" class="Bound">𝑆</a> <a id="415" class="Symbol">:</a> <a id="417" href="Algebras.Basic.html#3858" class="Function">Signature</a> <a id="427" href="Algebras.Basic.html#1130" class="Generalizable">𝓞</a> <a id="429" href="Algebras.Basic.html#1132" class="Generalizable">𝓥</a><a id="430" class="Symbol">)</a> <a id="432" class="Keyword">where</a>

<a id="439" class="Comment">-- Imports from Agda and the Agda Standard Library ---------------------</a>
<a id="512" class="Keyword">open</a> <a id="517" class="Keyword">import</a> <a id="524" href="Agda.Primitive.html" class="Module">Agda.Primitive</a> <a id="539" class="Keyword">using</a> <a id="545" class="Symbol">(</a> <a id="547" href="Agda.Primitive.html#597" class="Postulate">Level</a> <a id="553" class="Symbol">)</a> <a id="555" class="Keyword">renaming</a> <a id="564" class="Symbol">(</a> <a id="566" href="Agda.Primitive.html#326" class="Primitive">Set</a> <a id="570" class="Symbol">to</a> <a id="573" class="Primitive">Type</a> <a id="578" class="Symbol">)</a>
<a id="580" class="Keyword">open</a> <a id="585" class="Keyword">import</a> <a id="592" href="Relation.Unary.html" class="Module">Relation.Unary</a> <a id="607" class="Keyword">using</a> <a id="613" class="Symbol">(</a> <a id="615" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="620" class="Symbol">)</a>

<a id="623" class="Comment">-- Imports from the Agda Universal Algebra Library -------------------------------------------</a>
<a id="718" class="Keyword">open</a> <a id="723" class="Keyword">import</a> <a id="730" href="Homomorphisms.Isomorphisms.html" class="Module">Homomorphisms.Isomorphisms</a> <a id="757" class="Symbol">{</a><a id="758" class="Argument">𝑆</a> <a id="760" class="Symbol">=</a> <a id="762" href="Varieties.Invariants.html#413" class="Bound">𝑆</a><a id="763" class="Symbol">}</a> <a id="765" class="Keyword">using</a> <a id="771" class="Symbol">(</a> <a id="773" href="Homomorphisms.Isomorphisms.html#2333" class="Record Operator">_≅_</a> <a id="777" class="Symbol">)</a>
<a id="779" class="Keyword">private</a> <a id="787" class="Keyword">variable</a> <a id="796" href="Varieties.Invariants.html#796" class="Generalizable">α</a> <a id="798" href="Varieties.Invariants.html#798" class="Generalizable">ℓ</a> <a id="800" class="Symbol">:</a> <a id="802" href="Agda.Primitive.html#597" class="Postulate">Level</a>

<a id="AlgebraicInvariant"></a><a id="809" href="Varieties.Invariants.html#809" class="Function">AlgebraicInvariant</a> <a id="828" class="Symbol">:</a> <a id="830" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="835" class="Symbol">(</a><a id="836" href="Algebras.Basic.html#6222" class="Function">Algebra</a> <a id="844" href="Varieties.Invariants.html#796" class="Generalizable">α</a> <a id="846" href="Varieties.Invariants.html#413" class="Bound">𝑆</a><a id="847" class="Symbol">)</a> <a id="849" href="Varieties.Invariants.html#798" class="Generalizable">ℓ</a> <a id="851" class="Symbol">→</a> <a id="853" href="Varieties.Invariants.html#573" class="Primitive">Type</a> <a id="858" class="Symbol">_</a>
<a id="860" href="Varieties.Invariants.html#809" class="Function">AlgebraicInvariant</a> <a id="879" href="Varieties.Invariants.html#879" class="Bound">P</a> <a id="881" class="Symbol">=</a> <a id="883" class="Symbol">∀</a> <a id="885" href="Varieties.Invariants.html#885" class="Bound">𝑨</a> <a id="887" href="Varieties.Invariants.html#887" class="Bound">𝑩</a> <a id="889" class="Symbol">→</a> <a id="891" href="Varieties.Invariants.html#879" class="Bound">P</a> <a id="893" href="Varieties.Invariants.html#885" class="Bound">𝑨</a> <a id="895" class="Symbol">→</a> <a id="897" href="Varieties.Invariants.html#885" class="Bound">𝑨</a> <a id="899" href="Homomorphisms.Isomorphisms.html#2333" class="Record Operator">≅</a> <a id="901" href="Varieties.Invariants.html#887" class="Bound">𝑩</a> <a id="903" class="Symbol">→</a> <a id="905" href="Varieties.Invariants.html#879" class="Bound">P</a> <a id="907" href="Varieties.Invariants.html#887" class="Bound">𝑩</a>

</pre>

--------------------------------

{% include UALib.Links.md %}
