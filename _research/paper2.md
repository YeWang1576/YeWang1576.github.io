---
title: "Improving Causal Inference with Time-Series Cross-Sectional Data Using Counterfactual Estimators (With Licheng Liu and Yiqing Xu)"
collection: research
permalink: /research/paper2
excerpt: "We introduce a simple framework of counterfactual estimators that directly impute counterfactuals for treated observations in a time-series cross-sectional setting with a dichotomous treatment. Examples include (1) the fixed-effect counterfactual estimator, (2) the interactive fixed-effect counterfactual estimator, and (3) the matrix completion estimator, which differ in the underlying model of predicting treated counterfactuals. They provide more reliable causal estimates than conventional two-way fixed effects models when the treatment effect is heterogeneous or there exist unobserved time- varying confounders. Moreover, we propose two diagnostic tests, an equivalence test and a placebo test, accompanied by visualization tools, to assist researchers to gauge the validity of the identifying assumptions. We illustrate these methods with three empirical examples from political economy and develop an open source package, fect, in R to facilitate implementation."
paperurl: http://YeWang1576.github.io/research/TSCSGuid_20190708.pdf
---

![alt text](http://YeWang1576.github.io/images/sim_placebo.png)

This figure shows dynamic effects plot under our three estimators: FEct, IFEct, and MC. The placebo test is conducted. 
