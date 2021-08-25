---
layout: default
title : ClosureSystems.Properties module (The Agda Universal Algebra Library)
date : 2021-07-08
author: [agda-algebras development team][]
---

### <a id="properties-of-closure-systems-and-operators">Properties of Closure Systems and Operators</a>

<pre class="Agda">

<a id="284" class="Symbol">{-#</a> <a id="288" class="Keyword">OPTIONS</a> <a id="296" class="Pragma">--without-K</a> <a id="308" class="Pragma">--exact-split</a> <a id="322" class="Pragma">--safe</a> <a id="329" class="Symbol">#-}</a>

<a id="334" class="Keyword">module</a> <a id="341" href="ClosureSystems.Properties.html" class="Module">ClosureSystems.Properties</a> <a id="367" class="Keyword">where</a>

<a id="374" class="Keyword">open</a> <a id="379" class="Keyword">import</a> <a id="386" href="Agda.Primitive.html" class="Module">Agda.Primitive</a>          <a id="410" class="Keyword">using</a> <a id="416" class="Symbol">(</a> <a id="418" href="Agda.Primitive.html#810" class="Primitive Operator">_⊔_</a> <a id="422" class="Symbol">;</a> <a id="424" href="Agda.Primitive.html#597" class="Postulate">Level</a> <a id="430" class="Symbol">)</a> <a id="432" class="Keyword">renaming</a> <a id="441" class="Symbol">(</a> <a id="443" href="Agda.Primitive.html#326" class="Primitive">Set</a> <a id="447" class="Symbol">to</a> <a id="450" class="Primitive">Type</a> <a id="455" class="Symbol">)</a>
<a id="457" class="Keyword">import</a> <a id="464" href="Algebra.Definitions.html" class="Module">Algebra.Definitions</a>
<a id="484" class="Keyword">open</a> <a id="489" class="Keyword">import</a> <a id="496" href="Data.Product.html" class="Module">Data.Product</a>            <a id="520" class="Keyword">using</a> <a id="526" class="Symbol">(</a> <a id="528" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">_,_</a> <a id="532" class="Symbol">;</a> <a id="534" href="Data.Product.html#1167" class="Function Operator">_×_</a> <a id="538" class="Symbol">)</a>
<a id="540" class="Keyword">open</a> <a id="545" class="Keyword">import</a> <a id="552" href="Function.Bundles.html" class="Module">Function.Bundles</a>        <a id="576" class="Keyword">using</a> <a id="582" class="Symbol">(</a> <a id="584" href="Function.Bundles.html#8810" class="Function Operator">_↔_</a> <a id="588" class="Symbol">;</a> <a id="590" href="Function.Bundles.html#5792" class="Record">Inverse</a> <a id="598" class="Symbol">)</a>
<a id="600" class="Keyword">open</a> <a id="605" class="Keyword">import</a> <a id="612" href="Relation.Binary.Bundles.html" class="Module">Relation.Binary.Bundles</a> <a id="636" class="Keyword">using</a> <a id="642" class="Symbol">(</a> <a id="644" href="Relation.Binary.Bundles.html#3028" class="Record">Poset</a> <a id="650" class="Symbol">)</a>
<a id="652" class="Keyword">open</a> <a id="657" class="Keyword">import</a> <a id="664" href="Relation.Binary.Core.html" class="Module">Relation.Binary.Core</a>    <a id="688" class="Keyword">using</a> <a id="694" class="Symbol">(</a> <a id="696" href="Relation.Binary.Core.html#1563" class="Function Operator">_Preserves_⟶_</a> <a id="710" class="Symbol">)</a>
<a id="712" class="Keyword">import</a> <a id="719" href="Relation.Binary.Reasoning.PartialOrder.html" class="Module">Relation.Binary.Reasoning.PartialOrder</a> <a id="758" class="Symbol">as</a> <a id="761" class="Module">≤-Reasoning</a>


<a id="775" class="Keyword">open</a> <a id="780" class="Keyword">import</a> <a id="787" href="ClosureSystems.Basic.html" class="Module">ClosureSystems.Basic</a>       <a id="814" class="Keyword">using</a> <a id="820" class="Symbol">(</a> <a id="822" href="ClosureSystems.Basic.html#1549" class="Function">Extensive</a> <a id="832" class="Symbol">;</a> <a id="834" href="ClosureSystems.Basic.html#2423" class="Record">ClOp</a> <a id="839" class="Symbol">)</a>
<a id="841" class="Keyword">open</a> <a id="846" href="ClosureSystems.Basic.html#2423" class="Module">ClOp</a>
<a id="851" class="Keyword">open</a> <a id="856" href="Function.Bundles.html#5792" class="Module">Inverse</a>

<a id="865" class="Keyword">private</a> <a id="873" class="Keyword">variable</a>
 <a id="883" href="ClosureSystems.Properties.html#883" class="Generalizable">ℓ</a> <a id="885" href="ClosureSystems.Properties.html#885" class="Generalizable">ℓ₁</a> <a id="888" href="ClosureSystems.Properties.html#888" class="Generalizable">ℓ₂</a> <a id="891" class="Symbol">:</a> <a id="893" href="Agda.Primitive.html#597" class="Postulate">Level</a>

<a id="900" class="Keyword">module</a> <a id="907" href="ClosureSystems.Properties.html#907" class="Module">_</a> <a id="909" class="Symbol">{</a><a id="910" href="ClosureSystems.Properties.html#910" class="Bound">𝑨</a> <a id="912" class="Symbol">:</a> <a id="914" href="Relation.Binary.Bundles.html#3028" class="Record">Poset</a> <a id="920" href="ClosureSystems.Properties.html#883" class="Generalizable">ℓ</a> <a id="922" href="ClosureSystems.Properties.html#885" class="Generalizable">ℓ₁</a> <a id="925" href="ClosureSystems.Properties.html#888" class="Generalizable">ℓ₂</a><a id="927" class="Symbol">}(</a><a id="929" href="ClosureSystems.Properties.html#929" class="Bound">𝑪</a> <a id="931" class="Symbol">:</a> <a id="933" href="ClosureSystems.Basic.html#2423" class="Record">ClOp</a> <a id="938" href="ClosureSystems.Properties.html#910" class="Bound">𝑨</a><a id="939" class="Symbol">)</a> <a id="941" class="Keyword">where</a>
 <a id="948" class="Keyword">open</a> <a id="953" href="Relation.Binary.Bundles.html#3028" class="Module">Poset</a> <a id="959" href="ClosureSystems.Properties.html#910" class="Bound">𝑨</a>
 <a id="962" class="Keyword">open</a> <a id="967" href="Relation.Binary.Reasoning.PartialOrder.html" class="Module">≤-Reasoning</a> <a id="979" href="ClosureSystems.Properties.html#910" class="Bound">𝑨</a>

 <a id="983" class="Keyword">private</a>
  <a id="993" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="995" class="Symbol">=</a> <a id="997" href="ClosureSystems.Basic.html#2575" class="Field">C</a> <a id="999" href="ClosureSystems.Properties.html#929" class="Bound">𝑪</a>
  <a id="1003" href="ClosureSystems.Properties.html#1003" class="Function">A</a> <a id="1005" class="Symbol">=</a> <a id="1007" href="Relation.Binary.Bundles.html#3104" class="Function">Carrier</a>

</pre>

**Theorem 1**. If `𝑨 = (A , ≦)` is a poset and `c` is a closure operator on A, then

            ∀ (x y : A) → (x ≦ (c y) ↔ (c x) ≦ (c y))

<pre class="Agda">

 <a id="1183" href="ClosureSystems.Properties.html#1183" class="Function">clop→law⇒</a> <a id="1193" class="Symbol">:</a> <a id="1195" class="Symbol">(</a><a id="1196" href="ClosureSystems.Properties.html#1196" class="Bound">x</a> <a id="1198" href="ClosureSystems.Properties.html#1198" class="Bound">y</a> <a id="1200" class="Symbol">:</a> <a id="1202" href="ClosureSystems.Properties.html#1003" class="Function">A</a><a id="1203" class="Symbol">)</a> <a id="1205" class="Symbol">→</a> <a id="1207" href="ClosureSystems.Properties.html#1196" class="Bound">x</a> <a id="1209" href="Relation.Binary.Bundles.html#3167" class="Function Operator">≤</a> <a id="1211" class="Symbol">(</a><a id="1212" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1214" href="ClosureSystems.Properties.html#1198" class="Bound">y</a><a id="1215" class="Symbol">)</a> <a id="1217" class="Symbol">→</a> <a id="1219" class="Symbol">(</a><a id="1220" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1222" href="ClosureSystems.Properties.html#1196" class="Bound">x</a><a id="1223" class="Symbol">)</a> <a id="1225" href="Relation.Binary.Bundles.html#3167" class="Function Operator">≤</a> <a id="1227" class="Symbol">(</a><a id="1228" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1230" href="ClosureSystems.Properties.html#1198" class="Bound">y</a><a id="1231" class="Symbol">)</a>
 <a id="1234" href="ClosureSystems.Properties.html#1183" class="Function">clop→law⇒</a> <a id="1244" href="ClosureSystems.Properties.html#1244" class="Bound">x</a> <a id="1246" href="ClosureSystems.Properties.html#1246" class="Bound">y</a> <a id="1248" href="ClosureSystems.Properties.html#1248" class="Bound">x≤cy</a> <a id="1253" class="Symbol">=</a> <a id="1255" href="Relation.Binary.Reasoning.Base.Triple.html#3010" class="Function Operator">begin</a>
   <a id="1264" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1266" href="ClosureSystems.Properties.html#1244" class="Bound">x</a>     <a id="1272" href="Relation.Binary.Reasoning.Base.Triple.html#3745" class="Function">≤⟨</a> <a id="1275" href="ClosureSystems.Basic.html#2625" class="Field">isOrderPreserving</a> <a id="1293" href="ClosureSystems.Properties.html#929" class="Bound">𝑪</a> <a id="1295" href="ClosureSystems.Properties.html#1248" class="Bound">x≤cy</a> <a id="1300" href="Relation.Binary.Reasoning.Base.Triple.html#3745" class="Function">⟩</a>
   <a id="1305" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1307" class="Symbol">(</a><a id="1308" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1310" href="ClosureSystems.Properties.html#1246" class="Bound">y</a><a id="1311" class="Symbol">)</a> <a id="1313" href="Relation.Binary.Reasoning.Base.Triple.html#4035" class="Function">≈⟨</a> <a id="1316" href="ClosureSystems.Basic.html#2669" class="Field">isIdempotent</a> <a id="1329" href="ClosureSystems.Properties.html#929" class="Bound">𝑪</a> <a id="1331" href="ClosureSystems.Properties.html#1246" class="Bound">y</a> <a id="1333" href="Relation.Binary.Reasoning.Base.Triple.html#4035" class="Function">⟩</a>
   <a id="1338" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1340" href="ClosureSystems.Properties.html#1246" class="Bound">y</a> <a id="1342" href="Relation.Binary.Reasoning.Base.Triple.html#5119" class="Function Operator">∎</a>

 <a id="1346" href="ClosureSystems.Properties.html#1346" class="Function">clop→law⇐</a> <a id="1356" class="Symbol">:</a> <a id="1358" class="Symbol">(</a><a id="1359" href="ClosureSystems.Properties.html#1359" class="Bound">x</a> <a id="1361" href="ClosureSystems.Properties.html#1361" class="Bound">y</a> <a id="1363" class="Symbol">:</a> <a id="1365" href="ClosureSystems.Properties.html#1003" class="Function">A</a><a id="1366" class="Symbol">)</a> <a id="1368" class="Symbol">→</a> <a id="1370" class="Symbol">(</a><a id="1371" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1373" href="ClosureSystems.Properties.html#1359" class="Bound">x</a><a id="1374" class="Symbol">)</a> <a id="1376" href="Relation.Binary.Bundles.html#3167" class="Function Operator">≤</a> <a id="1378" class="Symbol">(</a><a id="1379" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1381" href="ClosureSystems.Properties.html#1361" class="Bound">y</a><a id="1382" class="Symbol">)</a> <a id="1384" class="Symbol">→</a> <a id="1386" href="ClosureSystems.Properties.html#1359" class="Bound">x</a> <a id="1388" href="Relation.Binary.Bundles.html#3167" class="Function Operator">≤</a> <a id="1390" class="Symbol">(</a><a id="1391" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1393" href="ClosureSystems.Properties.html#1361" class="Bound">y</a><a id="1394" class="Symbol">)</a>
 <a id="1397" href="ClosureSystems.Properties.html#1346" class="Function">clop→law⇐</a> <a id="1407" href="ClosureSystems.Properties.html#1407" class="Bound">x</a> <a id="1409" href="ClosureSystems.Properties.html#1409" class="Bound">y</a> <a id="1411" href="ClosureSystems.Properties.html#1411" class="Bound">cx≤cy</a> <a id="1417" class="Symbol">=</a> <a id="1419" href="Relation.Binary.Reasoning.Base.Triple.html#3010" class="Function Operator">begin</a>
   <a id="1428" href="ClosureSystems.Properties.html#1407" class="Bound">x</a>   <a id="1432" href="Relation.Binary.Reasoning.Base.Triple.html#3745" class="Function">≤⟨</a> <a id="1435" href="ClosureSystems.Basic.html#2587" class="Field">isExtensive</a> <a id="1447" href="ClosureSystems.Properties.html#929" class="Bound">𝑪</a> <a id="1449" href="Relation.Binary.Reasoning.Base.Triple.html#3745" class="Function">⟩</a>
   <a id="1454" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1456" href="ClosureSystems.Properties.html#1407" class="Bound">x</a> <a id="1458" href="Relation.Binary.Reasoning.Base.Triple.html#3745" class="Function">≤⟨</a> <a id="1461" href="ClosureSystems.Properties.html#1411" class="Bound">cx≤cy</a> <a id="1467" href="Relation.Binary.Reasoning.Base.Triple.html#3745" class="Function">⟩</a>
   <a id="1472" href="ClosureSystems.Properties.html#993" class="Function">c</a> <a id="1474" href="ClosureSystems.Properties.html#1409" class="Bound">y</a> <a id="1476" href="Relation.Binary.Reasoning.Base.Triple.html#5119" class="Function Operator">∎</a>

</pre>

The converse of Theorem 1 also holds. That is,

**Theorem 2**. If `𝑨 = (A , ≤)` is a poset and `c : A → A` satisfies

∀ (x y : A) → (x ≤ (c y) ↔ (c x) ≤ (c y))

then `c` is a closure operator on A.

<pre class="Agda">

<a id="1704" class="Keyword">module</a> <a id="1711" href="ClosureSystems.Properties.html#1711" class="Module">_</a> <a id="1713" class="Symbol">{</a><a id="1714" href="ClosureSystems.Properties.html#1714" class="Bound">𝑨</a> <a id="1716" class="Symbol">:</a> <a id="1718" href="Relation.Binary.Bundles.html#3028" class="Record">Poset</a> <a id="1724" href="ClosureSystems.Properties.html#883" class="Generalizable">ℓ</a> <a id="1726" href="ClosureSystems.Properties.html#885" class="Generalizable">ℓ₁</a> <a id="1729" href="ClosureSystems.Properties.html#888" class="Generalizable">ℓ₂</a><a id="1731" class="Symbol">}</a> <a id="1733" class="Keyword">where</a>
 <a id="1740" class="Keyword">open</a> <a id="1745" href="Relation.Binary.Bundles.html#3028" class="Module">Poset</a> <a id="1751" href="ClosureSystems.Properties.html#1714" class="Bound">𝑨</a>

 <a id="1755" class="Keyword">private</a>
  <a id="1765" href="ClosureSystems.Properties.html#1765" class="Function">A</a> <a id="1767" class="Symbol">=</a> <a id="1769" href="Relation.Binary.Bundles.html#3104" class="Field">Carrier</a>

 <a id="1779" class="Keyword">open</a> <a id="1784" href="Algebra.Definitions.html" class="Module">Algebra.Definitions</a> <a id="1804" class="Symbol">(</a><a id="1805" href="Relation.Binary.Bundles.html#3131" class="Field Operator">_≈_</a><a id="1808" class="Symbol">)</a>

 <a id="1812" href="ClosureSystems.Properties.html#1812" class="Function">clop←law</a> <a id="1821" class="Symbol">:</a> <a id="1823" class="Symbol">(</a><a id="1824" href="ClosureSystems.Properties.html#1824" class="Bound">c</a> <a id="1826" class="Symbol">:</a> <a id="1828" href="ClosureSystems.Properties.html#1765" class="Function">A</a> <a id="1830" class="Symbol">→</a> <a id="1832" href="ClosureSystems.Properties.html#1765" class="Function">A</a><a id="1833" class="Symbol">)</a> <a id="1835" class="Symbol">→</a> <a id="1837" class="Symbol">((</a><a id="1839" href="ClosureSystems.Properties.html#1839" class="Bound">x</a> <a id="1841" href="ClosureSystems.Properties.html#1841" class="Bound">y</a> <a id="1843" class="Symbol">:</a> <a id="1845" href="ClosureSystems.Properties.html#1765" class="Function">A</a><a id="1846" class="Symbol">)</a> <a id="1848" class="Symbol">→</a> <a id="1850" class="Symbol">(</a><a id="1851" href="ClosureSystems.Properties.html#1839" class="Bound">x</a> <a id="1853" href="Relation.Binary.Bundles.html#3167" class="Field Operator">≤</a> <a id="1855" class="Symbol">(</a><a id="1856" href="ClosureSystems.Properties.html#1824" class="Bound">c</a> <a id="1858" href="ClosureSystems.Properties.html#1841" class="Bound">y</a><a id="1859" class="Symbol">)</a> <a id="1861" href="Function.Bundles.html#8810" class="Function Operator">↔</a> <a id="1863" class="Symbol">(</a><a id="1864" href="ClosureSystems.Properties.html#1824" class="Bound">c</a> <a id="1866" href="ClosureSystems.Properties.html#1839" class="Bound">x</a><a id="1867" class="Symbol">)</a> <a id="1869" href="Relation.Binary.Bundles.html#3167" class="Field Operator">≤</a> <a id="1871" class="Symbol">(</a><a id="1872" href="ClosureSystems.Properties.html#1824" class="Bound">c</a> <a id="1874" href="ClosureSystems.Properties.html#1841" class="Bound">y</a><a id="1875" class="Symbol">)))</a>
  <a id="1881" class="Symbol">→</a>         <a id="1891" href="ClosureSystems.Basic.html#1549" class="Function">Extensive</a> <a id="1901" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a> <a id="1905" href="ClosureSystems.Properties.html#1824" class="Bound">c</a> <a id="1907" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="1909" href="ClosureSystems.Properties.html#1824" class="Bound">c</a> <a id="1911" href="Relation.Binary.Core.html#1563" class="Function Operator">Preserves</a> <a id="1921" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a> <a id="1925" href="Relation.Binary.Core.html#1563" class="Function Operator">⟶</a> <a id="1927" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a> <a id="1931" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="1933" href="Algebra.Definitions.html#2713" class="Function">IdempotentFun</a> <a id="1947" href="ClosureSystems.Properties.html#1824" class="Bound">c</a>

 <a id="1951" href="ClosureSystems.Properties.html#1812" class="Function">clop←law</a> <a id="1960" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="1962" href="ClosureSystems.Properties.html#1962" class="Bound">hyp</a>  <a id="1967" class="Symbol">=</a> <a id="1969" href="ClosureSystems.Properties.html#2125" class="Function">e</a> <a id="1971" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="1973" class="Symbol">(</a><a id="1974" href="ClosureSystems.Properties.html#2162" class="Function">o</a> <a id="1976" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="1978" href="ClosureSystems.Properties.html#2214" class="Function">i</a><a id="1979" class="Symbol">)</a>
  <a id="1983" class="Keyword">where</a>
  <a id="1991" href="ClosureSystems.Properties.html#1991" class="Function">h1</a> <a id="1994" class="Symbol">:</a> <a id="1996" class="Symbol">∀</a> <a id="1998" class="Symbol">{</a><a id="1999" href="ClosureSystems.Properties.html#1999" class="Bound">x</a> <a id="2001" href="ClosureSystems.Properties.html#2001" class="Bound">y</a><a id="2002" class="Symbol">}</a> <a id="2004" class="Symbol">→</a> <a id="2006" href="ClosureSystems.Properties.html#1999" class="Bound">x</a> <a id="2008" href="Relation.Binary.Bundles.html#3167" class="Field Operator">≤</a> <a id="2010" class="Symbol">(</a><a id="2011" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="2013" href="ClosureSystems.Properties.html#2001" class="Bound">y</a><a id="2014" class="Symbol">)</a> <a id="2016" class="Symbol">→</a> <a id="2018" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="2020" href="ClosureSystems.Properties.html#1999" class="Bound">x</a> <a id="2022" href="Relation.Binary.Bundles.html#3167" class="Field Operator">≤</a> <a id="2024" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="2026" href="ClosureSystems.Properties.html#2001" class="Bound">y</a>
  <a id="2030" href="ClosureSystems.Properties.html#1991" class="Function">h1</a> <a id="2033" class="Symbol">{</a><a id="2034" href="ClosureSystems.Properties.html#2034" class="Bound">x</a><a id="2035" class="Symbol">}{</a><a id="2037" href="ClosureSystems.Properties.html#2037" class="Bound">y</a><a id="2038" class="Symbol">}</a> <a id="2040" class="Symbol">=</a> <a id="2042" href="Function.Bundles.html#5846" class="Field">f</a> <a id="2044" class="Symbol">(</a><a id="2045" href="ClosureSystems.Properties.html#1962" class="Bound">hyp</a> <a id="2049" href="ClosureSystems.Properties.html#2034" class="Bound">x</a> <a id="2051" href="ClosureSystems.Properties.html#2037" class="Bound">y</a><a id="2052" class="Symbol">)</a>

  <a id="2057" href="ClosureSystems.Properties.html#2057" class="Function">h2</a> <a id="2060" class="Symbol">:</a> <a id="2062" class="Symbol">∀</a> <a id="2064" class="Symbol">{</a><a id="2065" href="ClosureSystems.Properties.html#2065" class="Bound">x</a> <a id="2067" href="ClosureSystems.Properties.html#2067" class="Bound">y</a><a id="2068" class="Symbol">}</a> <a id="2070" class="Symbol">→</a> <a id="2072" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="2074" href="ClosureSystems.Properties.html#2065" class="Bound">x</a> <a id="2076" href="Relation.Binary.Bundles.html#3167" class="Field Operator">≤</a> <a id="2078" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="2080" href="ClosureSystems.Properties.html#2067" class="Bound">y</a> <a id="2082" class="Symbol">→</a> <a id="2084" href="ClosureSystems.Properties.html#2065" class="Bound">x</a> <a id="2086" href="Relation.Binary.Bundles.html#3167" class="Field Operator">≤</a> <a id="2088" class="Symbol">(</a><a id="2089" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="2091" href="ClosureSystems.Properties.html#2067" class="Bound">y</a><a id="2092" class="Symbol">)</a>
  <a id="2096" href="ClosureSystems.Properties.html#2057" class="Function">h2</a> <a id="2099" class="Symbol">{</a><a id="2100" href="ClosureSystems.Properties.html#2100" class="Bound">x</a><a id="2101" class="Symbol">}{</a><a id="2103" href="ClosureSystems.Properties.html#2103" class="Bound">y</a><a id="2104" class="Symbol">}</a> <a id="2106" class="Symbol">=</a> <a id="2108" href="Function.Bundles.html#5870" class="Field">f⁻¹</a> <a id="2112" class="Symbol">(</a><a id="2113" href="ClosureSystems.Properties.html#1962" class="Bound">hyp</a> <a id="2117" href="ClosureSystems.Properties.html#2100" class="Bound">x</a> <a id="2119" href="ClosureSystems.Properties.html#2103" class="Bound">y</a><a id="2120" class="Symbol">)</a>

  <a id="2125" href="ClosureSystems.Properties.html#2125" class="Function">e</a> <a id="2127" class="Symbol">:</a> <a id="2129" href="ClosureSystems.Basic.html#1549" class="Function">Extensive</a> <a id="2139" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a> <a id="2143" href="ClosureSystems.Properties.html#1960" class="Bound">c</a>
  <a id="2147" href="ClosureSystems.Properties.html#2125" class="Function">e</a> <a id="2149" class="Symbol">=</a> <a id="2151" href="ClosureSystems.Properties.html#2057" class="Function">h2</a> <a id="2154" href="Relation.Binary.Structures.html#2438" class="Function">refl</a>

  <a id="2162" href="ClosureSystems.Properties.html#2162" class="Function">o</a> <a id="2164" class="Symbol">:</a> <a id="2166" href="ClosureSystems.Properties.html#1960" class="Bound">c</a> <a id="2168" href="Relation.Binary.Core.html#1563" class="Function Operator">Preserves</a> <a id="2178" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a> <a id="2182" href="Relation.Binary.Core.html#1563" class="Function Operator">⟶</a> <a id="2184" href="Relation.Binary.Bundles.html#3167" class="Field Operator">_≤_</a>
  <a id="2190" href="ClosureSystems.Properties.html#2162" class="Function">o</a> <a id="2192" href="ClosureSystems.Properties.html#2192" class="Bound">u</a> <a id="2194" class="Symbol">=</a> <a id="2196" href="ClosureSystems.Properties.html#1991" class="Function">h1</a> <a id="2199" class="Symbol">(</a><a id="2200" href="Relation.Binary.Structures.html#2361" class="Function">trans</a> <a id="2206" href="ClosureSystems.Properties.html#2192" class="Bound">u</a> <a id="2208" href="ClosureSystems.Properties.html#2125" class="Function">e</a><a id="2209" class="Symbol">)</a>

  <a id="2214" href="ClosureSystems.Properties.html#2214" class="Function">i</a> <a id="2216" class="Symbol">:</a> <a id="2218" href="Algebra.Definitions.html#2713" class="Function">IdempotentFun</a> <a id="2232" href="ClosureSystems.Properties.html#1960" class="Bound">c</a>
  <a id="2236" href="ClosureSystems.Properties.html#2214" class="Function">i</a> <a id="2238" href="ClosureSystems.Properties.html#2238" class="Bound">x</a> <a id="2240" class="Symbol">=</a> <a id="2242" href="Relation.Binary.Structures.html#3275" class="Function">antisym</a> <a id="2250" class="Symbol">(</a><a id="2251" href="ClosureSystems.Properties.html#1991" class="Function">h1</a> <a id="2254" href="Relation.Binary.Structures.html#2438" class="Function">refl</a><a id="2258" class="Symbol">)</a> <a id="2260" class="Symbol">(</a><a id="2261" href="ClosureSystems.Properties.html#2057" class="Function">h2</a> <a id="2264" href="Relation.Binary.Structures.html#2438" class="Function">refl</a><a id="2268" class="Symbol">)</a>

</pre>

----------------------------

<br>

[← ClosureSystems.Basic](ClosureSystems.Basic.html)
<span style="float:right;">[Algebras →](Algebras.html)</span>

{% include UALib.Links.md %}

[agda-algebras development team]: https://github.com/ualib/agda-algebras#the-agda-algebras-development-team