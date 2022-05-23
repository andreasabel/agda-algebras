---
layout: default
title : "Base.Structures.Sigma.Congruences module"
date : "2021-05-12"
author: "agda-algebras development team"
---

#### <a id="congruences-of-general-structures">Congruences of general structures</a>

<pre class="Agda">

<a id="238" class="Symbol">{-#</a> <a id="242" class="Keyword">OPTIONS</a> <a id="250" class="Pragma">--without-K</a> <a id="262" class="Pragma">--exact-split</a> <a id="276" class="Pragma">--safe</a> <a id="283" class="Symbol">#-}</a>

<a id="288" class="Keyword">module</a> <a id="295" href="Base.Structures.Sigma.Congruences.html" class="Module">Base.Structures.Sigma.Congruences</a> <a id="329" class="Keyword">where</a>

<a id="336" class="Comment">-- Imports from the Agda Standard Library ------------------------------------------------</a>
<a id="427" class="Keyword">open</a> <a id="432" class="Keyword">import</a> <a id="439" href="Agda.Primitive.html" class="Module">Agda.Primitive</a>  <a id="455" class="Keyword">using</a> <a id="461" class="Symbol">(</a> <a id="463" href="Agda.Primitive.html#810" class="Primitive Operator">_⊔_</a> <a id="467" class="Symbol">;</a> <a id="469" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="474" class="Symbol">)</a> <a id="476" class="Keyword">renaming</a> <a id="485" class="Symbol">(</a> <a id="487" href="Agda.Primitive.html#326" class="Primitive">Set</a> <a id="491" class="Symbol">to</a> <a id="494" class="Primitive">Type</a> <a id="499" class="Symbol">;</a> <a id="501" href="Agda.Primitive.html#764" class="Primitive">lzero</a> <a id="507" class="Symbol">to</a> <a id="510" class="Primitive">ℓ₀</a> <a id="513" class="Symbol">)</a>
<a id="515" class="Keyword">open</a> <a id="520" class="Keyword">import</a> <a id="527" href="Data.Product.html" class="Module">Data.Product</a>    <a id="543" class="Keyword">using</a> <a id="549" class="Symbol">(</a> <a id="551" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">_,_</a> <a id="555" class="Symbol">;</a> <a id="557" href="Data.Product.html#1167" class="Function Operator">_×_</a> <a id="561" class="Symbol">;</a> <a id="563" href="Data.Product.html#916" class="Function">Σ-syntax</a> <a id="572" class="Symbol">)</a> <a id="574" class="Keyword">renaming</a> <a id="583" class="Symbol">(</a> <a id="585" href="Agda.Builtin.Sigma.html#252" class="Field">proj₁</a> <a id="591" class="Symbol">to</a> <a id="594" class="Field">fst</a> <a id="598" class="Symbol">)</a>
<a id="600" class="Keyword">open</a> <a id="605" class="Keyword">import</a> <a id="612" href="Function.Base.html" class="Module">Function.Base</a>   <a id="628" class="Keyword">using</a> <a id="634" class="Symbol">(</a> <a id="636" href="Function.Base.html#1031" class="Function Operator">_∘_</a> <a id="640" class="Symbol">)</a>
<a id="642" class="Keyword">open</a> <a id="647" class="Keyword">import</a> <a id="654" href="Level.html" class="Module">Level</a>           <a id="670" class="Keyword">using</a> <a id="676" class="Symbol">(</a> <a id="678" href="Agda.Primitive.html#597" class="Postulate">Level</a> <a id="684" class="Symbol">;</a> <a id="686" href="Level.html#400" class="Record">Lift</a> <a id="691" class="Symbol">;</a> <a id="693" href="Level.html#457" class="InductiveConstructor">lift</a> <a id="698" class="Symbol">;</a> <a id="700" href="Level.html#470" class="Field">lower</a> <a id="706" class="Symbol">)</a>
<a id="708" class="Keyword">open</a> <a id="713" class="Keyword">import</a> <a id="720" href="Relation.Unary.html" class="Module">Relation.Unary</a>  <a id="736" class="Keyword">using</a> <a id="742" class="Symbol">(</a> <a id="744" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="749" class="Symbol">;</a> <a id="751" href="Relation.Unary.html#1523" class="Function Operator">_∈_</a> <a id="755" class="Symbol">)</a>
<a id="757" class="Keyword">open</a> <a id="762" class="Keyword">import</a> <a id="769" href="Relation.Binary.html" class="Module">Relation.Binary</a> <a id="785" class="Keyword">using</a> <a id="791" class="Symbol">(</a> <a id="793" href="Relation.Binary.Structures.html#1522" class="Record">IsEquivalence</a> <a id="807" class="Symbol">)</a> <a id="809" class="Keyword">renaming</a> <a id="818" class="Symbol">(</a> <a id="820" href="Relation.Binary.Core.html#882" class="Function">Rel</a> <a id="824" class="Symbol">to</a> <a id="827" class="Function">BinRel</a> <a id="834" class="Symbol">)</a>
<a id="836" class="Keyword">open</a> <a id="841" class="Keyword">import</a> <a id="848" href="Relation.Binary.PropositionalEquality.html" class="Module">Relation.Binary.PropositionalEquality</a> <a id="886" class="Keyword">using</a> <a id="892" class="Symbol">(</a> <a id="894" href="Agda.Builtin.Equality.html#151" class="Datatype Operator">_≡_</a> <a id="898" class="Symbol">)</a>

<a id="901" class="Comment">-- Imports from the Agda Universal Algebra Library ---------------------------------------</a>
<a id="992" class="Keyword">open</a> <a id="997" class="Keyword">import</a> <a id="1004" href="Base.Overture.Preliminaries.html" class="Module">Base.Overture.Preliminaries</a>  <a id="1033" class="Keyword">using</a> <a id="1039" class="Symbol">(</a> <a id="1041" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣_∣</a> <a id="1045" class="Symbol">)</a>
<a id="1047" class="Keyword">open</a> <a id="1052" class="Keyword">import</a> <a id="1059" href="Base.Equality.Welldefined.html" class="Module">Base.Equality.Welldefined</a>    <a id="1088" class="Keyword">using</a> <a id="1094" class="Symbol">(</a> <a id="1096" href="Base.Equality.Welldefined.html#2671" class="Function">swelldef</a> <a id="1105" class="Symbol">)</a>
<a id="1107" class="Keyword">open</a> <a id="1112" class="Keyword">import</a> <a id="1119" href="Base.Relations.Discrete.html" class="Module">Base.Relations.Discrete</a>      <a id="1148" class="Keyword">using</a> <a id="1154" class="Symbol">(</a> <a id="1156" href="Base.Relations.Discrete.html#7006" class="Function Operator">_|:_</a> <a id="1161" class="Symbol">;</a> <a id="1163" href="Base.Relations.Discrete.html#4660" class="Function Operator">0[_]</a> <a id="1168" class="Symbol">)</a>
<a id="1170" class="Keyword">open</a> <a id="1175" class="Keyword">import</a> <a id="1182" href="Base.Relations.Quotients.html" class="Module">Base.Relations.Quotients</a>     <a id="1211" class="Keyword">using</a> <a id="1217" class="Symbol">(</a> <a id="1219" href="Base.Relations.Quotients.html#1836" class="Function">Equivalence</a> <a id="1231" class="Symbol">;</a> <a id="1233" href="Base.Relations.Quotients.html#5406" class="Function Operator">⟪_⟫</a> <a id="1237" class="Symbol">;</a> <a id="1239" href="Base.Relations.Quotients.html#5597" class="Function Operator">⌞_⌟</a> <a id="1243" class="Symbol">;</a> <a id="1245" href="Base.Relations.Quotients.html#7126" class="Function Operator">0[_]Equivalence</a> <a id="1261" class="Symbol">)</a>
                                         <a id="1304" class="Keyword">using</a> <a id="1310" class="Symbol">(</a> <a id="1312" href="Base.Relations.Quotients.html#5178" class="Function Operator">_/_</a> <a id="1316" class="Symbol">;</a> <a id="1318" href="Base.Relations.Quotients.html#7252" class="Function Operator">⟪_∼_⟫-elim</a> <a id="1329" class="Symbol">;</a> <a id="1331" href="Base.Relations.Quotients.html#5053" class="Function">Quotient</a> <a id="1340" class="Symbol">)</a>
<a id="1342" class="Keyword">open</a> <a id="1347" class="Keyword">import</a> <a id="1354" href="Base.Structures.Sigma.Basic.html" class="Module">Base.Structures.Sigma.Basic</a>  <a id="1383" class="Keyword">using</a> <a id="1389" class="Symbol">(</a> <a id="1391" href="Base.Structures.Sigma.Basic.html#1204" class="Function">Signature</a> <a id="1401" class="Symbol">;</a> <a id="1403" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="1413" class="Symbol">;</a> <a id="1415" href="Base.Structures.Sigma.Basic.html#2611" class="Function Operator">_ᵒ_</a> <a id="1419" class="Symbol">;</a> <a id="1421" href="Base.Structures.Sigma.Basic.html#2705" class="Function">Compatible</a> <a id="1432" class="Symbol">;</a> <a id="1434" href="Base.Structures.Sigma.Basic.html#2515" class="Function Operator">_ʳ_</a> <a id="1438" class="Symbol">)</a>

<a id="1441" class="Keyword">private</a> <a id="1449" class="Keyword">variable</a> <a id="1458" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="1460" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="1462" class="Symbol">:</a> <a id="1464" href="Base.Structures.Sigma.Basic.html#1204" class="Function">Signature</a>

<a id="1475" class="Keyword">module</a> <a id="1482" href="Base.Structures.Sigma.Congruences.html#1482" class="Module">_</a> <a id="1484" class="Symbol">{</a><a id="1485" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a> <a id="1487" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a> <a id="1489" class="Symbol">:</a> <a id="1491" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="1496" class="Symbol">}</a> <a id="1498" class="Keyword">where</a>

 <a id="1506" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="1510" class="Symbol">:</a> <a id="1512" class="Symbol">(</a><a id="1513" href="Base.Structures.Sigma.Congruences.html#1513" class="Bound">𝑨</a> <a id="1515" class="Symbol">:</a> <a id="1517" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="1527" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="1529" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="1531" class="Symbol">{</a><a id="1532" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a><a id="1533" class="Symbol">}{</a><a id="1535" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="1536" class="Symbol">})</a> <a id="1539" class="Symbol">→</a> <a id="1541" href="Base.Structures.Sigma.Congruences.html#494" class="Primitive">Type</a> <a id="1546" class="Symbol">(</a><a id="1547" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="1552" class="Symbol">(</a><a id="1553" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a> <a id="1555" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="1557" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="1558" class="Symbol">))</a>
 <a id="1562" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="1566" href="Base.Structures.Sigma.Congruences.html#1566" class="Bound">𝑨</a> <a id="1568" class="Symbol">=</a> <a id="1570" href="Data.Product.html#916" class="Function">Σ[</a> <a id="1573" href="Base.Structures.Sigma.Congruences.html#1573" class="Bound">θ</a> <a id="1575" href="Data.Product.html#916" class="Function">∈</a> <a id="1577" href="Base.Relations.Quotients.html#1836" class="Function">Equivalence</a> <a id="1589" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="1591" href="Base.Structures.Sigma.Congruences.html#1566" class="Bound">𝑨</a> <a id="1593" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="1594" class="Symbol">{</a><a id="1595" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a> <a id="1597" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="1599" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="1600" class="Symbol">}</a> <a id="1602" href="Data.Product.html#916" class="Function">]</a> <a id="1604" class="Symbol">(</a><a id="1605" href="Base.Structures.Sigma.Basic.html#2705" class="Function">Compatible</a> <a id="1616" href="Base.Structures.Sigma.Congruences.html#1566" class="Bound">𝑨</a> <a id="1618" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="1620" href="Base.Structures.Sigma.Congruences.html#1573" class="Bound">θ</a> <a id="1622" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="1623" class="Symbol">)</a>

 <a id="1627" class="Comment">-- The zero congruence of a structure.</a>
 <a id="1667" href="Base.Structures.Sigma.Congruences.html#1667" class="Function Operator">0[_]Compatible</a> <a id="1682" class="Symbol">:</a> <a id="1684" class="Symbol">(</a><a id="1685" href="Base.Structures.Sigma.Congruences.html#1685" class="Bound">𝑨</a> <a id="1687" class="Symbol">:</a> <a id="1689" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="1699" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="1701" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="1703" class="Symbol">{</a><a id="1704" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a><a id="1705" class="Symbol">}{</a><a id="1707" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="1708" class="Symbol">})</a> <a id="1711" class="Symbol">→</a> <a id="1713" href="Base.Equality.Welldefined.html#2671" class="Function">swelldef</a> <a id="1722" href="Base.Structures.Sigma.Congruences.html#510" class="Primitive">ℓ₀</a> <a id="1725" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a>
  <a id="1729" class="Symbol">→</a>               <a id="1745" class="Symbol">(</a><a id="1746" href="Base.Structures.Sigma.Congruences.html#1746" class="Bound">𝑓</a> <a id="1748" class="Symbol">:</a> <a id="1750" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="1752" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="1754" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="1755" class="Symbol">)</a> <a id="1757" class="Symbol">→</a> <a id="1759" class="Symbol">(</a><a id="1760" href="Base.Structures.Sigma.Congruences.html#1746" class="Bound">𝑓</a> <a id="1762" href="Base.Structures.Sigma.Basic.html#2611" class="Function Operator">ᵒ</a> <a id="1764" href="Base.Structures.Sigma.Congruences.html#1685" class="Bound">𝑨</a><a id="1765" class="Symbol">)</a> <a id="1767" href="Base.Relations.Discrete.html#7006" class="Function Operator">|:</a> <a id="1770" class="Symbol">(</a><a id="1771" href="Base.Relations.Discrete.html#4660" class="Function Operator">0[</a> <a id="1774" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="1776" href="Base.Structures.Sigma.Congruences.html#1685" class="Bound">𝑨</a> <a id="1778" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="1780" href="Base.Relations.Discrete.html#4660" class="Function Operator">]</a><a id="1781" class="Symbol">{</a><a id="1782" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="1783" class="Symbol">})</a>

 <a id="1788" href="Base.Structures.Sigma.Congruences.html#1667" class="Function Operator">0[</a> <a id="1791" href="Base.Structures.Sigma.Congruences.html#1791" class="Bound">𝑨</a> <a id="1793" href="Base.Structures.Sigma.Congruences.html#1667" class="Function Operator">]Compatible</a> <a id="1805" href="Base.Structures.Sigma.Congruences.html#1805" class="Bound">wd</a> <a id="1808" href="Base.Structures.Sigma.Congruences.html#1808" class="Bound">𝑓</a> <a id="1810" class="Symbol">{</a><a id="1811" href="Base.Structures.Sigma.Congruences.html#1811" class="Bound">i</a><a id="1812" class="Symbol">}{</a><a id="1814" href="Base.Structures.Sigma.Congruences.html#1814" class="Bound">j</a><a id="1815" class="Symbol">}</a> <a id="1817" href="Base.Structures.Sigma.Congruences.html#1817" class="Bound">ptws0</a>  <a id="1824" class="Symbol">=</a> <a id="1826" href="Level.html#457" class="InductiveConstructor">lift</a> <a id="1831" href="Base.Structures.Sigma.Congruences.html#1843" class="Function">γ</a>
  <a id="1835" class="Keyword">where</a>
  <a id="1843" href="Base.Structures.Sigma.Congruences.html#1843" class="Function">γ</a> <a id="1845" class="Symbol">:</a> <a id="1847" class="Symbol">(</a><a id="1848" href="Base.Structures.Sigma.Congruences.html#1808" class="Bound">𝑓</a> <a id="1850" href="Base.Structures.Sigma.Basic.html#2611" class="Function Operator">ᵒ</a> <a id="1852" href="Base.Structures.Sigma.Congruences.html#1791" class="Bound">𝑨</a><a id="1853" class="Symbol">)</a> <a id="1855" href="Base.Structures.Sigma.Congruences.html#1811" class="Bound">i</a> <a id="1857" href="Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="1859" class="Symbol">(</a><a id="1860" href="Base.Structures.Sigma.Congruences.html#1808" class="Bound">𝑓</a> <a id="1862" href="Base.Structures.Sigma.Basic.html#2611" class="Function Operator">ᵒ</a> <a id="1864" href="Base.Structures.Sigma.Congruences.html#1791" class="Bound">𝑨</a><a id="1865" class="Symbol">)</a> <a id="1867" href="Base.Structures.Sigma.Congruences.html#1814" class="Bound">j</a>
  <a id="1871" href="Base.Structures.Sigma.Congruences.html#1843" class="Function">γ</a> <a id="1873" class="Symbol">=</a> <a id="1875" href="Base.Structures.Sigma.Congruences.html#1805" class="Bound">wd</a> <a id="1878" class="Symbol">(</a><a id="1879" href="Base.Structures.Sigma.Congruences.html#1808" class="Bound">𝑓</a> <a id="1881" href="Base.Structures.Sigma.Basic.html#2611" class="Function Operator">ᵒ</a> <a id="1883" href="Base.Structures.Sigma.Congruences.html#1791" class="Bound">𝑨</a><a id="1884" class="Symbol">)</a> <a id="1886" href="Base.Structures.Sigma.Congruences.html#1811" class="Bound">i</a> <a id="1888" href="Base.Structures.Sigma.Congruences.html#1814" class="Bound">j</a> <a id="1890" class="Symbol">(</a><a id="1891" href="Level.html#470" class="Field">lower</a> <a id="1897" href="Function.Base.html#1031" class="Function Operator">∘</a> <a id="1899" href="Base.Structures.Sigma.Congruences.html#1817" class="Bound">ptws0</a><a id="1904" class="Symbol">)</a>

 <a id="1908" href="Base.Structures.Sigma.Congruences.html#1908" class="Function Operator">0Con[_]</a> <a id="1916" class="Symbol">:</a> <a id="1918" class="Symbol">(</a><a id="1919" href="Base.Structures.Sigma.Congruences.html#1919" class="Bound">𝑨</a> <a id="1921" class="Symbol">:</a> <a id="1923" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="1933" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="1935" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="1937" class="Symbol">{</a><a id="1938" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a><a id="1939" class="Symbol">}{</a><a id="1941" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="1942" class="Symbol">})</a> <a id="1945" class="Symbol">→</a> <a id="1947" href="Base.Equality.Welldefined.html#2671" class="Function">swelldef</a> <a id="1956" href="Base.Structures.Sigma.Congruences.html#510" class="Primitive">ℓ₀</a> <a id="1959" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a> <a id="1961" class="Symbol">→</a> <a id="1963" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="1967" href="Base.Structures.Sigma.Congruences.html#1919" class="Bound">𝑨</a>
 <a id="1970" href="Base.Structures.Sigma.Congruences.html#1908" class="Function Operator">0Con[</a> <a id="1976" href="Base.Structures.Sigma.Congruences.html#1976" class="Bound">𝑨</a> <a id="1978" href="Base.Structures.Sigma.Congruences.html#1908" class="Function Operator">]</a> <a id="1980" href="Base.Structures.Sigma.Congruences.html#1980" class="Bound">wd</a> <a id="1983" class="Symbol">=</a> <a id="1985" href="Base.Relations.Quotients.html#7126" class="Function Operator">0[</a> <a id="1988" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="1990" href="Base.Structures.Sigma.Congruences.html#1976" class="Bound">𝑨</a> <a id="1992" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="1994" href="Base.Relations.Quotients.html#7126" class="Function Operator">]Equivalence</a> <a id="2007" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="2009" href="Base.Structures.Sigma.Congruences.html#1667" class="Function Operator">0[</a> <a id="2012" href="Base.Structures.Sigma.Congruences.html#1976" class="Bound">𝑨</a> <a id="2014" href="Base.Structures.Sigma.Congruences.html#1667" class="Function Operator">]Compatible</a> <a id="2026" href="Base.Structures.Sigma.Congruences.html#1980" class="Bound">wd</a>

</pre>


#### <a id="quotient-structures">Quotients of structures of sigma type</a>

<pre class="Agda">

 <a id="2134" href="Base.Structures.Sigma.Congruences.html#2134" class="Function Operator">_╱_</a> <a id="2138" class="Symbol">:</a> <a id="2140" class="Symbol">(</a><a id="2141" href="Base.Structures.Sigma.Congruences.html#2141" class="Bound">𝑨</a> <a id="2143" class="Symbol">:</a> <a id="2145" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="2155" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="2157" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="2159" class="Symbol">{</a><a id="2160" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a><a id="2161" class="Symbol">}{</a><a id="2163" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="2164" class="Symbol">})</a> <a id="2167" class="Symbol">→</a> <a id="2169" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="2173" href="Base.Structures.Sigma.Congruences.html#2141" class="Bound">𝑨</a> <a id="2175" class="Symbol">→</a> <a id="2177" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="2187" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="2189" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="2191" class="Symbol">{</a><a id="2192" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="2197" class="Symbol">(</a><a id="2198" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a> <a id="2200" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="2202" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="2203" class="Symbol">)}{</a><a id="2206" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="2207" class="Symbol">}</a>

 <a id="2211" href="Base.Structures.Sigma.Congruences.html#2211" class="Bound">𝑨</a> <a id="2213" href="Base.Structures.Sigma.Congruences.html#2134" class="Function Operator">╱</a> <a id="2215" href="Base.Structures.Sigma.Congruences.html#2215" class="Bound">θ</a> <a id="2217" class="Symbol">=</a> <a id="2219" class="Symbol">(</a><a id="2220" href="Base.Relations.Quotients.html#5053" class="Function">Quotient</a> <a id="2229" class="Symbol">(</a><a id="2230" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2232" href="Base.Structures.Sigma.Congruences.html#2211" class="Bound">𝑨</a> <a id="2234" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="2235" class="Symbol">)</a> <a id="2237" class="Symbol">{</a><a id="2238" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a> <a id="2240" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="2242" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="2243" class="Symbol">}</a> <a id="2245" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2247" href="Base.Structures.Sigma.Congruences.html#2215" class="Bound">θ</a> <a id="2249" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="2250" class="Symbol">)</a>        <a id="2259" class="Comment">-- domain of quotient structure</a>
          <a id="2301" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="2303" class="Symbol">(λ</a> <a id="2306" href="Base.Structures.Sigma.Congruences.html#2306" class="Bound">r</a> <a id="2308" href="Base.Structures.Sigma.Congruences.html#2308" class="Bound">x</a> <a id="2310" class="Symbol">→</a> <a id="2312" class="Symbol">(</a><a id="2313" href="Base.Structures.Sigma.Congruences.html#2306" class="Bound">r</a> <a id="2315" href="Base.Structures.Sigma.Basic.html#2515" class="Function Operator">ʳ</a> <a id="2317" href="Base.Structures.Sigma.Congruences.html#2211" class="Bound">𝑨</a><a id="2318" class="Symbol">)</a> <a id="2320" class="Symbol">λ</a> <a id="2322" href="Base.Structures.Sigma.Congruences.html#2322" class="Bound">i</a> <a id="2324" class="Symbol">→</a> <a id="2326" href="Base.Relations.Quotients.html#5597" class="Function Operator">⌞</a> <a id="2328" href="Base.Structures.Sigma.Congruences.html#2308" class="Bound">x</a> <a id="2330" href="Base.Structures.Sigma.Congruences.html#2322" class="Bound">i</a> <a id="2332" href="Base.Relations.Quotients.html#5597" class="Function Operator">⌟</a><a id="2333" class="Symbol">)</a>      <a id="2340" class="Comment">-- interpretation of relations</a>
          <a id="2381" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="2383" class="Symbol">λ</a> <a id="2385" href="Base.Structures.Sigma.Congruences.html#2385" class="Bound">f</a> <a id="2387" href="Base.Structures.Sigma.Congruences.html#2387" class="Bound">b</a> <a id="2389" class="Symbol">→</a> <a id="2391" href="Base.Relations.Quotients.html#5406" class="Function Operator">⟪</a> <a id="2393" class="Symbol">(</a><a id="2394" href="Base.Structures.Sigma.Congruences.html#2385" class="Bound">f</a> <a id="2396" href="Base.Structures.Sigma.Basic.html#2611" class="Function Operator">ᵒ</a> <a id="2398" href="Base.Structures.Sigma.Congruences.html#2211" class="Bound">𝑨</a><a id="2399" class="Symbol">)</a> <a id="2401" class="Symbol">(λ</a> <a id="2404" href="Base.Structures.Sigma.Congruences.html#2404" class="Bound">i</a> <a id="2406" class="Symbol">→</a> <a id="2408" href="Base.Relations.Quotients.html#5597" class="Function Operator">⌞</a> <a id="2410" href="Base.Structures.Sigma.Congruences.html#2387" class="Bound">b</a> <a id="2412" href="Base.Structures.Sigma.Congruences.html#2404" class="Bound">i</a> <a id="2414" href="Base.Relations.Quotients.html#5597" class="Function Operator">⌟</a><a id="2415" class="Symbol">)</a>  <a id="2418" href="Base.Relations.Quotients.html#5406" class="Function Operator">⟫</a> <a id="2420" class="Comment">-- interp of operations</a>

 <a id="2446" href="Base.Structures.Sigma.Congruences.html#2446" class="Function">/≡-elim</a> <a id="2454" class="Symbol">:</a> <a id="2456" class="Symbol">{</a><a id="2457" href="Base.Structures.Sigma.Congruences.html#2457" class="Bound">𝑨</a> <a id="2459" class="Symbol">:</a> <a id="2461" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="2471" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="2473" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="2475" class="Symbol">{</a><a id="2476" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a><a id="2477" class="Symbol">}{</a><a id="2479" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="2480" class="Symbol">}}(</a> <a id="2484" href="Base.Structures.Sigma.Congruences.html#2484" class="Symbol">(</a><a id="2485" href="Base.Structures.Sigma.Congruences.html#2485" class="Bound">θ</a> <a id="2487" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="2489" href="Base.Structures.Sigma.Congruences.html#2484" class="Symbol">_</a> <a id="2491" href="Base.Structures.Sigma.Congruences.html#2484" class="Symbol">)</a> <a id="2493" class="Symbol">:</a> <a id="2495" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="2499" href="Base.Structures.Sigma.Congruences.html#2457" class="Bound">𝑨</a><a id="2500" class="Symbol">){</a><a id="2502" href="Base.Structures.Sigma.Congruences.html#2502" class="Bound">u</a> <a id="2504" href="Base.Structures.Sigma.Congruences.html#2504" class="Bound">v</a> <a id="2506" class="Symbol">:</a> <a id="2508" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2510" href="Base.Structures.Sigma.Congruences.html#2457" class="Bound">𝑨</a> <a id="2512" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="2513" class="Symbol">}</a>
  <a id="2517" class="Symbol">→</a>    <a id="2522" href="Base.Relations.Quotients.html#5406" class="Function Operator">⟪</a> <a id="2524" href="Base.Structures.Sigma.Congruences.html#2502" class="Bound">u</a> <a id="2526" href="Base.Relations.Quotients.html#5406" class="Function Operator">⟫</a><a id="2527" class="Symbol">{</a><a id="2528" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2530" href="Base.Structures.Sigma.Congruences.html#2485" class="Bound">θ</a> <a id="2532" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="2533" class="Symbol">}</a> <a id="2535" href="Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="2537" href="Base.Relations.Quotients.html#5406" class="Function Operator">⟪</a> <a id="2539" href="Base.Structures.Sigma.Congruences.html#2504" class="Bound">v</a> <a id="2541" href="Base.Relations.Quotients.html#5406" class="Function Operator">⟫</a> <a id="2543" class="Symbol">→</a> <a id="2545" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2547" href="Base.Structures.Sigma.Congruences.html#2485" class="Bound">θ</a> <a id="2549" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2551" href="Base.Structures.Sigma.Congruences.html#2502" class="Bound">u</a> <a id="2553" href="Base.Structures.Sigma.Congruences.html#2504" class="Bound">v</a>
 <a id="2556" href="Base.Structures.Sigma.Congruences.html#2446" class="Function">/≡-elim</a> <a id="2564" href="Base.Structures.Sigma.Congruences.html#2564" class="Bound">θ</a> <a id="2566" class="Symbol">{</a><a id="2567" href="Base.Structures.Sigma.Congruences.html#2567" class="Bound">u</a><a id="2568" class="Symbol">}{</a><a id="2570" href="Base.Structures.Sigma.Congruences.html#2570" class="Bound">v</a><a id="2571" class="Symbol">}</a> <a id="2573" href="Base.Structures.Sigma.Congruences.html#2573" class="Bound">x</a> <a id="2575" class="Symbol">=</a>  <a id="2578" href="Base.Relations.Quotients.html#7252" class="Function Operator">⟪</a> <a id="2580" href="Base.Structures.Sigma.Congruences.html#2567" class="Bound">u</a> <a id="2582" href="Base.Relations.Quotients.html#7252" class="Function Operator">∼</a> <a id="2584" href="Base.Structures.Sigma.Congruences.html#2570" class="Bound">v</a> <a id="2586" href="Base.Relations.Quotients.html#7252" class="Function Operator">⟫-elim</a> <a id="2593" class="Symbol">{</a><a id="2594" class="Argument">R</a> <a id="2596" class="Symbol">=</a> <a id="2598" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2600" href="Base.Structures.Sigma.Congruences.html#2564" class="Bound">θ</a> <a id="2602" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="2603" class="Symbol">}</a> <a id="2605" href="Base.Structures.Sigma.Congruences.html#2573" class="Bound">x</a>

</pre>

#### <a id="the-zero-congruence-of-an-arbitrary-structure">The zero congruence of an arbitrary structure</a>

<pre class="Agda">

 <a id="2745" href="Base.Structures.Sigma.Congruences.html#2745" class="Function Operator">𝟘[_╱_]</a> <a id="2752" class="Symbol">:</a> <a id="2754" class="Symbol">(</a><a id="2755" href="Base.Structures.Sigma.Congruences.html#2755" class="Bound">𝑨</a> <a id="2757" class="Symbol">:</a> <a id="2759" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="2769" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="2771" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="2773" class="Symbol">{</a><a id="2774" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a><a id="2775" class="Symbol">}{</a><a id="2777" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="2778" class="Symbol">})(</a><a id="2781" href="Base.Structures.Sigma.Congruences.html#2781" class="Bound">θ</a> <a id="2783" class="Symbol">:</a> <a id="2785" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="2789" href="Base.Structures.Sigma.Congruences.html#2755" class="Bound">𝑨</a><a id="2790" class="Symbol">)</a> <a id="2792" class="Symbol">→</a> <a id="2794" href="Base.Structures.Sigma.Congruences.html#827" class="Function">BinRel</a> <a id="2801" class="Symbol">(</a><a id="2802" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2804" href="Base.Structures.Sigma.Congruences.html#2755" class="Bound">𝑨</a> <a id="2806" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2808" href="Base.Relations.Quotients.html#5178" class="Function Operator">/</a> <a id="2810" class="Symbol">(</a><a id="2811" href="Base.Structures.Sigma.Congruences.html#594" class="Field">fst</a> <a id="2815" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2817" href="Base.Structures.Sigma.Congruences.html#2781" class="Bound">θ</a> <a id="2819" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a><a id="2820" class="Symbol">))</a> <a id="2823" class="Symbol">(</a><a id="2824" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="2829" class="Symbol">(</a><a id="2830" href="Base.Structures.Sigma.Congruences.html#1485" class="Bound">α</a> <a id="2832" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="2834" href="Base.Structures.Sigma.Congruences.html#1487" class="Bound">ρ</a><a id="2835" class="Symbol">))</a>
 <a id="2839" href="Base.Structures.Sigma.Congruences.html#2745" class="Function Operator">𝟘[</a> <a id="2842" href="Base.Structures.Sigma.Congruences.html#2842" class="Bound">𝑨</a> <a id="2844" href="Base.Structures.Sigma.Congruences.html#2745" class="Function Operator">╱</a> <a id="2846" href="Base.Structures.Sigma.Congruences.html#2846" class="Bound">θ</a> <a id="2848" href="Base.Structures.Sigma.Congruences.html#2745" class="Function Operator">]</a> <a id="2850" class="Symbol">=</a> <a id="2852" class="Symbol">λ</a> <a id="2854" href="Base.Structures.Sigma.Congruences.html#2854" class="Bound">u</a> <a id="2856" href="Base.Structures.Sigma.Congruences.html#2856" class="Bound">v</a> <a id="2858" class="Symbol">→</a> <a id="2860" href="Base.Structures.Sigma.Congruences.html#2854" class="Bound">u</a> <a id="2862" href="Agda.Builtin.Equality.html#151" class="Datatype Operator">≡</a> <a id="2864" href="Base.Structures.Sigma.Congruences.html#2856" class="Bound">v</a>

<a id="𝟎[_╱_]"></a><a id="2867" href="Base.Structures.Sigma.Congruences.html#2867" class="Function Operator">𝟎[_╱_]</a> <a id="2874" class="Symbol">:</a> <a id="2876" class="Symbol">{</a><a id="2877" href="Base.Structures.Sigma.Congruences.html#2877" class="Bound">α</a> <a id="2879" href="Base.Structures.Sigma.Congruences.html#2879" class="Bound">ρ</a> <a id="2881" class="Symbol">:</a> <a id="2883" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="2888" class="Symbol">}(</a><a id="2890" href="Base.Structures.Sigma.Congruences.html#2890" class="Bound">𝑨</a> <a id="2892" class="Symbol">:</a> <a id="2894" href="Base.Structures.Sigma.Basic.html#1365" class="Function">Structure</a> <a id="2904" href="Base.Structures.Sigma.Congruences.html#1458" class="Generalizable">𝑅</a> <a id="2906" href="Base.Structures.Sigma.Congruences.html#1460" class="Generalizable">𝐹</a> <a id="2908" class="Symbol">{</a><a id="2909" href="Base.Structures.Sigma.Congruences.html#2877" class="Bound">α</a><a id="2910" class="Symbol">}{</a><a id="2912" href="Base.Structures.Sigma.Congruences.html#2879" class="Bound">ρ</a><a id="2913" class="Symbol">})(</a><a id="2916" href="Base.Structures.Sigma.Congruences.html#2916" class="Bound">θ</a> <a id="2918" class="Symbol">:</a> <a id="2920" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="2924" href="Base.Structures.Sigma.Congruences.html#2890" class="Bound">𝑨</a><a id="2925" class="Symbol">)</a> <a id="2927" class="Symbol">→</a> <a id="2929" href="Base.Equality.Welldefined.html#2671" class="Function">swelldef</a> <a id="2938" href="Base.Structures.Sigma.Congruences.html#510" class="Primitive">ℓ₀</a> <a id="2941" class="Symbol">(</a><a id="2942" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="2947" class="Symbol">(</a><a id="2948" href="Base.Structures.Sigma.Congruences.html#2877" class="Bound">α</a> <a id="2950" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="2952" href="Base.Structures.Sigma.Congruences.html#2879" class="Bound">ρ</a><a id="2953" class="Symbol">))</a> <a id="2956" class="Symbol">→</a> <a id="2958" href="Base.Structures.Sigma.Congruences.html#1506" class="Function">Con</a> <a id="2962" class="Symbol">(</a><a id="2963" href="Base.Structures.Sigma.Congruences.html#2890" class="Bound">𝑨</a> <a id="2965" href="Base.Structures.Sigma.Congruences.html#2134" class="Function Operator">╱</a> <a id="2967" href="Base.Structures.Sigma.Congruences.html#2916" class="Bound">θ</a><a id="2968" class="Symbol">)</a>
<a id="2970" href="Base.Structures.Sigma.Congruences.html#2867" class="Function Operator">𝟎[</a> <a id="2973" href="Base.Structures.Sigma.Congruences.html#2973" class="Bound">𝑨</a> <a id="2975" href="Base.Structures.Sigma.Congruences.html#2867" class="Function Operator">╱</a> <a id="2977" href="Base.Structures.Sigma.Congruences.html#2977" class="Bound">θ</a> <a id="2979" href="Base.Structures.Sigma.Congruences.html#2867" class="Function Operator">]</a> <a id="2981" href="Base.Structures.Sigma.Congruences.html#2981" class="Bound">wd</a> <a id="2984" class="Symbol">=</a> <a id="2986" href="Base.Relations.Quotients.html#7126" class="Function Operator">0[</a> <a id="2989" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2991" href="Base.Structures.Sigma.Congruences.html#2973" class="Bound">𝑨</a> <a id="2993" href="Base.Structures.Sigma.Congruences.html#2134" class="Function Operator">╱</a> <a id="2995" href="Base.Structures.Sigma.Congruences.html#2977" class="Bound">θ</a> <a id="2997" href="Base.Overture.Preliminaries.html#4402" class="Function Operator">∣</a> <a id="2999" href="Base.Relations.Quotients.html#7126" class="Function Operator">]Equivalence</a> <a id="3012" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="3014" href="Base.Structures.Sigma.Congruences.html#1667" class="Function Operator">0[</a> <a id="3017" href="Base.Structures.Sigma.Congruences.html#2973" class="Bound">𝑨</a> <a id="3019" href="Base.Structures.Sigma.Congruences.html#2134" class="Function Operator">╱</a> <a id="3021" href="Base.Structures.Sigma.Congruences.html#2977" class="Bound">θ</a> <a id="3023" href="Base.Structures.Sigma.Congruences.html#1667" class="Function Operator">]Compatible</a> <a id="3035" href="Base.Structures.Sigma.Congruences.html#2981" class="Bound">wd</a>

</pre>

--------------------------------

<span style="float:left;">[← Base.Structures.Sigma.Products](Base.Structures.Sigma.Products.html)</span>
<span style="float:right;">[Base.Structures.Sigma.Homs →](Base.Structures.Sigma.Homs.html)</span>

{% include UALib.Links.md %}