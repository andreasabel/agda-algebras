---
layout: default
title : "Base.Relations.Continuous module (The Agda Universal Algebra Library)"
date : "2021-02-28"
author: "[agda-algebras development team][]"
---

### <a id="continuous-relations">Continuous Relations</a>

This is the [Base.Relations.Continuous][] module of the [Agda Universal Algebra Library][].

<pre class="Agda">

<a id="337" class="Symbol">{-#</a> <a id="341" class="Keyword">OPTIONS</a> <a id="349" class="Pragma">--without-K</a> <a id="361" class="Pragma">--exact-split</a> <a id="375" class="Pragma">--safe</a> <a id="382" class="Symbol">#-}</a>

<a id="387" class="Keyword">module</a> <a id="394" href="Base.Relations.Continuous.html" class="Module">Base.Relations.Continuous</a> <a id="420" class="Keyword">where</a>

<a id="427" class="Comment">-- Imports from Agda and the Agda Standard Library -------------------------------</a>
<a id="510" class="Keyword">open</a> <a id="515" class="Keyword">import</a> <a id="522" href="Agda.Primitive.html" class="Module">Agda.Primitive</a> <a id="537" class="Keyword">using</a> <a id="543" class="Symbol">(</a> <a id="545" href="Agda.Primitive.html#810" class="Primitive Operator">_⊔_</a> <a id="549" class="Symbol">;</a> <a id="551" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="556" class="Symbol">;</a> <a id="558" href="Agda.Primitive.html#597" class="Postulate">Level</a> <a id="564" class="Symbol">)</a> <a id="566" class="Keyword">renaming</a> <a id="575" class="Symbol">(</a> <a id="577" href="Agda.Primitive.html#326" class="Primitive">Set</a> <a id="581" class="Symbol">to</a> <a id="584" class="Primitive">Type</a> <a id="589" class="Symbol">)</a>

<a id="592" class="Comment">-- Imports from agda-algebras ----------------------------------------------------</a>
<a id="675" class="Keyword">open</a> <a id="680" class="Keyword">import</a> <a id="687" href="Base.Overture.Preliminaries.html" class="Module">Base.Overture.Preliminaries</a> <a id="715" class="Keyword">using</a> <a id="721" class="Symbol">(</a> <a id="723" href="Base.Overture.Preliminaries.html#6010" class="Function">Π</a> <a id="725" class="Symbol">;</a> <a id="727" href="Base.Overture.Preliminaries.html#6090" class="Function">Π-syntax</a> <a id="736" class="Symbol">)</a>
<a id="738" class="Keyword">open</a> <a id="743" class="Keyword">import</a> <a id="750" href="Base.Relations.Discrete.html" class="Module">Base.Relations.Discrete</a>     <a id="778" class="Keyword">using</a> <a id="784" class="Symbol">(</a> <a id="786" href="Base.Relations.Discrete.html#6109" class="Function">Op</a> <a id="789" class="Symbol">;</a> <a id="791" href="Base.Relations.Discrete.html#6298" class="Function Operator">arity[_]</a> <a id="800" class="Symbol">)</a>

<a id="803" class="Keyword">private</a> <a id="811" class="Keyword">variable</a> <a id="820" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="822" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a> <a id="824" class="Symbol">:</a> <a id="826" href="Agda.Primitive.html#597" class="Postulate">Level</a>

</pre>

#### <a id="motivation">Motivation</a>

In set theory, an n-ary relation on a set `A` is simply a subset of the n-fold product `A × A × ⋯ × A`.  As such, we could model these as predicates over the type `A × A × ⋯ × A`, or as relations of type `A → A → ⋯ → A → Type β` (for some universe β).  To implement such a relation in type theory, we would need to know the arity in advance, and then somehow form an n-fold arrow →.  It's easier and more general to instead define an arity type `I : Type 𝓥`, and define the type representing `I`-ary relations on `A` as the function type `(I → A) → Type β`.  Then, if we are specifically interested in an n-ary relation for some natural number `n`, we could take `I` to be a finite set (e.g., of type `Fin n`).

Below we will define `ContRel` to be the type `(I → A) → Type β` and we will call `ContRel` the type of *continuous relations*.  This generalizes the discrete relations we defined in [Base.Relations.Discrete] (unary, binary, etc.) since continuous relations can be of arbitrary arity.  They are not completely general, however, since they are defined over a single type. Said another way, they are *single-sorted* relations. We will remove this limitation when we define the type of *dependent continuous relations* at the end of this module.

Just as `Rel A β` was the single-sorted special case of the multisorted `REL A B β` type, so too will `ContRel I A β` be the single-sorted version of a completely general type of relations. The latter will represent relations that not only have arbitrary arities, but also are defined over arbitrary families of types.

To be more concrete, given an arbitrary family `A : I → Type α` of types, we may have a relation from `A i` to `A j` to `A k` to …, where the collection represented by the "indexing" type `I` might not even be enumerable.

We refer to such relations as *dependent continuous relations* (or *dependent relations* for short) because the definition of a type that represents them requires depedent types.  The `DepRel` type that we define [below](Base.Relations.Continuous.html#dependent-relations) manifests this completely general notion of relation.



#### <a id="continuous-and-dependent-relations">Continuous and dependent relations</a>

Here we define the types `Rel` and `ΠΡ` ("Pi Rho"). The first of these represents predicates of arbitrary arity over a single type `A`; we call these *continuous relations*.
To define `ΠΡ`, the type of *dependent relations*, we exploit the full power of dependent types and provide a completely general relation type.

Here, the tuples of a relation of type `DepRel I 𝒜 β` will inhabit the dependent function type `𝒜 : I → Type α` (where the codomain may depend on the input coordinate `i : I` of the domain). Heuristically, we can think of an inhabitant of type `DepRel I 𝒜 β` as a relation from `𝒜 i` to `𝒜 j` to `𝒜 k` to …. (This is only a rough heuristic since `I` could denote an uncountable collection.


<pre class="Agda">

<a id="3827" class="Keyword">module</a> <a id="3834" href="Base.Relations.Continuous.html#3834" class="Module">_</a> <a id="3836" class="Symbol">{</a><a id="3837" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="3839" class="Symbol">:</a> <a id="3841" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="3846" class="Symbol">}</a> <a id="3848" class="Keyword">where</a>

 <a id="3856" href="Base.Relations.Continuous.html#3856" class="Function">ar</a> <a id="3859" class="Symbol">:</a> <a id="3861" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="3866" class="Symbol">(</a><a id="3867" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="3872" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a><a id="3873" class="Symbol">)</a>
 <a id="3876" href="Base.Relations.Continuous.html#3856" class="Function">ar</a> <a id="3879" class="Symbol">=</a> <a id="3881" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="3886" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a>

<a id="3889" class="Comment">-- Relations of arbitrary arity over a single sort.</a>
 <a id="3942" href="Base.Relations.Continuous.html#3942" class="Function">Rel</a> <a id="3946" class="Symbol">:</a> <a id="3948" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="3953" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="3955" class="Symbol">→</a> <a id="3957" href="Base.Relations.Continuous.html#3856" class="Function">ar</a> <a id="3960" class="Symbol">→</a> <a id="3962" class="Symbol">{</a><a id="3963" href="Base.Relations.Continuous.html#3963" class="Bound">ρ</a> <a id="3965" class="Symbol">:</a> <a id="3967" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="3972" class="Symbol">}</a> <a id="3974" class="Symbol">→</a> <a id="3976" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="3981" class="Symbol">(</a><a id="3982" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="3984" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="3986" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="3988" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="3990" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="3995" href="Base.Relations.Continuous.html#3963" class="Bound">ρ</a><a id="3996" class="Symbol">)</a>
 <a id="3999" href="Base.Relations.Continuous.html#3942" class="Function">Rel</a> <a id="4003" href="Base.Relations.Continuous.html#4003" class="Bound">A</a> <a id="4005" href="Base.Relations.Continuous.html#4005" class="Bound">I</a> <a id="4007" class="Symbol">{</a><a id="4008" href="Base.Relations.Continuous.html#4008" class="Bound">ρ</a><a id="4009" class="Symbol">}</a> <a id="4011" class="Symbol">=</a> <a id="4013" class="Symbol">(</a><a id="4014" href="Base.Relations.Continuous.html#4005" class="Bound">I</a> <a id="4016" class="Symbol">→</a> <a id="4018" href="Base.Relations.Continuous.html#4003" class="Bound">A</a><a id="4019" class="Symbol">)</a> <a id="4021" class="Symbol">→</a> <a id="4023" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4028" href="Base.Relations.Continuous.html#4008" class="Bound">ρ</a>

 <a id="4032" href="Base.Relations.Continuous.html#4032" class="Function">Rel-syntax</a> <a id="4043" class="Symbol">:</a> <a id="4045" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4050" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="4052" class="Symbol">→</a> <a id="4054" href="Base.Relations.Continuous.html#3856" class="Function">ar</a> <a id="4057" class="Symbol">→</a> <a id="4059" class="Symbol">(</a><a id="4060" href="Base.Relations.Continuous.html#4060" class="Bound">ρ</a> <a id="4062" class="Symbol">:</a> <a id="4064" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="4069" class="Symbol">)</a> <a id="4071" class="Symbol">→</a> <a id="4073" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4078" class="Symbol">(</a><a id="4079" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="4081" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="4083" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="4085" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="4087" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="4092" href="Base.Relations.Continuous.html#4060" class="Bound">ρ</a><a id="4093" class="Symbol">)</a>
 <a id="4096" href="Base.Relations.Continuous.html#4032" class="Function">Rel-syntax</a> <a id="4107" href="Base.Relations.Continuous.html#4107" class="Bound">A</a> <a id="4109" href="Base.Relations.Continuous.html#4109" class="Bound">I</a> <a id="4111" href="Base.Relations.Continuous.html#4111" class="Bound">ρ</a> <a id="4113" class="Symbol">=</a> <a id="4115" href="Base.Relations.Continuous.html#3942" class="Function">Rel</a> <a id="4119" href="Base.Relations.Continuous.html#4107" class="Bound">A</a> <a id="4121" href="Base.Relations.Continuous.html#4109" class="Bound">I</a> <a id="4123" class="Symbol">{</a><a id="4124" href="Base.Relations.Continuous.html#4111" class="Bound">ρ</a><a id="4125" class="Symbol">}</a>

 <a id="4129" class="Keyword">syntax</a> <a id="4136" href="Base.Relations.Continuous.html#4032" class="Function">Rel-syntax</a> <a id="4147" class="Bound">A</a> <a id="4149" class="Bound">I</a> <a id="4151" class="Bound">ρ</a> <a id="4153" class="Symbol">=</a> <a id="4155" class="Function">Rel[</a> <a id="4160" class="Bound">A</a> <a id="4162" class="Function">^</a> <a id="4164" class="Bound">I</a> <a id="4166" class="Function">]</a> <a id="4168" class="Bound">ρ</a>
 <a id="4171" class="Keyword">infix</a> <a id="4177" class="Number">6</a> <a id="4179" href="Base.Relations.Continuous.html#4032" class="Function">Rel-syntax</a>

 <a id="4192" class="Comment">-- The type of arbitrarily multisorted relations of arbitrary arity</a>
 <a id="4261" href="Base.Relations.Continuous.html#4261" class="Function">ΠΡ</a> <a id="4264" class="Symbol">:</a> <a id="4266" class="Symbol">(</a><a id="4267" href="Base.Relations.Continuous.html#4267" class="Bound">I</a> <a id="4269" class="Symbol">:</a> <a id="4271" href="Base.Relations.Continuous.html#3856" class="Function">ar</a><a id="4273" class="Symbol">)</a> <a id="4275" class="Symbol">→</a> <a id="4277" class="Symbol">(</a><a id="4278" href="Base.Relations.Continuous.html#4267" class="Bound">I</a> <a id="4280" class="Symbol">→</a> <a id="4282" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4287" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a><a id="4288" class="Symbol">)</a> <a id="4290" class="Symbol">→</a> <a id="4292" class="Symbol">{</a><a id="4293" href="Base.Relations.Continuous.html#4293" class="Bound">ρ</a> <a id="4295" class="Symbol">:</a> <a id="4297" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="4302" class="Symbol">}</a> <a id="4304" class="Symbol">→</a> <a id="4306" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4311" class="Symbol">(</a><a id="4312" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="4314" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="4316" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="4318" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="4320" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="4325" href="Base.Relations.Continuous.html#4293" class="Bound">ρ</a><a id="4326" class="Symbol">)</a>
 <a id="4329" href="Base.Relations.Continuous.html#4261" class="Function">ΠΡ</a> <a id="4332" href="Base.Relations.Continuous.html#4332" class="Bound">I</a> <a id="4334" href="Base.Relations.Continuous.html#4334" class="Bound">𝒜</a> <a id="4336" class="Symbol">{</a><a id="4337" href="Base.Relations.Continuous.html#4337" class="Bound">ρ</a><a id="4338" class="Symbol">}</a> <a id="4340" class="Symbol">=</a> <a id="4342" class="Symbol">((</a><a id="4344" href="Base.Relations.Continuous.html#4344" class="Bound">i</a> <a id="4346" class="Symbol">:</a> <a id="4348" href="Base.Relations.Continuous.html#4332" class="Bound">I</a><a id="4349" class="Symbol">)</a> <a id="4351" class="Symbol">→</a> <a id="4353" href="Base.Relations.Continuous.html#4334" class="Bound">𝒜</a> <a id="4355" href="Base.Relations.Continuous.html#4344" class="Bound">i</a><a id="4356" class="Symbol">)</a> <a id="4358" class="Symbol">→</a> <a id="4360" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4365" href="Base.Relations.Continuous.html#4337" class="Bound">ρ</a>

 <a id="4369" href="Base.Relations.Continuous.html#4369" class="Function">ΠΡ-syntax</a> <a id="4379" class="Symbol">:</a> <a id="4381" class="Symbol">(</a><a id="4382" href="Base.Relations.Continuous.html#4382" class="Bound">I</a> <a id="4384" class="Symbol">:</a> <a id="4386" href="Base.Relations.Continuous.html#3856" class="Function">ar</a><a id="4388" class="Symbol">)</a> <a id="4390" class="Symbol">→</a> <a id="4392" class="Symbol">(</a><a id="4393" href="Base.Relations.Continuous.html#4382" class="Bound">I</a> <a id="4395" class="Symbol">→</a> <a id="4397" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4402" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a><a id="4403" class="Symbol">)</a> <a id="4405" class="Symbol">→</a> <a id="4407" class="Symbol">{</a><a id="4408" href="Base.Relations.Continuous.html#4408" class="Bound">ρ</a> <a id="4410" class="Symbol">:</a> <a id="4412" href="Agda.Primitive.html#597" class="Postulate">Level</a><a id="4417" class="Symbol">}</a> <a id="4419" class="Symbol">→</a> <a id="4421" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4426" class="Symbol">(</a><a id="4427" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="4429" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="4431" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="4433" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="4435" href="Agda.Primitive.html#780" class="Primitive">lsuc</a> <a id="4440" href="Base.Relations.Continuous.html#4408" class="Bound">ρ</a><a id="4441" class="Symbol">)</a>
 <a id="4444" href="Base.Relations.Continuous.html#4369" class="Function">ΠΡ-syntax</a> <a id="4454" href="Base.Relations.Continuous.html#4454" class="Bound">I</a> <a id="4456" href="Base.Relations.Continuous.html#4456" class="Bound">𝒜</a> <a id="4458" class="Symbol">{</a><a id="4459" href="Base.Relations.Continuous.html#4459" class="Bound">ρ</a><a id="4460" class="Symbol">}</a> <a id="4462" class="Symbol">=</a> <a id="4464" href="Base.Relations.Continuous.html#4261" class="Function">ΠΡ</a> <a id="4467" href="Base.Relations.Continuous.html#4454" class="Bound">I</a> <a id="4469" href="Base.Relations.Continuous.html#4456" class="Bound">𝒜</a> <a id="4471" class="Symbol">{</a><a id="4472" href="Base.Relations.Continuous.html#4459" class="Bound">ρ</a><a id="4473" class="Symbol">}</a>

 <a id="4477" class="Keyword">syntax</a> <a id="4484" href="Base.Relations.Continuous.html#4369" class="Function">ΠΡ-syntax</a> <a id="4494" class="Bound">I</a> <a id="4496" class="Symbol">(λ</a> <a id="4499" class="Bound">i</a> <a id="4501" class="Symbol">→</a> <a id="4503" class="Bound">𝒜</a><a id="4504" class="Symbol">)</a> <a id="4506" class="Symbol">=</a> <a id="4508" class="Function">ΠΡ[</a> <a id="4512" class="Bound">i</a> <a id="4514" class="Function">∈</a> <a id="4516" class="Bound">I</a> <a id="4518" class="Function">]</a> <a id="4520" class="Bound">𝒜</a>
 <a id="4523" class="Keyword">infix</a> <a id="4529" class="Number">6</a> <a id="4531" href="Base.Relations.Continuous.html#4369" class="Function">ΠΡ-syntax</a>

</pre>

#### <a id="compatibility-with-general-relations">Compatibility with general relations</a>

<pre class="Agda">

 <a id="4661" class="Comment">-- Lift a relation of tuples up to a relation on tuples of tuples.</a>
 <a id="4729" href="Base.Relations.Continuous.html#4729" class="Function">eval-Rel</a> <a id="4738" class="Symbol">:</a> <a id="4740" class="Symbol">{</a><a id="4741" href="Base.Relations.Continuous.html#4741" class="Bound">I</a> <a id="4743" class="Symbol">:</a> <a id="4745" href="Base.Relations.Continuous.html#3856" class="Function">ar</a><a id="4747" class="Symbol">}{</a><a id="4749" href="Base.Relations.Continuous.html#4749" class="Bound">A</a> <a id="4751" class="Symbol">:</a> <a id="4753" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4758" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a><a id="4759" class="Symbol">}</a> <a id="4761" class="Symbol">→</a> <a id="4763" href="Base.Relations.Continuous.html#3942" class="Function">Rel</a> <a id="4767" href="Base.Relations.Continuous.html#4749" class="Bound">A</a> <a id="4769" href="Base.Relations.Continuous.html#4741" class="Bound">I</a><a id="4770" class="Symbol">{</a><a id="4771" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a><a id="4772" class="Symbol">}</a> <a id="4774" class="Symbol">→</a> <a id="4776" class="Symbol">(</a><a id="4777" href="Base.Relations.Continuous.html#4777" class="Bound">J</a> <a id="4779" class="Symbol">:</a> <a id="4781" href="Base.Relations.Continuous.html#3856" class="Function">ar</a><a id="4783" class="Symbol">)</a> <a id="4785" class="Symbol">→</a> <a id="4787" class="Symbol">(</a><a id="4788" href="Base.Relations.Continuous.html#4741" class="Bound">I</a> <a id="4790" class="Symbol">→</a> <a id="4792" href="Base.Relations.Continuous.html#4777" class="Bound">J</a> <a id="4794" class="Symbol">→</a> <a id="4796" href="Base.Relations.Continuous.html#4749" class="Bound">A</a><a id="4797" class="Symbol">)</a> <a id="4799" class="Symbol">→</a> <a id="4801" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="4806" class="Symbol">(</a><a id="4807" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="4809" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="4811" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a><a id="4812" class="Symbol">)</a>
 <a id="4815" href="Base.Relations.Continuous.html#4729" class="Function">eval-Rel</a> <a id="4824" href="Base.Relations.Continuous.html#4824" class="Bound">R</a> <a id="4826" href="Base.Relations.Continuous.html#4826" class="Bound">J</a> <a id="4828" href="Base.Relations.Continuous.html#4828" class="Bound">t</a> <a id="4830" class="Symbol">=</a> <a id="4832" class="Symbol">∀</a> <a id="4834" class="Symbol">(</a><a id="4835" href="Base.Relations.Continuous.html#4835" class="Bound">j</a> <a id="4837" class="Symbol">:</a> <a id="4839" href="Base.Relations.Continuous.html#4826" class="Bound">J</a><a id="4840" class="Symbol">)</a> <a id="4842" class="Symbol">→</a> <a id="4844" href="Base.Relations.Continuous.html#4824" class="Bound">R</a> <a id="4846" class="Symbol">λ</a> <a id="4848" href="Base.Relations.Continuous.html#4848" class="Bound">i</a> <a id="4850" class="Symbol">→</a> <a id="4852" href="Base.Relations.Continuous.html#4828" class="Bound">t</a> <a id="4854" href="Base.Relations.Continuous.html#4848" class="Bound">i</a> <a id="4856" href="Base.Relations.Continuous.html#4835" class="Bound">j</a>

</pre>

A relation `R` is compatible with an operation `f` if for every tuple `t` of tuples
belonging to `R`, the tuple whose elements are the result of applying `f` to
sections of `t` also belongs to `R`.

<pre class="Agda">

 <a id="5085" href="Base.Relations.Continuous.html#5085" class="Function">compatible-Rel</a> <a id="5100" class="Symbol">:</a> <a id="5102" class="Symbol">{</a><a id="5103" href="Base.Relations.Continuous.html#5103" class="Bound">I</a> <a id="5105" href="Base.Relations.Continuous.html#5105" class="Bound">J</a> <a id="5107" class="Symbol">:</a> <a id="5109" href="Base.Relations.Continuous.html#3856" class="Function">ar</a><a id="5111" class="Symbol">}{</a><a id="5113" href="Base.Relations.Continuous.html#5113" class="Bound">A</a> <a id="5115" class="Symbol">:</a> <a id="5117" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="5122" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a><a id="5123" class="Symbol">}</a> <a id="5125" class="Symbol">→</a> <a id="5127" href="Base.Relations.Discrete.html#6109" class="Function">Op</a><a id="5129" class="Symbol">(</a><a id="5130" href="Base.Relations.Continuous.html#5113" class="Bound">A</a><a id="5131" class="Symbol">)</a> <a id="5133" href="Base.Relations.Continuous.html#5105" class="Bound">J</a> <a id="5135" class="Symbol">→</a> <a id="5137" href="Base.Relations.Continuous.html#3942" class="Function">Rel</a> <a id="5141" href="Base.Relations.Continuous.html#5113" class="Bound">A</a> <a id="5143" href="Base.Relations.Continuous.html#5103" class="Bound">I</a><a id="5144" class="Symbol">{</a><a id="5145" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a><a id="5146" class="Symbol">}</a> <a id="5148" class="Symbol">→</a> <a id="5150" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="5155" class="Symbol">(</a><a id="5156" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="5158" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="5160" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a> <a id="5162" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="5164" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a><a id="5165" class="Symbol">)</a>
 <a id="5168" href="Base.Relations.Continuous.html#5085" class="Function">compatible-Rel</a> <a id="5183" href="Base.Relations.Continuous.html#5183" class="Bound">f</a> <a id="5185" href="Base.Relations.Continuous.html#5185" class="Bound">R</a>  <a id="5188" class="Symbol">=</a> <a id="5190" class="Symbol">∀</a> <a id="5192" href="Base.Relations.Continuous.html#5192" class="Bound">t</a> <a id="5194" class="Symbol">→</a> <a id="5196" href="Base.Relations.Continuous.html#4729" class="Function">eval-Rel</a> <a id="5205" href="Base.Relations.Continuous.html#5185" class="Bound">R</a> <a id="5207" href="Base.Relations.Discrete.html#6298" class="Function Operator">arity[</a> <a id="5214" href="Base.Relations.Continuous.html#5183" class="Bound">f</a> <a id="5216" href="Base.Relations.Discrete.html#6298" class="Function Operator">]</a> <a id="5218" href="Base.Relations.Continuous.html#5192" class="Bound">t</a> <a id="5220" class="Symbol">→</a> <a id="5222" href="Base.Relations.Continuous.html#5185" class="Bound">R</a> <a id="5224" class="Symbol">λ</a> <a id="5226" href="Base.Relations.Continuous.html#5226" class="Bound">i</a> <a id="5228" class="Symbol">→</a> <a id="5230" href="Base.Relations.Continuous.html#5183" class="Bound">f</a> <a id="5232" class="Symbol">(</a><a id="5233" href="Base.Relations.Continuous.html#5192" class="Bound">t</a> <a id="5235" href="Base.Relations.Continuous.html#5226" class="Bound">i</a><a id="5236" class="Symbol">)</a>
 <a id="5239" class="Comment">-- (inferred type of t is I → J → A)</a>

</pre>


#### <a id="compatibility-of-operations-with-pirho-types">Compatibility of operations with ΠΡ types</a>

<pre class="Agda">

 <a id="5410" href="Base.Relations.Continuous.html#5410" class="Function">eval-ΠΡ</a> <a id="5418" class="Symbol">:</a> <a id="5420" class="Symbol">{</a><a id="5421" href="Base.Relations.Continuous.html#5421" class="Bound">I</a> <a id="5423" href="Base.Relations.Continuous.html#5423" class="Bound">J</a> <a id="5425" class="Symbol">:</a> <a id="5427" href="Base.Relations.Continuous.html#3856" class="Function">ar</a><a id="5429" class="Symbol">}{</a><a id="5431" href="Base.Relations.Continuous.html#5431" class="Bound">𝒜</a> <a id="5433" class="Symbol">:</a> <a id="5435" href="Base.Relations.Continuous.html#5421" class="Bound">I</a> <a id="5437" class="Symbol">→</a> <a id="5439" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="5444" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a><a id="5445" class="Symbol">}</a>
  <a id="5449" class="Symbol">→</a>         <a id="5459" href="Base.Relations.Continuous.html#4261" class="Function">ΠΡ</a> <a id="5462" href="Base.Relations.Continuous.html#5421" class="Bound">I</a> <a id="5464" href="Base.Relations.Continuous.html#5431" class="Bound">𝒜</a> <a id="5466" class="Symbol">{</a><a id="5467" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a><a id="5468" class="Symbol">}</a>            <a id="5481" class="Comment">-- the relation type: subsets of Π[ i ∈ I ] 𝒜 i</a>
                                  <a id="5563" class="Comment">-- (where Π[ i ∈ I ] 𝒜 i is a type of dependent functions or &quot;tuples&quot;)</a>
  <a id="5636" class="Symbol">→</a>         <a id="5646" class="Symbol">((</a><a id="5648" href="Base.Relations.Continuous.html#5648" class="Bound">i</a> <a id="5650" class="Symbol">:</a> <a id="5652" href="Base.Relations.Continuous.html#5421" class="Bound">I</a><a id="5653" class="Symbol">)</a> <a id="5655" class="Symbol">→</a> <a id="5657" href="Base.Relations.Continuous.html#5423" class="Bound">J</a> <a id="5659" class="Symbol">→</a> <a id="5661" href="Base.Relations.Continuous.html#5431" class="Bound">𝒜</a> <a id="5663" href="Base.Relations.Continuous.html#5648" class="Bound">i</a><a id="5664" class="Symbol">)</a>  <a id="5667" class="Comment">-- an I-tuple of (𝒥 i)-tuples</a>
  <a id="5699" class="Symbol">→</a>         <a id="5709" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="5714" class="Symbol">(</a><a id="5715" href="Base.Relations.Continuous.html#3837" class="Bound">𝓥</a> <a id="5717" href="Agda.Primitive.html#810" class="Primitive Operator">⊔</a> <a id="5719" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a><a id="5720" class="Symbol">)</a>
 <a id="5723" href="Base.Relations.Continuous.html#5410" class="Function">eval-ΠΡ</a><a id="5730" class="Symbol">{</a><a id="5731" class="Argument">I</a> <a id="5733" class="Symbol">=</a> <a id="5735" href="Base.Relations.Continuous.html#5735" class="Bound">I</a><a id="5736" class="Symbol">}{</a><a id="5738" href="Base.Relations.Continuous.html#5738" class="Bound">J</a><a id="5739" class="Symbol">}{</a><a id="5741" href="Base.Relations.Continuous.html#5741" class="Bound">𝒜</a><a id="5742" class="Symbol">}</a> <a id="5744" href="Base.Relations.Continuous.html#5744" class="Bound">R</a> <a id="5746" href="Base.Relations.Continuous.html#5746" class="Bound">t</a> <a id="5748" class="Symbol">=</a> <a id="5750" class="Symbol">∀</a> <a id="5752" href="Base.Relations.Continuous.html#5752" class="Bound">j</a> <a id="5754" class="Symbol">→</a> <a id="5756" href="Base.Relations.Continuous.html#5744" class="Bound">R</a> <a id="5758" class="Symbol">λ</a> <a id="5760" href="Base.Relations.Continuous.html#5760" class="Bound">i</a> <a id="5762" class="Symbol">→</a> <a id="5764" class="Symbol">(</a><a id="5765" href="Base.Relations.Continuous.html#5746" class="Bound">t</a> <a id="5767" href="Base.Relations.Continuous.html#5760" class="Bound">i</a><a id="5768" class="Symbol">)</a> <a id="5770" href="Base.Relations.Continuous.html#5752" class="Bound">j</a>

 <a id="5774" href="Base.Relations.Continuous.html#5774" class="Function">compatible-ΠΡ</a> <a id="5788" class="Symbol">:</a> <a id="5790" class="Symbol">{</a><a id="5791" href="Base.Relations.Continuous.html#5791" class="Bound">I</a> <a id="5793" href="Base.Relations.Continuous.html#5793" class="Bound">J</a> <a id="5795" class="Symbol">:</a> <a id="5797" href="Base.Relations.Continuous.html#3856" class="Function">ar</a><a id="5799" class="Symbol">}{</a><a id="5801" href="Base.Relations.Continuous.html#5801" class="Bound">𝒜</a> <a id="5803" class="Symbol">:</a> <a id="5805" href="Base.Relations.Continuous.html#5791" class="Bound">I</a> <a id="5807" class="Symbol">→</a> <a id="5809" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="5814" href="Base.Relations.Continuous.html#820" class="Generalizable">α</a><a id="5815" class="Symbol">}</a>
  <a id="5819" class="Symbol">→</a>               <a id="5835" class="Symbol">(∀</a> <a id="5838" href="Base.Relations.Continuous.html#5838" class="Bound">i</a> <a id="5840" class="Symbol">→</a> <a id="5842" href="Base.Relations.Discrete.html#6109" class="Function">Op</a> <a id="5845" class="Symbol">(</a><a id="5846" href="Base.Relations.Continuous.html#5801" class="Bound">𝒜</a> <a id="5848" href="Base.Relations.Continuous.html#5838" class="Bound">i</a><a id="5849" class="Symbol">)</a> <a id="5851" href="Base.Relations.Continuous.html#5793" class="Bound">J</a><a id="5852" class="Symbol">)</a>  <a id="5855" class="Comment">-- for each i : I, an operation of type  𝒪(𝒜 i){J} = (J → 𝒜 i) → 𝒜 i</a>
  <a id="5926" class="Symbol">→</a>               <a id="5942" href="Base.Relations.Continuous.html#4261" class="Function">ΠΡ</a> <a id="5945" href="Base.Relations.Continuous.html#5791" class="Bound">I</a> <a id="5947" href="Base.Relations.Continuous.html#5801" class="Bound">𝒜</a> <a id="5949" class="Symbol">{</a><a id="5950" href="Base.Relations.Continuous.html#822" class="Generalizable">ρ</a><a id="5951" class="Symbol">}</a>             <a id="5965" class="Comment">-- a subset of Π[ i ∈ I ] 𝒜 i</a>
                                         <a id="6036" class="Comment">-- (where Π[ i ∈ I ] 𝒜 i is a type of dependent functions or &quot;tuples&quot;)</a>
  <a id="6109" class="Symbol">→</a>               <a id="6125" href="Base.Relations.Continuous.html#584" class="Primitive">Type</a> <a id="6130" class="Symbol">_</a>
 <a id="6133" href="Base.Relations.Continuous.html#5774" class="Function">compatible-ΠΡ</a> <a id="6147" class="Symbol">{</a><a id="6148" class="Argument">I</a> <a id="6150" class="Symbol">=</a> <a id="6152" href="Base.Relations.Continuous.html#6152" class="Bound">I</a><a id="6153" class="Symbol">}{</a><a id="6155" href="Base.Relations.Continuous.html#6155" class="Bound">J</a><a id="6156" class="Symbol">}{</a><a id="6158" href="Base.Relations.Continuous.html#6158" class="Bound">𝒜</a><a id="6159" class="Symbol">}</a> <a id="6161" href="Base.Relations.Continuous.html#6161" class="Bound">𝑓</a> <a id="6163" href="Base.Relations.Continuous.html#6163" class="Bound">R</a>  <a id="6166" class="Symbol">=</a> <a id="6168" href="Base.Overture.Preliminaries.html#6090" class="Function">Π[</a> <a id="6171" href="Base.Relations.Continuous.html#6171" class="Bound">t</a> <a id="6173" href="Base.Overture.Preliminaries.html#6090" class="Function">∈</a> <a id="6175" class="Symbol">((</a><a id="6177" href="Base.Relations.Continuous.html#6177" class="Bound">i</a> <a id="6179" class="Symbol">:</a> <a id="6181" href="Base.Relations.Continuous.html#6152" class="Bound">I</a><a id="6182" class="Symbol">)</a> <a id="6184" class="Symbol">→</a> <a id="6186" href="Base.Relations.Continuous.html#6155" class="Bound">J</a> <a id="6188" class="Symbol">→</a> <a id="6190" href="Base.Relations.Continuous.html#6158" class="Bound">𝒜</a> <a id="6192" href="Base.Relations.Continuous.html#6177" class="Bound">i</a><a id="6193" class="Symbol">)</a> <a id="6195" href="Base.Overture.Preliminaries.html#6090" class="Function">]</a> <a id="6197" href="Base.Relations.Continuous.html#5410" class="Function">eval-ΠΡ</a> <a id="6205" href="Base.Relations.Continuous.html#6163" class="Bound">R</a> <a id="6207" href="Base.Relations.Continuous.html#6171" class="Bound">t</a>

</pre>

#### <a id="detailed-explanation">Detailed explanation</a>

The first of these is an *evaluation* function which "lifts" an `I`-ary relation to an `(I → J)`-ary relation. The lifted relation will relate an `I`-tuple of `J`-tuples when the "`I`-slices" (or "rows") of the `J`-tuples belong to the original relation. The second definition denotes compatibility of an operation with a continuous relation.

Readers who find the syntax of the last two definitions nauseating might be helped by an explication of the semantics of these deifnitions. First, internalize the fact that `𝒶 : I → J → A` denotes an `I`-tuple of `J`-tuples of inhabitants of `A`. Next, recall that a continuous relation `R` denotes a certain collection of `I`-tuples (if `x : I → A`, then `R x` asserts that `x` "belongs to" or "satisfies" `R`).  For such `R`, the type `eval-cont-rel R` represents a certain collection of `I`-tuples of `J`-tuples, namely, the tuples `𝒶 : I → J → A` for which `eval-cont-rel R 𝒶` holds.

For simplicity, pretend for a moment that `J` is a finite set, say, `{1, 2, ..., J}`, so that we can write down a couple of the `J`-tuples as columns. For example, here are the i-th and k-th columns (for some `i k : I`).

```
𝒶 i 1      𝒶 k 1
𝒶 i 2      𝒶 k 2  <-- (a row of I such columns forms an I-tuple)
  ⋮          ⋮
𝒶 i J      𝒶 k J
```

Now `eval-cont-rel R 𝒶` is defined by `∀ j → R (λ i → 𝒶 i j)` which asserts that each row of the `I` columns shown above belongs to the original relation `R`. Finally, `cont-compatible-op` takes a `J`-ary operation `𝑓 : Op J A` and an `I`-tuple `𝒶 : I → J → A` of `J`-tuples, and determines whether the `I`-tuple `λ i → 𝑓 (𝑎 i)` belongs to `R`.

--------------------------------------

<span style="float:left;">[← Base.Relations.Discrete](Base.Relations.Discrete.html)</span>
<span style="float:right;">[Base.Relations.Properties →](Base.Relations.Properties.html)</span>

{% include UALib.Links.md %}

[agda-algebras development team]: https://github.com/ualib/agda-algebras#the-agda-algebras-development-team