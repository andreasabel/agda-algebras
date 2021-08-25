---
layout: default
title : Residuation.Basic module (The Agda Universal Algebra Library)
date : 2021-07-12
author: [agda-algebras development team][]
---

## Residuation

<pre class="Agda">

<a id="187" class="Symbol">{-#</a> <a id="191" class="Keyword">OPTIONS</a> <a id="199" class="Pragma">--without-K</a> <a id="211" class="Pragma">--exact-split</a> <a id="225" class="Pragma">--safe</a> <a id="232" class="Symbol">#-}</a>

<a id="237" class="Keyword">module</a> <a id="244" href="Residuation.Basic.html" class="Module">Residuation.Basic</a> <a id="262" class="Keyword">where</a>

<a id="269" class="Keyword">open</a> <a id="274" class="Keyword">import</a> <a id="281" href="Agda.Primitive.html" class="Module">Agda.Primitive</a>          <a id="305" class="Keyword">using</a> <a id="311" class="Symbol">(</a> <a id="313" href="Agda.Primitive.html#810" class="Primitive Operator">_⊔_</a> <a id="317" class="Symbol">;</a>  <a id="320" href="Agda.Primitive.html#597" class="Postulate">Level</a> <a id="326" class="Symbol">;</a> <a id="328" href="Agda.Primitive.html#780" class="Primitive">lsuc</a><a id="332" class="Symbol">)</a> <a id="334" class="Keyword">renaming</a> <a id="343" class="Symbol">(</a> <a id="345" href="Agda.Primitive.html#326" class="Primitive">Set</a> <a id="349" class="Symbol">to</a> <a id="352" class="Primitive">Type</a> <a id="357" class="Symbol">)</a>
<a id="359" class="Keyword">open</a> <a id="364" class="Keyword">import</a> <a id="371" href="Function.Base.html" class="Module">Function.Base</a>           <a id="395" class="Keyword">using</a> <a id="401" class="Symbol">(</a> <a id="403" href="Function.Base.html#6285" class="Function Operator">_on_</a> <a id="408" class="Symbol">)</a>
<a id="410" class="Keyword">open</a> <a id="415" class="Keyword">import</a> <a id="422" href="Relation.Binary.Bundles.html" class="Module">Relation.Binary.Bundles</a> <a id="446" class="Keyword">using</a> <a id="452" class="Symbol">(</a> <a id="454" href="Relation.Binary.Bundles.html#3028" class="Record">Poset</a> <a id="460" class="Symbol">)</a>
<a id="462" class="Keyword">open</a> <a id="467" class="Keyword">import</a> <a id="474" href="Relation.Binary.Core.html" class="Module">Relation.Binary.Core</a>    <a id="498" class="Keyword">using</a> <a id="504" class="Symbol">(</a> <a id="506" href="Relation.Binary.Core.html#1563" class="Function Operator">_Preserves_⟶_</a> <a id="520" class="Symbol">)</a>


<a id="524" class="Keyword">module</a> <a id="531" href="Residuation.Basic.html#531" class="Module">_</a> <a id="533" class="Symbol">{</a><a id="534" href="Residuation.Basic.html#534" class="Bound">α</a> <a id="536" href="Residuation.Basic.html#536" class="Bound">ιᵃ</a> <a id="539" href="Residuation.Basic.html#539" class="Bound">ρᵃ</a> <a id="542" class="Symbol">:</a> <a id="544" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="549" class="Symbol">}</a> <a id="551" class="Symbol">(</a><a id="552" href="Residuation.Basic.html#552" class="Bound">A</a> <a id="554" class="Symbol">:</a> <a id="556" href="Relation.Binary.Bundles.html#3028" class="Record">Poset</a> <a id="562" href="Residuation.Basic.html#534" class="Bound">α</a> <a id="564" href="Residuation.Basic.html#536" class="Bound">ιᵃ</a> <a id="567" href="Residuation.Basic.html#539" class="Bound">ρᵃ</a><a id="569" class="Symbol">)</a>
         <a id="580" class="Symbol">{</a><a id="581" href="Residuation.Basic.html#581" class="Bound">β</a> <a id="583" href="Residuation.Basic.html#583" class="Bound">ιᵇ</a> <a id="586" href="Residuation.Basic.html#586" class="Bound">ρᵇ</a> <a id="589" class="Symbol">:</a> <a id="591" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="596" class="Symbol">}</a> <a id="598" class="Symbol">(</a><a id="599" href="Residuation.Basic.html#599" class="Bound">B</a> <a id="601" class="Symbol">:</a> <a id="603" href="Relation.Binary.Bundles.html#3028" class="Record">Poset</a> <a id="609" href="Residuation.Basic.html#581" class="Bound">β</a> <a id="611" href="Residuation.Basic.html#583" class="Bound">ιᵇ</a> <a id="614" href="Residuation.Basic.html#586" class="Bound">ρᵇ</a><a id="616" class="Symbol">)</a>
         <a id="627" class="Keyword">where</a>

 <a id="635" class="Keyword">open</a> <a id="640" href="Relation.Binary.Bundles.html#3028" class="Module">Poset</a>

 <a id="648" class="Keyword">private</a>
  <a id="658" href="Residuation.Basic.html#658" class="Function Operator">_≤A_</a> <a id="663" class="Symbol">=</a> <a id="665" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a> <a id="669" href="Residuation.Basic.html#552" class="Bound">A</a>
  <a id="673" href="Residuation.Basic.html#673" class="Function Operator">_≤B_</a> <a id="678" class="Symbol">=</a> <a id="680" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a> <a id="684" href="Residuation.Basic.html#599" class="Bound">B</a>

 <a id="688" class="Keyword">record</a> <a id="695" href="Residuation.Basic.html#695" class="Record">Residuation</a> <a id="707" class="Symbol">:</a> <a id="709" href="Residuation.Basic.html#352" class="Primitive">Type</a> <a id="714" class="Symbol">(</a><a id="715" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="720" class="Symbol">(</a><a id="721" href="Residuation.Basic.html#534" class="Bound">α</a> <a id="723" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="725" href="Residuation.Basic.html#539" class="Bound">ρᵃ</a> <a id="728" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="730" href="Residuation.Basic.html#581" class="Bound">β</a> <a id="732" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="734" href="Residuation.Basic.html#586" class="Bound">ρᵇ</a><a id="736" class="Symbol">))</a>  <a id="740" class="Keyword">where</a>
  <a id="748" class="Keyword">field</a>
   <a id="757" href="Residuation.Basic.html#757" class="Field">f</a>     <a id="763" class="Symbol">:</a> <a id="765" href="Relation.Binary.Bundles.html#3104" class="Field">Carrier</a> <a id="773" href="Residuation.Basic.html#552" class="Bound">A</a> <a id="775" class="Symbol">→</a> <a id="777" href="Relation.Binary.Bundles.html#3104" class="Field">Carrier</a> <a id="785" href="Residuation.Basic.html#599" class="Bound">B</a>
   <a id="790" href="Residuation.Basic.html#790" class="Field">g</a>     <a id="796" class="Symbol">:</a> <a id="798" href="Relation.Binary.Bundles.html#3104" class="Field">Carrier</a> <a id="806" href="Residuation.Basic.html#599" class="Bound">B</a> <a id="808" class="Symbol">→</a> <a id="810" href="Relation.Binary.Bundles.html#3104" class="Field">Carrier</a> <a id="818" href="Residuation.Basic.html#552" class="Bound">A</a>
   <a id="823" href="Residuation.Basic.html#823" class="Field">fhom</a>  <a id="829" class="Symbol">:</a> <a id="831" href="Residuation.Basic.html#757" class="Field">f</a> <a id="833" href="Relation.Binary.Core.html#1563" class="Function Operator">Preserves</a> <a id="843" href="Residuation.Basic.html#658" class="Function Operator">_≤A_</a> <a id="848" href="Relation.Binary.Core.html#1563" class="Function Operator">⟶</a> <a id="850" href="Residuation.Basic.html#673" class="Function Operator">_≤B_</a>
   <a id="858" href="Residuation.Basic.html#858" class="Field">ghom</a>  <a id="864" class="Symbol">:</a> <a id="866" href="Residuation.Basic.html#790" class="Field">g</a> <a id="868" href="Relation.Binary.Core.html#1563" class="Function Operator">Preserves</a> <a id="878" href="Residuation.Basic.html#673" class="Function Operator">_≤B_</a> <a id="883" href="Relation.Binary.Core.html#1563" class="Function Operator">⟶</a> <a id="885" href="Residuation.Basic.html#658" class="Function Operator">_≤A_</a>
   <a id="893" href="Residuation.Basic.html#893" class="Field">gf≥id</a> <a id="899" class="Symbol">:</a> <a id="901" class="Symbol">∀</a> <a id="903" href="Residuation.Basic.html#903" class="Bound">a</a> <a id="905" class="Symbol">→</a> <a id="907" href="Residuation.Basic.html#903" class="Bound">a</a> <a id="909" href="Residuation.Basic.html#658" class="Function Operator">≤A</a> <a id="912" href="Residuation.Basic.html#790" class="Field">g</a> <a id="914" class="Symbol">(</a><a id="915" href="Residuation.Basic.html#757" class="Field">f</a> <a id="917" href="Residuation.Basic.html#903" class="Bound">a</a><a id="918" class="Symbol">)</a>
   <a id="923" href="Residuation.Basic.html#923" class="Field">fg≤id</a> <a id="929" class="Symbol">:</a> <a id="931" class="Symbol">∀</a> <a id="933" href="Residuation.Basic.html#933" class="Bound">b</a> <a id="935" class="Symbol">→</a> <a id="937" href="Residuation.Basic.html#757" class="Field">f</a> <a id="939" class="Symbol">(</a><a id="940" href="Residuation.Basic.html#790" class="Field">g</a> <a id="942" href="Residuation.Basic.html#933" class="Bound">b</a><a id="943" class="Symbol">)</a> <a id="945" href="Residuation.Basic.html#673" class="Function Operator">≤B</a> <a id="948" href="Residuation.Basic.html#933" class="Bound">b</a>


</pre>