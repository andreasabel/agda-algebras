---
layout: default
title : Structures.EquationalLogic
date : 2021-07-23
author: [agda-algebras development team][]
---

## <a id="equational-logic-for-general-structures">Equational Logic for General Structures</a>

This is the [Structures.EquationalLogic][] module of the [Agda Universal Algebra Library][].

<pre class="Agda">

<a id="326" class="Symbol">{-#</a> <a id="330" class="Keyword">OPTIONS</a> <a id="338" class="Pragma">--without-K</a> <a id="350" class="Pragma">--exact-split</a> <a id="364" class="Pragma">--safe</a> <a id="371" class="Symbol">#-}</a>

<a id="376" class="Keyword">module</a> <a id="383" href="Structures.EquationalLogic.html" class="Module">Structures.EquationalLogic</a> <a id="410" class="Keyword">where</a>

<a id="417" class="Comment">-- Imports from Agda and the Agda Standard Library --------------------------------------</a>
<a id="507" class="Keyword">open</a> <a id="512" class="Keyword">import</a> <a id="519" href="Agda.Primitive.html" class="Module">Agda.Primitive</a> <a id="534" class="Keyword">using</a> <a id="540" class="Symbol">(</a> <a id="542" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="547" class="Symbol">;</a> <a id="549" href="Agda.Primitive.html#810" class="Primitive Operator">_⊔_</a> <a id="553" class="Symbol">;</a> <a id="555" href="Agda.Primitive.html#597" class="Postulate">Level</a> <a id="561" class="Symbol">)</a> <a id="563" class="Keyword">renaming</a> <a id="572" class="Symbol">(</a> <a id="574" href="Agda.Primitive.html#326" class="Primitive">Set</a> <a id="578" class="Symbol">to</a> <a id="581" class="Primitive">Type</a> <a id="586" class="Symbol">)</a>
<a id="588" class="Keyword">open</a> <a id="593" class="Keyword">import</a> <a id="600" href="Data.Fin.Base.html" class="Module">Data.Fin.Base</a>  <a id="615" class="Keyword">using</a> <a id="621" class="Symbol">(</a> <a id="623" href="Data.Fin.Base.html#1126" class="Datatype">Fin</a> <a id="627" class="Symbol">)</a>
<a id="629" class="Keyword">open</a> <a id="634" class="Keyword">import</a> <a id="641" href="Data.Nat.html" class="Module">Data.Nat</a>       <a id="656" class="Keyword">using</a> <a id="662" class="Symbol">(</a> <a id="664" href="Agda.Builtin.Nat.html#192" class="Datatype">ℕ</a> <a id="666" class="Symbol">)</a>
<a id="668" class="Keyword">open</a> <a id="673" class="Keyword">import</a> <a id="680" href="Data.Product.html" class="Module">Data.Product</a>   <a id="695" class="Keyword">using</a> <a id="701" class="Symbol">(</a> <a id="703" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">_,_</a> <a id="707" class="Symbol">;</a>  <a id="710" href="Data.Product.html#1167" class="Function Operator">_×_</a> <a id="714" class="Symbol">)</a> <a id="716" class="Keyword">renaming</a> <a id="725" class="Symbol">(</a> <a id="727" href="Agda.Builtin.Sigma.html#252" class="Field">proj₁</a> <a id="733" class="Symbol">to</a> <a id="736" class="Field">fst</a> <a id="740" class="Symbol">;</a> <a id="742" href="Agda.Builtin.Sigma.html#264" class="Field">proj₂</a> <a id="748" class="Symbol">to</a> <a id="751" class="Field">snd</a> <a id="755" class="Symbol">)</a>
<a id="757" class="Keyword">open</a> <a id="762" class="Keyword">import</a> <a id="769" href="Relation.Unary.html" class="Module">Relation.Unary</a> <a id="784" class="Keyword">using</a> <a id="790" class="Symbol">(</a> <a id="792" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="797" class="Symbol">;</a> <a id="799" href="Relation.Unary.html#1523" class="Function Operator">_∈_</a> <a id="803" class="Symbol">)</a>

<a id="806" class="Comment">-- Imports from the Agda Universal Algebra Library --------------------------------------</a>
<a id="896" class="Keyword">open</a> <a id="901" class="Keyword">import</a> <a id="908" href="Overture.Preliminaries.html" class="Module">Overture.Preliminaries</a> <a id="931" class="Keyword">using</a> <a id="937" class="Symbol">(</a> <a id="939" href="Overture.Preliminaries.html#9602" class="Function Operator">_≈_</a> <a id="943" class="Symbol">)</a>
<a id="945" class="Keyword">open</a> <a id="950" class="Keyword">import</a> <a id="957" href="Terms.Basic.html" class="Module">Terms.Basic</a>
<a id="969" class="Keyword">open</a> <a id="974" class="Keyword">import</a> <a id="981" href="Structures.Basic.html" class="Module">Structures.Basic</a>       <a id="1004" class="Keyword">using</a> <a id="1010" class="Symbol">(</a> <a id="1012" href="Structures.Basic.html#1231" class="Record">signature</a> <a id="1022" class="Symbol">;</a> <a id="1024" href="Structures.Basic.html#1565" class="Record">structure</a> <a id="1034" class="Symbol">;</a> <a id="1036" href="Structures.Basic.html#2197" class="Function Operator">_ᵒ_</a> <a id="1040" class="Symbol">)</a>
<a id="1042" class="Keyword">open</a> <a id="1047" class="Keyword">import</a> <a id="1054" href="Structures.Terms.html" class="Module">Structures.Terms</a>


<a id="1073" class="Keyword">private</a> <a id="1081" class="Keyword">variable</a>
 <a id="1091" href="Structures.EquationalLogic.html#1091" class="Generalizable">𝓞₀</a> <a id="1094" href="Structures.EquationalLogic.html#1094" class="Generalizable">𝓥₀</a> <a id="1097" href="Structures.EquationalLogic.html#1097" class="Generalizable">𝓞₁</a> <a id="1100" href="Structures.EquationalLogic.html#1100" class="Generalizable">𝓥₁</a> <a id="1103" href="Structures.EquationalLogic.html#1103" class="Generalizable">χ</a> <a id="1105" href="Structures.EquationalLogic.html#1105" class="Generalizable">α</a> <a id="1107" href="Structures.EquationalLogic.html#1107" class="Generalizable">ρ</a> <a id="1109" href="Structures.EquationalLogic.html#1109" class="Generalizable">ℓ</a> <a id="1111" class="Symbol">:</a> <a id="1113" href="Agda.Primitive.html#597" class="Postulate">Level</a>
 <a id="1120" href="Structures.EquationalLogic.html#1120" class="Generalizable">𝐹</a> <a id="1122" class="Symbol">:</a> <a id="1124" href="Structures.Basic.html#1231" class="Record">signature</a> <a id="1134" href="Structures.EquationalLogic.html#1091" class="Generalizable">𝓞₀</a> <a id="1137" href="Structures.EquationalLogic.html#1094" class="Generalizable">𝓥₀</a>
 <a id="1141" href="Structures.EquationalLogic.html#1141" class="Generalizable">𝑅</a> <a id="1143" class="Symbol">:</a> <a id="1145" href="Structures.Basic.html#1231" class="Record">signature</a> <a id="1155" href="Structures.EquationalLogic.html#1097" class="Generalizable">𝓞₁</a> <a id="1158" href="Structures.EquationalLogic.html#1100" class="Generalizable">𝓥₁</a>
 <a id="1162" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1164" class="Symbol">:</a> <a id="1166" href="Structures.EquationalLogic.html#581" class="Primitive">Type</a> <a id="1171" href="Structures.EquationalLogic.html#1103" class="Generalizable">χ</a>

<a id="1174" class="Comment">-- Entailment, equational theories, and models</a>

<a id="_⊧_≈_"></a><a id="1222" href="Structures.EquationalLogic.html#1222" class="Function Operator">_⊧_≈_</a> <a id="1228" class="Symbol">:</a> <a id="1230" href="Structures.Basic.html#1565" class="Record">structure</a> <a id="1240" href="Structures.EquationalLogic.html#1120" class="Generalizable">𝐹</a> <a id="1242" href="Structures.EquationalLogic.html#1141" class="Generalizable">𝑅</a> <a id="1244" class="Symbol">{</a><a id="1245" href="Structures.EquationalLogic.html#1105" class="Generalizable">α</a><a id="1246" class="Symbol">}{</a><a id="1248" href="Structures.EquationalLogic.html#1107" class="Generalizable">ρ</a><a id="1249" class="Symbol">}</a> <a id="1251" class="Symbol">→</a> <a id="1253" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1258" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1260" class="Symbol">→</a> <a id="1262" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1267" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1269" class="Symbol">→</a> <a id="1271" href="Structures.EquationalLogic.html#581" class="Primitive">Type</a> <a id="1276" class="Symbol">_</a>
<a id="1278" href="Structures.EquationalLogic.html#1278" class="Bound">𝑨</a> <a id="1280" href="Structures.EquationalLogic.html#1222" class="Function Operator">⊧</a> <a id="1282" href="Structures.EquationalLogic.html#1282" class="Bound">p</a> <a id="1284" href="Structures.EquationalLogic.html#1222" class="Function Operator">≈</a> <a id="1286" href="Structures.EquationalLogic.html#1286" class="Bound">q</a> <a id="1288" class="Symbol">=</a> <a id="1290" href="Structures.EquationalLogic.html#1278" class="Bound">𝑨</a> <a id="1292" href="Structures.Terms.html#1466" class="Function Operator">⟦</a> <a id="1294" href="Structures.EquationalLogic.html#1282" class="Bound">p</a> <a id="1296" href="Structures.Terms.html#1466" class="Function Operator">⟧</a> <a id="1298" href="Overture.Preliminaries.html#9602" class="Function Operator">≈</a> <a id="1300" href="Structures.EquationalLogic.html#1278" class="Bound">𝑨</a> <a id="1302" href="Structures.Terms.html#1466" class="Function Operator">⟦</a> <a id="1304" href="Structures.EquationalLogic.html#1286" class="Bound">q</a> <a id="1306" href="Structures.Terms.html#1466" class="Function Operator">⟧</a>

<a id="_⊧_≋_"></a><a id="1309" href="Structures.EquationalLogic.html#1309" class="Function Operator">_⊧_≋_</a> <a id="1315" class="Symbol">:</a> <a id="1317" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="1321" class="Symbol">(</a><a id="1322" href="Structures.Basic.html#1565" class="Record">structure</a> <a id="1332" href="Structures.EquationalLogic.html#1120" class="Generalizable">𝐹</a> <a id="1334" href="Structures.EquationalLogic.html#1141" class="Generalizable">𝑅</a> <a id="1336" class="Symbol">{</a><a id="1337" href="Structures.EquationalLogic.html#1105" class="Generalizable">α</a><a id="1338" class="Symbol">}{</a><a id="1340" href="Structures.EquationalLogic.html#1107" class="Generalizable">ρ</a><a id="1341" class="Symbol">})</a> <a id="1344" href="Structures.EquationalLogic.html#1109" class="Generalizable">ℓ</a> <a id="1346" class="Symbol">→</a> <a id="1348" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1353" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1355" class="Symbol">→</a> <a id="1357" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1362" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1364" class="Symbol">→</a> <a id="1366" href="Structures.EquationalLogic.html#581" class="Primitive">Type</a> <a id="1371" class="Symbol">_</a>
<a id="1373" href="Structures.EquationalLogic.html#1373" class="Bound">𝒦</a> <a id="1375" href="Structures.EquationalLogic.html#1309" class="Function Operator">⊧</a> <a id="1377" href="Structures.EquationalLogic.html#1377" class="Bound">p</a> <a id="1379" href="Structures.EquationalLogic.html#1309" class="Function Operator">≋</a> <a id="1381" href="Structures.EquationalLogic.html#1381" class="Bound">q</a> <a id="1383" class="Symbol">=</a> <a id="1385" class="Symbol">∀{</a><a id="1387" href="Structures.EquationalLogic.html#1387" class="Bound">𝑨</a> <a id="1389" class="Symbol">:</a> <a id="1391" href="Structures.Basic.html#1565" class="Record">structure</a> <a id="1401" class="Symbol">_</a> <a id="1403" class="Symbol">_}</a> <a id="1406" class="Symbol">→</a> <a id="1408" href="Structures.EquationalLogic.html#1373" class="Bound">𝒦</a> <a id="1410" href="Structures.EquationalLogic.html#1387" class="Bound">𝑨</a> <a id="1412" class="Symbol">→</a> <a id="1414" href="Structures.EquationalLogic.html#1387" class="Bound">𝑨</a> <a id="1416" href="Structures.EquationalLogic.html#1222" class="Function Operator">⊧</a> <a id="1418" href="Structures.EquationalLogic.html#1377" class="Bound">p</a> <a id="1420" href="Structures.EquationalLogic.html#1222" class="Function Operator">≈</a> <a id="1422" href="Structures.EquationalLogic.html#1381" class="Bound">q</a>

<a id="1425" class="Comment">-- Theories</a>
<a id="Th"></a><a id="1437" href="Structures.EquationalLogic.html#1437" class="Function">Th</a> <a id="1440" class="Symbol">:</a> <a id="1442" href="Relation.Unary.html#1101" class="Function">Pred</a> <a id="1447" class="Symbol">(</a><a id="1448" href="Structures.Basic.html#1565" class="Record">structure</a> <a id="1458" href="Structures.EquationalLogic.html#1120" class="Generalizable">𝐹</a> <a id="1460" href="Structures.EquationalLogic.html#1141" class="Generalizable">𝑅</a><a id="1461" class="Symbol">{</a><a id="1462" href="Structures.EquationalLogic.html#1105" class="Generalizable">α</a><a id="1463" class="Symbol">}{</a><a id="1465" href="Structures.EquationalLogic.html#1107" class="Generalizable">ρ</a><a id="1466" class="Symbol">})</a> <a id="1469" href="Structures.EquationalLogic.html#1109" class="Generalizable">ℓ</a> <a id="1471" class="Symbol">→</a> <a id="1473" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="1477" class="Symbol">(</a><a id="1478" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1483" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1485" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="1487" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1492" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a><a id="1493" class="Symbol">)</a> <a id="1495" class="Symbol">_</a> <a id="1497" class="Comment">-- (ℓ₁ ⊔ χ)</a>
<a id="1509" href="Structures.EquationalLogic.html#1437" class="Function">Th</a> <a id="1512" href="Structures.EquationalLogic.html#1512" class="Bound">𝒦</a> <a id="1514" class="Symbol">=</a> <a id="1516" class="Symbol">λ</a> <a id="1518" class="Symbol">(</a><a id="1519" href="Structures.EquationalLogic.html#1519" class="Bound">p</a> <a id="1521" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="1523" href="Structures.EquationalLogic.html#1523" class="Bound">q</a><a id="1524" class="Symbol">)</a> <a id="1526" class="Symbol">→</a> <a id="1528" href="Structures.EquationalLogic.html#1512" class="Bound">𝒦</a> <a id="1530" href="Structures.EquationalLogic.html#1309" class="Function Operator">⊧</a> <a id="1532" href="Structures.EquationalLogic.html#1519" class="Bound">p</a> <a id="1534" href="Structures.EquationalLogic.html#1309" class="Function Operator">≋</a> <a id="1536" href="Structures.EquationalLogic.html#1523" class="Bound">q</a>

<a id="1539" class="Comment">-- Models</a>
<a id="Mod"></a><a id="1549" href="Structures.EquationalLogic.html#1549" class="Function">Mod</a> <a id="1553" class="Symbol">:</a> <a id="1555" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="1559" class="Symbol">(</a><a id="1560" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1565" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1567" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="1569" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1574" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a><a id="1575" class="Symbol">)</a> <a id="1577" href="Structures.EquationalLogic.html#1109" class="Generalizable">ℓ</a>  <a id="1580" class="Symbol">→</a> <a id="1582" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="1586" class="Symbol">(</a><a id="1587" href="Structures.Basic.html#1565" class="Record">structure</a> <a id="1597" href="Structures.EquationalLogic.html#1120" class="Generalizable">𝐹</a> <a id="1599" href="Structures.EquationalLogic.html#1141" class="Generalizable">𝑅</a> <a id="1601" class="Symbol">{</a><a id="1602" href="Structures.EquationalLogic.html#1105" class="Generalizable">α</a><a id="1603" class="Symbol">}</a> <a id="1605" class="Symbol">{</a><a id="1606" href="Structures.EquationalLogic.html#1107" class="Generalizable">ρ</a><a id="1607" class="Symbol">})</a> <a id="1610" class="Symbol">_</a>  <a id="1613" class="Comment">-- (χ ⊔ ℓ₀)</a>
<a id="1625" href="Structures.EquationalLogic.html#1549" class="Function">Mod</a> <a id="1629" href="Structures.EquationalLogic.html#1629" class="Bound">ℰ</a> <a id="1631" class="Symbol">=</a> <a id="1633" class="Symbol">λ</a> <a id="1635" href="Structures.EquationalLogic.html#1635" class="Bound">𝑨</a> <a id="1637" class="Symbol">→</a> <a id="1639" class="Symbol">∀</a> <a id="1641" href="Structures.EquationalLogic.html#1641" class="Bound">p</a> <a id="1643" href="Structures.EquationalLogic.html#1643" class="Bound">q</a> <a id="1645" class="Symbol">→</a> <a id="1647" class="Symbol">(</a><a id="1648" href="Structures.EquationalLogic.html#1641" class="Bound">p</a> <a id="1650" href="Agda.Builtin.Sigma.html#236" class="InductiveConstructor Operator">,</a> <a id="1652" href="Structures.EquationalLogic.html#1643" class="Bound">q</a><a id="1653" class="Symbol">)</a> <a id="1655" href="Relation.Unary.html#1523" class="Function Operator">∈</a> <a id="1657" href="Structures.EquationalLogic.html#1629" class="Bound">ℰ</a> <a id="1659" class="Symbol">→</a> <a id="1661" href="Structures.EquationalLogic.html#1635" class="Bound">𝑨</a> <a id="1663" href="Structures.EquationalLogic.html#1222" class="Function Operator">⊧</a> <a id="1665" href="Structures.EquationalLogic.html#1641" class="Bound">p</a> <a id="1667" href="Structures.EquationalLogic.html#1222" class="Function Operator">≈</a> <a id="1669" href="Structures.EquationalLogic.html#1643" class="Bound">q</a>

<a id="fMod"></a><a id="1672" href="Structures.EquationalLogic.html#1672" class="Function">fMod</a> <a id="1677" class="Symbol">:</a> <a id="1679" class="Symbol">{</a><a id="1680" href="Structures.EquationalLogic.html#1680" class="Bound">n</a> <a id="1682" class="Symbol">:</a> <a id="1684" href="Agda.Builtin.Nat.html#192" class="Datatype">ℕ</a><a id="1685" class="Symbol">}</a> <a id="1687" class="Symbol">→</a> <a id="1689" class="Symbol">(</a><a id="1690" href="Data.Fin.Base.html#1126" class="Datatype">Fin</a> <a id="1694" href="Structures.EquationalLogic.html#1680" class="Bound">n</a> <a id="1696" class="Symbol">→</a> <a id="1698" class="Symbol">(</a><a id="1699" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1704" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a> <a id="1706" href="Data.Product.html#1167" class="Function Operator">×</a> <a id="1708" href="Terms.Basic.html#1987" class="Datatype">Term</a> <a id="1713" href="Structures.EquationalLogic.html#1162" class="Generalizable">X</a><a id="1714" class="Symbol">))</a> <a id="1717" class="Symbol">→</a> <a id="1719" href="Relation.Unary.html#1101" class="Function">Pred</a><a id="1723" class="Symbol">(</a><a id="1724" href="Structures.Basic.html#1565" class="Record">structure</a> <a id="1734" href="Structures.EquationalLogic.html#1120" class="Generalizable">𝐹</a> <a id="1736" href="Structures.EquationalLogic.html#1141" class="Generalizable">𝑅</a> <a id="1738" class="Symbol">{</a><a id="1739" href="Structures.EquationalLogic.html#1105" class="Generalizable">α</a><a id="1740" class="Symbol">}</a> <a id="1742" class="Symbol">{</a><a id="1743" href="Structures.EquationalLogic.html#1107" class="Generalizable">ρ</a><a id="1744" class="Symbol">})</a> <a id="1747" class="Symbol">_</a>
<a id="1749" href="Structures.EquationalLogic.html#1672" class="Function">fMod</a> <a id="1754" href="Structures.EquationalLogic.html#1754" class="Bound">ℰ</a> <a id="1756" class="Symbol">=</a> <a id="1758" class="Symbol">λ</a> <a id="1760" href="Structures.EquationalLogic.html#1760" class="Bound">𝑨</a> <a id="1762" class="Symbol">→</a> <a id="1764" class="Symbol">∀</a> <a id="1766" href="Structures.EquationalLogic.html#1766" class="Bound">i</a> <a id="1768" class="Symbol">→</a> <a id="1770" href="Structures.EquationalLogic.html#1760" class="Bound">𝑨</a> <a id="1772" href="Structures.EquationalLogic.html#1222" class="Function Operator">⊧</a> <a id="1774" href="Structures.EquationalLogic.html#736" class="Field">fst</a> <a id="1778" class="Symbol">(</a><a id="1779" href="Structures.EquationalLogic.html#1754" class="Bound">ℰ</a> <a id="1781" href="Structures.EquationalLogic.html#1766" class="Bound">i</a><a id="1782" class="Symbol">)</a> <a id="1784" href="Structures.EquationalLogic.html#1222" class="Function Operator">≈</a> <a id="1786" href="Structures.EquationalLogic.html#751" class="Field">snd</a> <a id="1790" class="Symbol">(</a><a id="1791" href="Structures.EquationalLogic.html#1754" class="Bound">ℰ</a> <a id="1793" href="Structures.EquationalLogic.html#1766" class="Bound">i</a><a id="1794" class="Symbol">)</a>

</pre>

--------------------------------

<span style="float:left;">[← Structures.Substructures](Structures.Substructures.html)</span>
<span style="float:right;">[Structures.Sigma →](Structures.Sigma.html)</span>

{% include UALib.Links.md %}

[agda-algebras development team]: https://github.com/ualib/agda-algebras#the-agda-algebras-development-team

