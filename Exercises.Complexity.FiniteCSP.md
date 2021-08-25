---
layout: default
title : Exercises.Complexity.FiniteCSP module (The Agda Universal Algebra Library)
date : 2021-07-26
author: [agda-algebras development team][] and Libor Barto⁺
---

⁺All excercises below were made by Libor Barto (for students at Charles University), and formalized in MLTT/Agda by the [agda-algebras development team][].

### CSP Exercises

<pre class="Agda">

<a id="377" class="Symbol">{-#</a> <a id="381" class="Keyword">OPTIONS</a> <a id="389" class="Pragma">--without-K</a> <a id="401" class="Pragma">--exact-split</a> <a id="415" class="Pragma">--safe</a> <a id="422" class="Symbol">#-}</a>

<a id="427" class="Keyword">module</a> <a id="434" href="Exercises.Complexity.FiniteCSP.html" class="Module">Exercises.Complexity.FiniteCSP</a>  <a id="466" class="Keyword">where</a>


<a id="474" class="Keyword">open</a> <a id="479" class="Keyword">import</a> <a id="486" href="Agda.Primitive.html" class="Module">Agda.Primitive</a>  <a id="502" class="Keyword">using</a> <a id="508" class="Symbol">(</a> <a id="510" class="Symbol">)</a> <a id="512" class="Keyword">renaming</a> <a id="521" class="Symbol">(</a><a id="522" href="Agda.Primitive.html#764" class="Primitive">lzero</a> <a id="528" class="Symbol">to</a> <a id="531" class="Primitive">ℓ₀</a> <a id="534" class="Symbol">)</a>
<a id="536" class="Keyword">open</a> <a id="541" class="Keyword">import</a> <a id="548" href="Data.Product.html" class="Module">Data.Product</a>    <a id="564" class="Keyword">using</a> <a id="570" class="Symbol">(</a> <a id="572" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">_,_</a> <a id="576" class="Symbol">;</a> <a id="578" href="Data.Product.html#1167" class="Function Operator">_×_</a> <a id="582" class="Symbol">)</a>
<a id="584" class="Keyword">open</a> <a id="589" class="Keyword">import</a> <a id="596" href="Relation.Unary.html" class="Module">Relation.Unary</a>  <a id="612" class="Keyword">using</a> <a id="618" class="Symbol">(</a> <a id="620" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="625" class="Symbol">;</a> <a id="627" href="Relation.Unary.html#1523" class="Function Operator">_∈_</a> <a id="631" class="Symbol">)</a>

<a id="634" class="Comment">-- Imports from agda-algebras --------------------------------------------------------------</a>
<a id="727" class="Keyword">open</a> <a id="732" class="Keyword">import</a> <a id="739" href="Overture.Preliminaries.html" class="Module">Overture.Preliminaries</a>         <a id="770" class="Keyword">using</a> <a id="776" class="Symbol">(</a> <a id="778" href="Overture.Preliminaries.html#3383" class="Datatype">𝟘</a> <a id="780" class="Symbol">;</a> <a id="782" href="Overture.Preliminaries.html#3470" class="Datatype">𝟙</a> <a id="784" class="Symbol">;</a> <a id="786" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a> <a id="788" class="Symbol">;</a> <a id="790" href="Overture.Preliminaries.html#3708" class="Datatype">𝟛</a> <a id="792" class="Symbol">)</a>
<a id="794" class="Keyword">open</a> <a id="799" class="Keyword">import</a> <a id="806" href="Relations.Continuous.html" class="Module">Relations.Continuous</a>           <a id="837" class="Keyword">using</a> <a id="843" class="Symbol">(</a> <a id="845" href="Relations.Continuous.html#3871" class="Function">Rel</a> <a id="849" class="Symbol">)</a>
<a id="851" class="Keyword">open</a> <a id="856" class="Keyword">import</a> <a id="863" href="Structures.Basic.html" class="Module">Structures.Basic</a>               <a id="894" class="Keyword">using</a> <a id="900" class="Symbol">(</a> <a id="902" href="Structures.Basic.html#1258" class="Record">signature</a> <a id="912" class="Symbol">;</a> <a id="914" href="Structures.Basic.html#1592" class="Record">structure</a> <a id="924" class="Symbol">)</a>
<a id="926" class="Keyword">open</a> <a id="931" class="Keyword">import</a> <a id="938" href="Examples.Structures.Signatures.html" class="Module">Examples.Structures.Signatures</a> <a id="969" class="Keyword">using</a> <a id="975" class="Symbol">(</a> <a id="977" href="Examples.Structures.Signatures.html#566" class="Function">S∅</a> <a id="980" class="Symbol">;</a> <a id="982" href="Examples.Structures.Signatures.html#894" class="Function">S001</a> <a id="987" class="Symbol">;</a> <a id="989" href="Examples.Structures.Signatures.html#1149" class="Function">S021</a><a id="993" class="Symbol">)</a>
<a id="995" class="Keyword">open</a> <a id="1000" class="Keyword">import</a> <a id="1007" href="Structures.Homs.html" class="Module">Structures.Homs</a>                <a id="1038" class="Keyword">using</a> <a id="1044" class="Symbol">(</a> <a id="1046" href="Structures.Homs.html#2725" class="Function">hom</a> <a id="1050" class="Symbol">)</a>

<a id="1053" class="Keyword">open</a> <a id="1058" href="Structures.Basic.html#1258" class="Module">signature</a>
<a id="1068" class="Keyword">open</a> <a id="1073" href="Structures.Basic.html#1592" class="Module">structure</a>
<a id="1083" class="Comment">-- open _⊎_</a>



</pre>


Some exercises below refer to the following relations on 𝟚 := \{0, 1\} (where i, j ∈ 𝟚):

\begin{align*}
 Cᵢᵃ    & := \{ i \}                             \\
 Rᵃ    & := \{ (0, 0), (1, 1) \}                 \\
 Nᵃ    & := \{ (0, 1), (1, 0) \}                  \\
 Sᵢⱼᵃ  & := 𝟚² - \{ (i , j) \},                    \\
 Hᵃ    & := 𝟚³ - \{ (1, 1, 0) \}                 \\
 G₁ᵃ   & := \{ (0,0,0), (0,1,1), (1,0,1), (1,1,0) \} \\
 G₂ᵃ   & := \{ (0,0,1), (0,1,0), (1,0,0), (1,1,1) \}
\end{align*}


**Exercise 1**. Prove that the definitions of CSP(𝔸) (satisfiability of a list of constraints, homomorphism   problem, truth of primitive positive formulas) are equivalent.


**Exercise 2**. Find a polymomial-time algorithm for CSP(A), where

2.1. 𝑨 = ({0, 1}, Rᵃ) = (𝟚 , \{(0,0), (1, 1)\})
2.2. 𝑨 = ({0, 1}, Rᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , \{ (0,0) , (1, 1) \} , \{ 0 \} , \{ 1 \})
2.3. 𝑨 = ({0, 1}, S₁₀ᵃ) = (𝟚 , 𝟚³ - \{ (1, 0) \})
2.4. 𝑨 = ({0, 1}, S₁₀ᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , 𝟚³ - \{ (1, 0) \} , \{ 0 \} , \{ 1 \})
2.5. 𝑨 = ({0, 1}, S₀₁ᵃ, S₁₀ᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , 𝟚³ - \{ (0, 1) \} , 𝟚³ - \{ (1, 0) \} , \{ 0 \} , \{ 1 \})
2.6. 𝑨 = ({0, 1}, Nᵃ) = (𝟚 , \{ (0, 1) , (1, 0) \})
2.7. 𝑨 = ({0, 1}, Rᵃ, Nᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , \{ (0,0) , (1, 1) \} , \{ (0, 1) , (1, 0) \} , \{ 0 \} , \{ 1 \})
2.8. 𝑨 = ({0, 1}, Rᵃ, Nᵃ, C₀ᵃ, C₁ᵃ, 𝑆₀₀, S₀₁ᵃ, S₁₀ᵃ, S₁₁ᵃ) = (𝟚 , \{ (0,0) , (1, 1) \} , \{ (0, 1) , (1, 0) \} , \{ 0 \} , \{ 1 \} , 𝟚³ - \{ (0, 0) \} , 𝟚³ - \{ (0, 1) \} , 𝟚³ - \{ (1, 0) \} , 𝟚³ - \{ (1, 1) \})
2.9. 𝑨 = ({0, 1}, all unary and binary relations)



**Solution 2.1**. If 𝑨 = ({0, 1}, Rᵃ) = (𝟚 , \{(0,0), (1, 1)\}), then an instance of (the HOM
formulation of) CSP(𝑨) is a relational structure 𝑩 = (B, Rᵇ⟩, where Rᵇ ⊆ B² and we must decide
whether there exists a homomorphism f : 𝑩 → 𝑨, that is, a map f : B → A (= 𝟚) such that
∀ (b, b'), if (b, b') ∈ Rᵇ, then (f b, f b') ∈ Rᵇ.

Of course, the constant map f ≡ 0 that sends every element of B to 0 (as well as the
constantly-1 map) is such a homomorphism.  Let's prove this formally.

<pre class="Agda">
<a id="3135" class="Keyword">module</a> <a id="solution-2-1"></a><a id="3142" href="Exercises.Complexity.FiniteCSP.html#3142" class="Module">solution-2-1</a> <a id="3155" class="Keyword">where</a>

 <a id="3163" class="Comment">-- The (purely) relational structure with</a>
 <a id="3206" class="Comment">-- + 2-element domain,</a>
 <a id="3230" class="Comment">-- + one binary relation Rᵃ := \{(0,0), (1, 1)\}</a>

 <a id="3281" class="Keyword">data</a> <a id="solution-2-1.Rᵃ"></a><a id="3286" href="Exercises.Complexity.FiniteCSP.html#3286" class="Datatype">Rᵃ</a> <a id="3289" class="Symbol">:</a> <a id="3291" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="3296" class="Symbol">(</a><a id="3297" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a> <a id="3299" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="3301" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a><a id="3302" class="Symbol">)</a> <a id="3304" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a> <a id="3307" class="Keyword">where</a>
  <a id="solution-2-1.Rᵃ.r1"></a><a id="3315" href="Exercises.Complexity.FiniteCSP.html#3315" class="InductiveConstructor">r1</a> <a id="3318" class="Symbol">:</a> <a id="3320" class="Symbol">(</a><a id="3321" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a> <a id="3325" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3327" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a> <a id="3331" class="Symbol">)</a> <a id="3333" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="3335" href="Exercises.Complexity.FiniteCSP.html#3286" class="Datatype">Rᵃ</a>
  <a id="solution-2-1.Rᵃ.r2"></a><a id="3340" href="Exercises.Complexity.FiniteCSP.html#3340" class="InductiveConstructor">r2</a> <a id="3343" class="Symbol">:</a> <a id="3345" class="Symbol">(</a><a id="3346" href="Overture.Preliminaries.html#3626" class="InductiveConstructor">𝟚.𝟏</a> <a id="3350" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3352" href="Overture.Preliminaries.html#3626" class="InductiveConstructor">𝟚.𝟏</a> <a id="3356" class="Symbol">)</a> <a id="3358" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="3360" href="Exercises.Complexity.FiniteCSP.html#3286" class="Datatype">Rᵃ</a>

 <a id="solution-2-1.𝑨"></a><a id="3365" href="Exercises.Complexity.FiniteCSP.html#3365" class="Function">𝑨</a> <a id="3367" class="Symbol">:</a> <a id="3369" href="Structures.Basic.html#1592" class="Record">structure</a> <a id="3379" href="Examples.Structures.Signatures.html#566" class="Function">S∅</a>    <a id="3385" class="Comment">-- (no operation symbols)</a>
               <a id="3426" href="Examples.Structures.Signatures.html#894" class="Function">S001</a>  <a id="3432" class="Comment">-- (one binary relation symbol)</a>

 <a id="3466" href="Exercises.Complexity.FiniteCSP.html#3365" class="Function">𝑨</a> <a id="3468" class="Symbol">=</a> <a id="3470" class="Keyword">record</a> <a id="3477" class="Symbol">{</a> <a id="3479" href="Structures.Basic.html#1744" class="Field">carrier</a> <a id="3487" class="Symbol">=</a> <a id="3489" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a>
            <a id="3503" class="Symbol">;</a> <a id="3505" href="Structures.Basic.html#1763" class="Field">op</a> <a id="3508" class="Symbol">=</a> <a id="3510" class="Symbol">λ</a> <a id="3512" class="Symbol">()</a>
            <a id="3527" class="Symbol">;</a> <a id="3529" href="Structures.Basic.html#1847" class="Field">rel</a> <a id="3533" class="Symbol">=</a> <a id="3535" class="Symbol">λ</a> <a id="3537" href="Exercises.Complexity.FiniteCSP.html#3537" class="Bound">_</a> <a id="3539" href="Exercises.Complexity.FiniteCSP.html#3539" class="Bound">x</a> <a id="3541" class="Symbol">→</a> <a id="3543" class="Symbol">((</a><a id="3545" href="Exercises.Complexity.FiniteCSP.html#3539" class="Bound">x</a> <a id="3547" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a><a id="3550" class="Symbol">)</a> <a id="3552" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3554" class="Symbol">(</a><a id="3555" href="Exercises.Complexity.FiniteCSP.html#3539" class="Bound">x</a> <a id="3557" href="Overture.Preliminaries.html#3626" class="InductiveConstructor">𝟚.𝟏</a><a id="3560" class="Symbol">))</a> <a id="3563" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="3565" href="Exercises.Complexity.FiniteCSP.html#3286" class="Datatype">Rᵃ</a>
            <a id="3580" class="Symbol">}</a>


 <a id="3585" class="Comment">-- Claim: Given an arbitrary 𝑩 in the signatures Sig∅ Sig001, we can construct a homomorphism from 𝑩 to 𝑨.</a>
 <a id="solution-2-1.claim"></a><a id="3693" href="Exercises.Complexity.FiniteCSP.html#3693" class="Function">claim</a> <a id="3699" class="Symbol">:</a> <a id="3701" class="Symbol">(</a><a id="3702" href="Exercises.Complexity.FiniteCSP.html#3702" class="Bound">𝑩</a> <a id="3704" class="Symbol">:</a> <a id="3706" href="Structures.Basic.html#1592" class="Record">structure</a> <a id="3716" class="Symbol">{</a><a id="3717" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a><a id="3719" class="Symbol">}{</a><a id="3721" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a><a id="3723" class="Symbol">}{</a><a id="3725" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a><a id="3727" class="Symbol">}{</a><a id="3729" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a><a id="3731" class="Symbol">}</a> <a id="3733" href="Examples.Structures.Signatures.html#566" class="Function">S∅</a> <a id="3736" href="Examples.Structures.Signatures.html#894" class="Function">S001</a> <a id="3741" class="Symbol">{</a><a id="3742" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a><a id="3744" class="Symbol">}{</a><a id="3746" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a><a id="3748" class="Symbol">})</a> <a id="3751" class="Symbol">→</a> <a id="3753" href="Structures.Homs.html#2725" class="Function">hom</a> <a id="3757" href="Exercises.Complexity.FiniteCSP.html#3702" class="Bound">𝑩</a> <a id="3759" href="Exercises.Complexity.FiniteCSP.html#3365" class="Function">𝑨</a>
 <a id="3762" href="Exercises.Complexity.FiniteCSP.html#3693" class="Function">claim</a> <a id="3768" href="Exercises.Complexity.FiniteCSP.html#3768" class="Bound">𝑩</a> <a id="3770" class="Symbol">=</a> <a id="3772" class="Symbol">(λ</a> <a id="3775" href="Exercises.Complexity.FiniteCSP.html#3775" class="Bound">x</a> <a id="3777" class="Symbol">→</a> <a id="3779" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a><a id="3782" class="Symbol">)</a> <a id="3784" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3786" class="Symbol">(λ</a> <a id="3789" href="Exercises.Complexity.FiniteCSP.html#3789" class="Bound">_</a> <a id="3791" href="Exercises.Complexity.FiniteCSP.html#3791" class="Bound">_</a> <a id="3793" href="Exercises.Complexity.FiniteCSP.html#3793" class="Bound">_</a> <a id="3795" class="Symbol">→</a> <a id="3797" href="Exercises.Complexity.FiniteCSP.html#3315" class="InductiveConstructor">r1</a><a id="3799" class="Symbol">)</a> <a id="3801" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3803" class="Symbol">λ</a> <a id="3805" class="Symbol">()</a>

</pre>

In general, whenever the template structure 𝑨 has a one-element subuniverse, say, \{ a \},
then the constant map that always gives a is a homomorphism from any structure in the given
signature to 𝑨. ∎



**Solution 2.2**. If 𝑨 = (\{ 0, 1 \}, Rᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , \{ (0, 0) , (1, 1) \} , \{ 0 \} , \{ 1 \}),
then an instance of HOM CSP(𝑨) is a relational structure 𝑩 = (B, Rᵇ, C₀ᵇ, C₁ᵇ), where
Rᵇ ⊆ B², C₀ᵇ ⊆ B, C₁ᵇ ⊆ B, and we must decide whether there exists a homomorphism
f : hom 𝑩 𝑨, that is, a map f : B → 𝟚 such that the following conditions hold:
 1. ∀ (x, y) ∈ B², (x, y) ∈ Rᵇ implies (f x , f y) ∈ Rᵇ,
 2. f is constantly 0 on C₀ᵇ, and
 3. f is constantly 1 on C₁ᵇ.

The first condition says that if (x, y) ∈ Rᵇ, then either f x = 0 = f y or f x = 1 = f y.

Therefore, there exists a homomorphism f : hom 𝑩 𝑨 iff Rᵇ ∩ C₀ᵇ × C₁ᵇ = ∅ = Rᵇ ∩ C₁ᵇ × C₀ᵇ.

We can check this in polynomial time (in the size of the input instance 𝑩) since we just need
to check each pair (x, y) ∈ Rᵇ and make sure that the following two implications hold:

 1.  x ∈ C₀ᵇ  only if  y ∉ C₁ᵇ, and
 2.  x ∈ C₁ᵇ  only if  y ∉ C₀ᵇ.

<pre class="Agda">

<a id="4946" class="Keyword">module</a> <a id="solution-2-2"></a><a id="4953" href="Exercises.Complexity.FiniteCSP.html#4953" class="Module">solution-2-2</a> <a id="4966" class="Keyword">where</a>

 <a id="4974" class="Comment">-- The (purely) relational structure with</a>
 <a id="5017" class="Comment">-- + 2-element domain,</a>
 <a id="5041" class="Comment">-- + one binary relation: Rᵃ := { (0,0), (1, 1) }</a>
 <a id="5092" class="Comment">-- + two unary relations: C₀ᵃ := { 0 } , C₁ᵃ := { 1 }</a>

 <a id="5148" class="Keyword">data</a> <a id="solution-2-2.Rᵃ"></a><a id="5153" href="Exercises.Complexity.FiniteCSP.html#5153" class="Datatype">Rᵃ</a> <a id="5156" class="Symbol">:</a> <a id="5158" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="5163" class="Symbol">(</a><a id="5164" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a> <a id="5166" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="5168" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a><a id="5169" class="Symbol">)</a> <a id="5171" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a> <a id="5174" class="Keyword">where</a>
  <a id="solution-2-2.Rᵃ.r1"></a><a id="5182" href="Exercises.Complexity.FiniteCSP.html#5182" class="InductiveConstructor">r1</a> <a id="5185" class="Symbol">:</a> <a id="5187" class="Symbol">(</a><a id="5188" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a> <a id="5192" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="5194" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a> <a id="5198" class="Symbol">)</a> <a id="5200" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="5202" href="Exercises.Complexity.FiniteCSP.html#5153" class="Datatype">Rᵃ</a>
  <a id="solution-2-2.Rᵃ.r2"></a><a id="5207" href="Exercises.Complexity.FiniteCSP.html#5207" class="InductiveConstructor">r2</a> <a id="5210" class="Symbol">:</a> <a id="5212" class="Symbol">(</a><a id="5213" href="Overture.Preliminaries.html#3626" class="InductiveConstructor">𝟚.𝟏</a> <a id="5217" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="5219" href="Overture.Preliminaries.html#3626" class="InductiveConstructor">𝟚.𝟏</a> <a id="5223" class="Symbol">)</a> <a id="5225" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="5227" href="Exercises.Complexity.FiniteCSP.html#5153" class="Datatype">Rᵃ</a>

 <a id="5232" class="Keyword">data</a> <a id="solution-2-2.C₀ᵃ"></a><a id="5237" href="Exercises.Complexity.FiniteCSP.html#5237" class="Datatype">C₀ᵃ</a> <a id="5241" class="Symbol">:</a> <a id="5243" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="5248" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a> <a id="5250" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a> <a id="5253" class="Keyword">where</a>
  <a id="solution-2-2.C₀ᵃ.c₀"></a><a id="5261" href="Exercises.Complexity.FiniteCSP.html#5261" class="InductiveConstructor">c₀</a> <a id="5264" class="Symbol">:</a> <a id="5266" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a> <a id="5270" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="5272" href="Exercises.Complexity.FiniteCSP.html#5237" class="Datatype">C₀ᵃ</a>

 <a id="5278" class="Keyword">data</a> <a id="solution-2-2.C₁ᵃ"></a><a id="5283" href="Exercises.Complexity.FiniteCSP.html#5283" class="Datatype">C₁ᵃ</a> <a id="5287" class="Symbol">:</a> <a id="5289" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="5294" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a> <a id="5296" href="Exercises.Complexity.FiniteCSP.html#531" class="Primitive">ℓ₀</a> <a id="5299" class="Keyword">where</a>
  <a id="solution-2-2.C₁ᵃ.c₁"></a><a id="5307" href="Exercises.Complexity.FiniteCSP.html#5307" class="InductiveConstructor">c₁</a> <a id="5310" class="Symbol">:</a> <a id="5312" href="Overture.Preliminaries.html#3626" class="InductiveConstructor">𝟚.𝟏</a> <a id="5316" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="5318" href="Exercises.Complexity.FiniteCSP.html#5283" class="Datatype">C₁ᵃ</a>


 <a id="solution-2-2.𝑨"></a><a id="5325" href="Exercises.Complexity.FiniteCSP.html#5325" class="Function">𝑨</a> <a id="5327" class="Symbol">:</a> <a id="5329" href="Structures.Basic.html#1592" class="Record">structure</a> <a id="5339" href="Examples.Structures.Signatures.html#566" class="Function">S∅</a>    <a id="5345" class="Comment">-- (no operations)</a>
               <a id="5379" href="Examples.Structures.Signatures.html#1149" class="Function">S021</a>  <a id="5385" class="Comment">-- (two unary relations and one binary relation)</a>

 <a id="5436" href="Exercises.Complexity.FiniteCSP.html#5325" class="Function">𝑨</a> <a id="5438" class="Symbol">=</a> <a id="5440" class="Keyword">record</a> <a id="5447" class="Symbol">{</a> <a id="5449" href="Structures.Basic.html#1744" class="Field">carrier</a> <a id="5457" class="Symbol">=</a> <a id="5459" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a>
            <a id="5473" class="Symbol">;</a> <a id="5475" href="Structures.Basic.html#1763" class="Field">op</a> <a id="5478" class="Symbol">=</a> <a id="5480" class="Symbol">λ</a> <a id="5482" class="Symbol">()</a>
            <a id="5497" class="Symbol">;</a> <a id="5499" href="Structures.Basic.html#1847" class="Field">rel</a> <a id="5503" class="Symbol">=</a> <a id="5505" href="Exercises.Complexity.FiniteCSP.html#5554" class="Function">rels</a>
            <a id="5522" class="Symbol">}</a>
            <a id="5536" class="Keyword">where</a>
            <a id="5554" href="Exercises.Complexity.FiniteCSP.html#5554" class="Function">rels</a> <a id="5559" class="Symbol">:</a> <a id="5561" class="Symbol">(</a><a id="5562" href="Exercises.Complexity.FiniteCSP.html#5562" class="Bound">r</a> <a id="5564" class="Symbol">:</a> <a id="5566" href="Overture.Preliminaries.html#3708" class="Datatype">𝟛</a><a id="5567" class="Symbol">)</a> <a id="5569" class="Symbol">→</a> <a id="5571" href="Relations.Continuous.html#3871" class="Function">Rel</a> <a id="5575" href="Overture.Preliminaries.html#3525" class="Datatype">𝟚</a> <a id="5577" class="Symbol">(</a><a id="5578" href="Structures.Basic.html#1337" class="Field">arity</a> <a id="5584" href="Examples.Structures.Signatures.html#1149" class="Function">S021</a> <a id="5589" href="Exercises.Complexity.FiniteCSP.html#5562" class="Bound">r</a><a id="5590" class="Symbol">)</a>
            <a id="5604" href="Exercises.Complexity.FiniteCSP.html#5554" class="Function">rels</a> <a id="5609" href="Overture.Preliminaries.html#3727" class="InductiveConstructor">𝟛.𝟎</a> <a id="5613" href="Exercises.Complexity.FiniteCSP.html#5613" class="Bound">x</a> <a id="5615" class="Symbol">=</a> <a id="5617" class="Symbol">((</a><a id="5619" href="Exercises.Complexity.FiniteCSP.html#5613" class="Bound">x</a> <a id="5621" href="Overture.Preliminaries.html#3575" class="InductiveConstructor">𝟚.𝟎</a><a id="5624" class="Symbol">)</a> <a id="5626" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="5628" class="Symbol">(</a><a id="5629" href="Exercises.Complexity.FiniteCSP.html#5613" class="Bound">x</a> <a id="5631" href="Overture.Preliminaries.html#3626" class="InductiveConstructor">𝟚.𝟏</a><a id="5634" class="Symbol">))</a> <a id="5637" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="5639" href="Exercises.Complexity.FiniteCSP.html#5153" class="Datatype">Rᵃ</a>
            <a id="5654" href="Exercises.Complexity.FiniteCSP.html#5554" class="Function">rels</a> <a id="5659" href="Overture.Preliminaries.html#3734" class="InductiveConstructor">𝟛.𝟏</a> <a id="5663" href="Exercises.Complexity.FiniteCSP.html#5663" class="Bound">x</a> <a id="5665" class="Symbol">=</a> <a id="5667" href="Exercises.Complexity.FiniteCSP.html#5663" class="Bound">x</a> <a id="5669" href="Overture.Preliminaries.html#3489" class="InductiveConstructor">𝟙.𝟎</a> <a id="5673" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="5675" href="Exercises.Complexity.FiniteCSP.html#5237" class="Datatype">C₀ᵃ</a>
            <a id="5691" href="Exercises.Complexity.FiniteCSP.html#5554" class="Function">rels</a> <a id="5696" href="Overture.Preliminaries.html#3741" class="InductiveConstructor">𝟛.𝟐</a> <a id="5700" href="Exercises.Complexity.FiniteCSP.html#5700" class="Bound">x</a> <a id="5702" class="Symbol">=</a> <a id="5704" href="Exercises.Complexity.FiniteCSP.html#5700" class="Bound">x</a> <a id="5706" href="Overture.Preliminaries.html#3489" class="InductiveConstructor">𝟙.𝟎</a> <a id="5710" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="5712" href="Exercises.Complexity.FiniteCSP.html#5283" class="Datatype">C₁ᵃ</a>


 <a id="5719" class="Comment">-- Claim: Given an arbitrary 𝑩 in the signatures S∅ S021, we can construct a homomorphism from 𝑩 to 𝑨.</a>
 <a id="5823" class="Comment">-- claim :  (𝑩 : structure S∅ S021 {ℓ₀}{ℓ₀})</a>
 <a id="5869" class="Comment">--  →       (∀ (x : 𝟚 → carrier 𝑩)</a>
 <a id="5905" class="Comment">--           → (rel 𝑩) 𝟛.𝟎 x  -- if ((x 𝟚.𝟎) , (x 𝟚.𝟏)) ∈ Rᵇ, then...</a>
 <a id="5976" class="Comment">--           → ((rel 𝑩) 𝟛.𝟏 (λ _ → (x 𝟚.𝟎)) → ¬ (rel 𝑩) 𝟛.𝟐 (λ _ → (x 𝟚.𝟏)))</a>
 <a id="6054" class="Comment">--             × ((rel 𝑩) 𝟛.𝟏 (λ _ → (x 𝟚.𝟏)) → ¬ (rel 𝑩) 𝟛.𝟐 (λ _ → (x 𝟚.𝟎)))</a>
 <a id="6134" class="Comment">--          --  × (x 𝟚.𝟎 ∈ C₁ᵇ → x 𝟚.𝟏 ∉ C₀ᵇ))</a>
 <a id="6182" class="Comment">--          )</a>
 <a id="6197" class="Comment">--  →       hom 𝑩 𝑨</a>
 <a id="6218" class="Comment">-- claim 𝑩 x = {!!}</a>

</pre>


(The remainder are "todo.")

**Solution 2.3**. 𝑨 = ({0, 1}, S₁₀ᵃ) = (𝟚 , 𝟚³ - \{ (1, 0) \})

**Solution 2.4**. 𝑨 = ({0, 1}, S₁₀ᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , 𝟚³ - \{ (1, 0) \} , \{ 0 \} , \{ 1 \})

**Solution 2.5**. 𝑨 = ({0, 1}, S₀₁ᵃ, S₁₀ᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , 𝟚³ - \{ (0, 1) \} , 𝟚³ - \{ (1, 0) \} , \{ 0 \} , \{ 1 \})

**Solution 2.6**. 𝑨 = ({0, 1}, Nᵃ) = (𝟚 , \{ (0, 1) , (1, 0) \})

**Solution 2.7**. 𝑨 = ({0, 1}, Rᵃ, Nᵃ, C₀ᵃ, C₁ᵃ) = (𝟚 , \{ (0,0) , (1, 1) \} , \{ (0, 1) , (1, 0) \} , \{ 0 \} , \{ 1 \})

**Solution 2.8**. 𝑨 = ({0, 1}, Rᵃ, Nᵃ, C₀ᵃ, C₁ᵃ, 𝑆₀₀, S₀₁ᵃ, S₁₀ᵃ, S₁₁ᵃ) = (𝟚 , \{ (0,0) , (1, 1) \} , \{ (0, 1) , (1, 0) \} , \{ 0 \} , \{ 1 \} , 𝟚³ - \{ (0, 0) \} , 𝟚³ - \{ (0, 1) \} , 𝟚³ - \{ (1, 0) \} , 𝟚³ - \{ (1, 1) \})

**Solution 2.9**. 𝑨 = ({0, 1}, all unary and binary relations)


**Exercise 3**. Find a polynomial-time algorithm for CSP({0, 1}, Hᵃ, C₀ᵃ, C₁ᵃ).

**Exercise 4**. Find a polynomial-time algorithm for CSP({0, 1}, C₀ᵃ, C₁ᵃ, G₁ᵃ, G₂ᵃ).

**Exercise 5**. Find a polynomial-time algorithm for CSP(ℚ, <).


