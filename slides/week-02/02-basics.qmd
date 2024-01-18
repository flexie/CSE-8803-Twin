---
title: "Basics"
subtitle: "Data Assimilation & Inverse Problems"
date: "January 10, 2024"
footer: "[🔗 https://flexie.github.io/CSE-8803-Twin/](https://flexie.github.io/CSE-8803-Twin/)"
logo: "images/logo.png"
license: CC BY
format: 
  revealjs:
    theme: solarized
    # theme: [default, theme.scss]
    transition: fade
    slide-number: true
    incremental: false 
    chalkboard: true
    center: true
execute:
  freeze: auto
  echo: true
bibliography: ../../references.bib
---


## Text book

::: center
![](../images/MN06_ASCH_COVER_B_V6.png){width="80%"}
:::

##

::: center
**[INTRODUCTION]{style="color: blue"}**
:::

## What is data assimilation {.smaller}

Simplest view: a method of combining observations with model output.

Why do we need data assimilation? Why not just use the observations? (cf. [Regression]{style="color: green"})

We want to predict the future!

-   For that we need models.

-   But when models are not constrained periodically by reality, they are of little value.

-   Therefore, it is necessary to [fit the model state as closely as possible to the observations]{style="color: magenta"}, before a prediction is made.

------------------------------------------------------------------------

::: {#def-DA}
**Data assimilation (DA)** *is the approximation of the true state of some physical system at a given time, by combining time-distributed observations with a dynamic model in an optimal way.*
:::

## Data assimilation methods {.smaller}

There are two major classes of methods:

1.  [Variational methods]{style="color: magenta"} where we explicitly minimize a cost function using optimization methods.

2.  [Statistical methods]{style="color: magenta"} where we compute the best linear unbiased estimate (BLUE) by algebraic computations using the Kalman filter.

They provide the same result in the linear case, which is the only context where their optimality can be rigorously proved.

They both have difficulties in dealing with non-linearities and large problems.

The error statistics that are required by both, are in general poorly known.

## Introduction: approaches {.smaller}

DA is an approach for solving a specific class of [inverse]{style="color: magenta"}, or parameter estimation problems, where the parameter we seek is the [initial condition]{style="color: magenta"}.

Assimilation problems can be approached from many directions (depending on your background/preferences):

-   [control theory]{style="color: blue"};

-   [variational calculus;]{style="color: blue"}

-   [statistical estimation theory;]{style="color: magenta"}

-   [probability theory,]{style="color: magenta"}

-   stochastic differential equations.

Newer approaches (discussed later): nudging methods, reduced methods, ensemble methods and hybrid methods that combine variational and statistical approaches, [Machine/Deep Learning based approaches]{style="color: magenta"}.

## Introduction: approaches {.smaller}

1.  Navigation: important application of the Kalman filter.

2.  Remote sensing: satellite data.

3.  Geophysics: seismic exploration, geophysical prospecting, earthquake prediction.

4.  Air and noise pollution, source estimation

5.  Weather forecasting.

6.  Climatology. Global warming.

7.  Epidemiology.

8.  Forest fire evolution.

9.  Finance.

## Introduction: nonlinearity{.smaller}

The problems of data assimilation (in particular) and inverse problems in general arise from:

1.  The [nonlinear dynamics]{style="color: magenta"} of the physical model equations.

2.  The nonlinearity of the [inverse problem]{style="color: magenta"}.

## Introduction: iterative process {.smaller}

![](../images/model-assimilation-observations.png){fig-align="center" width="60%"}

Closely related to 

-   the [inference cycle]{style="color: magenta"}

-   [machine learning]{style="color: magenta"}...

## Motivational Example --- Digital Twin for Geological CO~2~ storage

::: {style="text-align: margin-top: 1em"}
- [Plume development & associated time-lapse seismic images](https://slim.gatech.edu/Publications/Public/Conferences/ML4SEISMIC/2023/bruer2023ML4SEISMICcrm/#/our-co2-system){preview-link="true" style="text-align: center"}
:::

::: {style="text-align: margin-top: 1em"}
- [Recovery of the CO~2~ plume](https://slim.gatech.edu/Publications/Public/Conferences/ML4SEISMIC/2023/herrmann2023ML4SEISMICmsc/#79){preview-link="true" style="text-align: center"}
:::

See for [SLIM website](https://slim.gatech.edu) for our research on [Geological CO~2~ Storage](https://slim.gatech.edu/research/geological-carbon-storage).

##

::: center
[**FORWARD AND INVERSE PROBLEMS**]{style="color: blue"}
:::

## Inverse problems{.smaller}

:::{fig-inverse_prob}
![from @asch2022toolbox](../images/inverse_prob.png){width="70%"}

Ingredients of an inverse problem: the physical reality (top) and the direct mathematical model (bottom). The inverse problem uses the difference between the model- predicted observations, u (calculated at the receiver array points $x_r$), and the real observations measured on the array, in order to find the unknown model parameters, m, or the source s (or both).

:::

## Forward and inverse problems {.smaller}

::: center
![](../images/direct_inverse.png){fig-align="center" width="60%"}
:::

Consider a parameter-dependent dynamical system, $$\frac{d\mathbf{z}}{dt}=g(t,\mathbf{z};\boldsymbol{\theta}),\qquad \mathbf{z}(t_{0})=\mathbf{z}_{0},$$ with $g$ known, $\mathbf{z}_0$ the initial condition, $\boldsymbol{\theta}\in\Theta$ parameters of the system,  $\mathbf{z}(t)\in\mathbb{R}^{k}$ the system's state.

## 

**Forward problem:** [Given $\boldsymbol{\theta},$]{style="color: blue"} [$\mathbf{z}_{0},$]{style="color: blue"}[find $\mathbf{z}(t)$]{style="color: orange"} for $t\ge t_{0}.$

**Inverse problem:** [Given $\mathbf{z}(t)$]{style="color: orange"} for $t\ge t_{0},$ [find $\boldsymbol{\theta}\in\Theta.$]{style="color: blue"}

## Observations {.smaller}

Observation [equation]{style="color: magenta"}: $$f(t,\boldsymbol{\theta})=\mathcal{H}\mathbf{z}(t,\boldsymbol{\theta}),$$ where $\mathcal{H}$ is the observation operator --- to account for the fact that observations are never completely known (in space-time).

Usually we have a finite number of discrete (space-time) [observations]{style="color: magenta"} $$\left\{\widetilde{y}_{j}\right\} _{j=1}^{n},$$ where $$\widetilde{y}_{j}\approx f(t_{j},\boldsymbol{\theta}).$$

## Noise-free and noise data {.smaller}

[Noise-free:]{style="color: magenta"} $$\widetilde{y}_{j}=f(t_{j},\boldsymbol{\theta})$$

[Noisy Data:]{style="color: magenta"} $$\widetilde{y}_{j}=f(t_{j},\boldsymbol{\theta})+\varepsilon_{j},$$ where $\varepsilon_{j}$ is error and requires that we introduce [variability/uncertainty]{style="color: magenta"} into the modeling and analysis.

## Well-posedness {.smaller}

1.  [Existence]{style="color: magenta"}

2.  [Uniqueness]{style="color: magenta"}

3.  [Continuous dependence]{style="color: magenta"} of solutions on observations.

✓ The existence and uniqueness together are also known as ["identifiability"]{style="color: red"}.

✓ The continuous dependence is related to the ["stability"]{style="color: red"} of the inverse problem.

## Well-posedness---math {.smaller}

::: {#def-well}
Let $X$ and $Y$ be two normed spaces and let $K\::\:X\rightarrow Y$ be a linear or nonlinear map between the two. The problem of finding $x$ given $y$ such that $$Kx=y$$ is well-posed if the following three properties hold:
:::

WP1

:   **Existence**---for every $y\in Y$ there is (at least) one solution $x\in X$ such that $Kx=y.$

WP2

:   **Uniqueness**---for every $y\in Y$ there is at most one $x\in X$ such that $Kx=y.$

WP3

:   **Stability**--- the solution $x$ depends continuously on the data $y$ in that for every sequence $\left\{ x_{n}\right\} \subset X$ with $Kx_{n}\rightarrow Kx$ as $n\rightarrow\infty,$ we have that $x_{n}\rightarrow x$ as $n\rightarrow\infty.$

## 

-   This concept of ill-posedness will help us to understand and distinguish between direct and inverse models.

-   It will provide us with basic comprehension of the methods and algorithms that will be used to solve inverse problems.

-   Finally, it will assist us in the analysis of "what went wrong?" when we attempt to solve the inverse problems.

## Ill-posedness of inverse problems {.smaller}

**Many inverse problems are ill-posed!**

Simplest case: one observation $\widetilde{y}$ for $f(\theta)$ and we need to find the pre-image $$\theta^{*}=f^{-1}(\widetilde{y})$$ for a given $\widetilde{y}.$

![](../images/ill.png){fig-align="center"}

## Simplest case {.smaller}

![](../images/simplest.png){fig-align="center"}

[Non-existence]{style="color: magenta"}: there is no $\theta_{3}$ such that $f(\theta_{3})=y_{3}$

[Non-uniqueness]{style="color: magenta"}: $y_{j}=f(\theta_{j})=f(\widetilde{\theta}_{j})$ for $j=1,2.$

[Lack of continuity]{style="color: magenta"} of inverse map: $\left|y_{1}-y_{2}\right|$ small $\nRightarrow\left|f^{-1}(y_{1})-f^{-1}(y_{2})\right|=\left|\theta_{1}-\widetilde{\theta}_{2}\right|$ small.

## Why is this so important? {.smaller}

Couldn't we just apply a good [least squares]{style="color: magenta"} algorithm (for example) to find the best possible solution?

-   Define $J(\theta)=\left|y_{1}-f(\theta)\right|^{2}$ for a given $y_{1}$

-   Apply a standard iterative scheme, such as direct search or gradient-based [minimization]{style="color: magenta"}, to obtain a solution

-   Newton's method: $$\theta^{k+1}=\theta^{k}-\left[J'(\theta^{k})\right]^{-1}J(\theta^{k})$$

-   Leads to highly unstable behavior because of ill-posedness

## What went wrong {.smaller}

✗ This behavior is not the fault of steepest descent algorithms.

✗ It is a manifestation of the [inherent ill-posedness]{style="color: magenta"} of the problem.

✗ How to fix this problem is the subject of much research over the past [50 years]{style="color: red"}!!!

Many remedies (fortunately) exist...

-   [x] explicit and implicit constrained optimizations

-   [x] regularization and penalization

-   [x] [machine learning]{style="color: magenta"}...

## Tikhonov regularization{.smaller}

**Idea:** is to replace the ill-posed problem for
    $J(\theta)=\left|y_{1}-f(\theta)\right|^{2}$ by a "nearby" problem
    for
    $$J_{\beta}(\theta)=\left|y_{1}-f(\theta)\right|^{2}+\beta\left|\theta-\theta_{0}\right|^{2}$$
    where $\beta$ is "suitably chosen" regularization/penalization
    parametersee below for details.


-   [x] When it is done correctly, TR provides convexity and compactness.

-    Even when done correctly, it [*modifies the problem*]{style="color: red"} and new solutions may be far from the
original ones.

-  It is not trivial to regularize correctly or even to know if you have
succeeded...

## Non uniqueness: seismic travel-time tomography{.smaller .nostretch}

![](../images/seismic.png){fig-align="center" width=40%}

A signal seismic ray passes through a 2-parameter block model.

-   [unknowns]{style="color: blue"} are the 2 block slownesses (inverse
    of seismic velocity) $\left(\Delta s_{1},\Delta s_{2}\right)$

-   [data]{style="color: blue"} is the observed travel time of the ray,
    $\Delta t_{1}$

-   [model]{style="color: blue"} is the linearized travel time equation, $\Delta t_{1}=l_{1}\Delta s_{1}+l_{2}\Delta s_{2}$ where $l_{j}$ is the length of the ray in the $j$-th block.

Clearly we have [one equation]{style="color: magenta"} for [two
unknowns]{style="color: magenta"} and hence there is [no unique
solution]{style="color: red"}.

## Inverse Problems: General Formulation{.smaller}

All inverse problems share a [common formulation]{style="color: magenta"}.

Let the [model parameters]{style="color: magenta"}[^1] be a vector
    (in general, a multivariate random variable), $\mathbf{m},$ and the
    [data]{style="color: magenta"} be $\mathbf{d},$ $$\begin{aligned}
    \mathbf{m} & =\left(m_{1},\ldots,m_{p}\right)\in\mathcal{M},\\
    \mathbf{d} & =\left(d_{1},\ldots,d_{n}\right)\in\mathcal{D},
    \end{aligned}$$ 
    
where $\mathcal{M}$ and $\mathcal{D}$ are the corresponding model
        parameter space and data space.

The mapping $G\colon\mathcal{M}\rightarrow\mathcal{D}$ is defined by the [direct]{style="color: magenta"} (or forward) model

$$\mathbf{d}=g(\mathbf{m}),$${#eq-forward} where


[^1]: Applied mathematicians often call the equation $G(m)=d$ a
    mathematical model and $m$ the parameters. Other scientists call $G$
    the forward operator and $m$ the model. We will adopt the more
    mathematical convention, where $m$ will be referred to as the model
    parameters, $G$ the model and $d$ the data.

## {.smaller}

- $g\in G$ is an operator that describes the "physical" model and
        can take numerous forms, such as algebraic equations,
        differential equations, integral equations, or linear systems.

Then we can add the [observations]{style="color: magenta"} or
    predictions, $\mathbf{y}=(y_{1},\ldots,y_{r}),$ corresponding to the
    mapping from data space into observation space,
    $H\colon\mathcal{D}\rightarrow\mathcal{Y},$ and described by
    $$\mathbf{y}=h(\mathbf{d})=h\left(g(\mathbf{m})\right),$$ where  
    
- $h\in H$ is the [observation operator]{style="color: magenta"},
        usually some projection into an observable subset of
        $\mathcal{D}.$

##

:::{.callout-note}   
In addition, there will be some [random
    noise]{style="color: magenta"} in the system, usually modeled as
    additive noise, giving the more realistic, stochastic direct model
    $$\mathbf{d}=g(\mathbf{m})+\mathbf{\epsilon},\label{eq:stat-inv-pb}$${#eq-noisy}
    where $\mathbf{\epsilon}$ is a random vector.
:::

## Inverse Problems---Classification{.smaller}

We can now classify inverse problems as:

-   [deterministic]{style="color: magenta"} inverse problems that
        solve [-@eq-forward] for $\mathbf{m},$

-   [statistical]{style="color: magenta"} inverse problems that
        solve [-@eq-noisy] for $\mathbf{m}.$

The first class will be treated by linear algebra and [optimization]{style="color: magenta"} methods.

The latter can be treated by a [Bayesian (filtering)]{style="color: magenta"} approach, and by weighted least-squares,
    maximum likelihood and DA techniques

Both classes can be further broken down into:

-   [Linear ]{style="color: magenta"} inverse problems, where
        [-@eq-forward] or [-@eq-noisy] are linear equations. These include
        linear systems that are often the result of discretizing
        (partial) differential equations and integral equations.

-   [Nonlinear]{style="color: magenta"} inverse problems where the
        algebraic or differential operators are nonlinear.

## {.smaller}

Finally, since most inverse problems cannot be solved explicitly,
    [computational methods]{style="color: magenta"} are indispensable
    for their solution, see sections 8.4 and 8.5 of @asch2022toolbox

Also note that we will be inverting here between the model and
    data spaces, that are usually both of high dimension and thus this
    model-based inversion will invariably be [computationally
    expensive]{style="color: magenta"}.

This will motivate us to employ

-   inversion between the data and observation spaces in a purely
        data-driven approach, using [machine learning
        methods]{style="color: magenta"} 
- this aspect will be treated later during this course

## Tikhonov Regularization---Introduction{.smaller}

Tikhonov regularization (TR) is probably the most widely used method
    for [regularizing]{style="color: magenta"} ill-posed, discrete and
    continuous [inverse problems]{style="color: magenta"}.

:::{.callout-note}
Note that the [LASSO]{style="color: magenta"} and [ridge
    regression]{style="color: magenta"} methods---are
    special cases of TR.
:::

The theory is the subject of entire books\...

Recall:

-   the objective of TR is to reduce, or remove, ill-posedness in
        optimization problems by modifying the objective function.

-   the three sources of ill-posedness: non-existence,
        non-uniqueness and sensitivity to perturbations.

-   TR, in principle, addresses and alleviates [all three
        sources]{style="color: magenta"} of ill-posedness and is thus a
        vital tool for the solution of inverse problems.

## Tikhonov Regularization---Formulation{.smaller}

The most general TR [objective function]{style="color: magenta"} is
    $$\mathcal{T}_{\alpha}(\mathbf{m};\mathbf{d})=\rho\left(G(\mathbf{m}),\mathbf{d}\right)+\alpha J(\mathbf{m}),$$
    where

-   $\rho$ is the [*data discrepancy
        functional*]{style="color: magenta"} that quantifies the
        difference between the model output and the measured data;

-   $J$ is the [*regularization functional*]{style="color: magenta"}
        that represents some desired quality of the sought for model
        parameters, usually smoothness;

-   $\alpha$ is the [*regularization
        parameter*]{style="color: magenta"} that needs to be
        [*tuned*]{style="color: magenta"}, and determines the relative
        importance of the regularization term.

Each domain, each application and each context will require
    [*specific choices* ]{style="color: magenta"} of these three items,
    and often we will have to rely either on previous experience, or on
    some sort of numerical experimentation (trial-and-error) to make a
    good choice.

In some cases there exist empirical algorithms, in particular for
    the choice of $\alpha.$

## Tikhonov Regularization---Discrepancy{.smaller}

The most common [*discrepancy functions*]{style="color: magenta"} are:

-   [*least-squares*]{style="color: magenta"},
    $$\rho_{\mathrm{LS}}(\mathbf{d}_{1},\mathbf{d}_{2})=\frac{1}{2}\Vert\mathbf{d}_{1}-\mathbf{d}_{2}\Vert_{2}^{2},$$

-   [*1-norm*]{style="color: magenta"},
    $$\rho_{1}(\mathbf{d}_{1},\mathbf{d}_{2})=\vert\mathbf{d}_{1}-\mathbf{d}_{2}\vert,$$

-   [*Kullback-Leibler distance*]{style="color: magenta"},
    $$\rho_{\mathrm{KL}}(d_{1},d_{2})=\left\langle d_{1},\log(d_{1}/d_{2})\right\rangle ,$$
    where $d_{1}$ and $d_{2}$ are considered here as probability density
    functions. This discrepancy is valid in the Bayesian context.

## Tikhonov Regularization{.smaller}

The most common [*regularization functionals*]{style="color: magenta"}
are derivatives of order one or two.

-   [*Gradient smoothing*]{style="color: magenta"}:
    $$J_{1}(\mathbf{m})=\frac{1}{2}\Vert\nabla\mathbf{m}\Vert_{2}^{2},$$
    where $\nabla$ is the gradient operator of first-order derivatives
    of the elements of $\mathbf{m}$ with respect to each of the
    independent variables.

-   [*Laplacian smoothing*]{style="color: magenta"}:
    $$J_{2}(\mathbf{m})=\frac{1}{2}\Vert\nabla^{2}\mathbf{m}\Vert_{2}^{2},$$
    where $\nabla^{2}=\nabla\cdot\nabla$ is the Laplacian operator
    defined as the sum of all second-order derivatives of $\mathbf{m}$
    with respect to each of the independent variables.

## TR---Computing the Regularization Parameter{.smaller}

Once the data discrepancy and regularization functionals have been
    chosen, we need to [tune]{style="color: magenta"} the regularization
    parameter, $\alpha.$

We have here, similarly to the [bias-variance
    trade-off]{style="color: magenta"} of ML Lectures, a competition
    between the discrepancy error and the magnitude of the
    regularization term.

We need to choose, the best [compromise]{style="color: magenta"}
        between the two.

We will briefly present three frequently used approaches:

1.  L-curve method.

2.  Discrepancy principle.

3.  Cross-validation and LOOCV.

## TR---Computing the Regularization Parameter{.smaller .nostretch}

![](../images/L-curve.png){fig-align="center" width="35%" #fig-L}

The **[L-curve criterion]{style="color: magenta"}** is an empirical
    method for picking a value of $\alpha.$

-   since $e_{m}(\alpha)=\Vert\mathbf{m}\Vert_{2}$ is a strictly
        decreasing function of $\alpha$ and
        $e_{d}(\alpha)=\Vert G\mathbf{m}-\mathbf{d}\Vert_{2}$ is a
        strictly increasing one,

-   we plot $\log e_{m}$ against $\log e_{d}$ we will always obtain
        an L-shaped curve that has an "elbow" at the optimal value of
        $\alpha=\alpha_{L},$ or at least at a good approximation of this
        optimal value see @fig-L.

## {.smaller}

-   This trade-off curve gives us a visual recipe for choosing the
        regularization parameter, reminiscent of the bias-variance trade
        off

-   The range of values of $\alpha$ for which one should plot the
        curve has to be determined by either trial-and-error, previous
        experience, or a balancing of the two terms in the TR
        functional.

The **[ discrepancy principle]{style="color: magenta"}**

-   choose the value of $\alpha=\alpha_{D}$ such that the residual
        error (first term) is equal to an *a priori* bound, $\delta,$
        that we would like to attain.

-   on the L-curve, this corresponds to the intersection with the
        vertical line at this bound, as shown in @fig-L.

-   a good approximation for the bound is to put
        $\delta=\sigma\sqrt{n},$ where $\sigma^{2}$ is the variance and
        $n$ the number of observations.[^2] This can be thought of as
        the noise level of the data.

## {.smaller}

-   the discrepancy principle is also related to regularization by
        the truncated singular value decomposition (TSVD), in which case
        the truncation level implicitly defines the regularization
        parameter.

**[Cross-validation]{style="color: magenta"}**, as we explained in
    ML Lectures, is a way of using the observations themselves to
    estimate a parameter.

-   We then employ the classical approach of either LOOCV or
        $k$-fold cross validation, and choose the value of $\alpha$ that
        minimizes the RSS (Residual Sum of Squares) of the test sets.

-   In order to reduce the computational cost, a generalized cross
        validation (GCV) method can be used.

[^2]: This is strictly valid under the hypothesis of i.i.d. Gaussian
    noise.

## 

::: center
**[DATA ASSIMILATION]{style="color: blue"}**
:::

## Definitions and notation{.smaller}

[Analysis]{style="color: magenta"} is the process of approximating the
true state of a physical system at a given time

Analysis is based on:

- [observational]{style="color: magenta"} data,

- a [model]{style="color: magenta"} of the physical system,

- [background]{style="color: magenta"} information on initial and boundary
conditions.

An analysis that combines time-distributed observations and a dynamic
model is called [data assimilation]{style="color: red"}.

## Standard notation{.smaller}

A [discrete model f]{style="color: blue"}or the evolution of a
    physical (atmospheric, oceanic, etc.) system from time $t_{k}$ to
    time $t_{k+1}$ is described by a dynamic, *state equation*

$$\mathbf{x}^{f}(t_{k+1})=M_{k+1}\left[\mathbf{x}^{f}(t_{k})\right],$${#eq-state}

-   $\mathbf{x}$ is the model's *state vector* of dimension $n,$

-   $M$ is the corresponding *dynamics operator* (finite difference or
        finite element discretization), which can be time dependent.

The [error covariance matrix](https://en.wikipedia.org/wiki/Covariance_matrix) associated with
    $\mathbf{x}$ is given by $\mathbf{P}$ since the true state will
    differ from the simulated state
    ([@eq-state]) by random or systematic errors.

[Observations]{style="color: blue"}, or measurements, at time
    $t_{k}$ are defined by

## {.smaller}

$$\mathbf{y}_{k}^{\mathrm{o}}=H_{k}\left[\mathbf{x}^{t}(t_{k})\right]+\varepsilon_{k}^{\mathrm{o}},$$

-   $H$ is an [observation operator]{style="color: magenta"} that can be time dependent

-   $\varepsilon_k^{\mathrm{o}}$ is a [white noise process]{style="color: magenta"}
        zero mean and covariance matrix $\mathbf{R}$ (instrument errors
        and representation errors due to the discretization)

-   observation vector
        $\mathbf{y}_{k}^{\mathrm{o}}=\mathbf{y}^{\mathrm{o}}(t_{k})$ has
        dimension $p_{k}$ (usually $p_{k}\ll n.$ )

Subscripts are used to denote the discrete time index, the
    corresponding spatial indices or the vector with respect to which an
    error covariance matrix is defined.

Superscripts refer to the nature of the vectors/matrices 

-   "a" for [analysis]{style="color: magenta"},  "b" for [background]{style="color: magenta"} (or 'initial/first
        guess'),

-   "f" for [forecast]{style="color: magenta"},  "o" for [observation]{style="color: magenta"}, and

-   "t" for the (unknown) [true]{style="color: magenta"} state.

An analysis that combines time-distributed observations and a dynamic model is called *data assimilation*.

## Standard notation---continuous system{.smaller}

Now let us introduce the continuous system. In fact, continuous time
    simplifies both the notation and the theoretical analysis of the
    problem. For a finite-dimensional system of ordinary differential
    equations, the sate and observation equations become
    $$\dot{\mathbf{x}}^{\mathrm{f}}=\mathcal{M}(\mathbf{x}^{\mathrm{f}},t)%\mathbf{\dot{\xf}}=\mathcal{M}(\xf,t)$$
    and
    $$\mathbf{y}^{\mathrm{o}}(t)=\mathcal{H}(\mathbf{x}^{\mathrm{t}},t)+\boldsymbol{\epsilon},$$
    where $\dot{\left(\,\right)}=\mathrm{d}/\mathrm{d}t,$ $\mathcal{M}$
    and $\mathcal{H}$ are nonlinear operators in continuous time for the
    model and the observation respectively.

This implies that $\mathbf{x},$ $\mathbf{y},$ and
    $\boldsymbol{\epsilon}$ are also continuous-in-time functions.

-   For PDEs, where there is in addition a dependence on space,
    attention must be paid to the function spaces, especially when
    performing variational analysis.

## {.smaller}    

-   With a PDE model, the field (state) variable is commonly denoted by
    $\boldsymbol{u}(\mathbf{x},t),$ where $\mathbf{x}$ represents the
    space variables (no longer the state variable as above!), and the
    model dynamics is now a [nonlinear partial differential
    operator,]{style="color: magenta"}
    $$\mathcal{M}=\mathcal{M}\left[\partial_{\mathbf{x}}^{\alpha},\boldsymbol{u}(\mathbf{x},t),\mathbf{x},t\right]$$
    with $\partial_{\mathbf{x}}^{\alpha}$ denoting the partial
    derivatives with respect to the space variables of order up to
    $\left|\alpha\right|\le m$ where $m$ is usually equal to two and in
    general varies between one and four.

##
::: center
**[CONCLUSIONS]{style="color: blue"}**
:::

## {.smaller}
Data assimilation requires not only the observations and a background,
but also knowledge of:

-   [x] [error statistics]{style="color: blue"}(background, observation, model,
etc.)

-   [x] [physics]{style="color: blue"} (forecast model, model relating observed
to retrieved variables, etc.).

The challenge of data assimilation is in [combining
]{style="color: magenta"} our stochastic knowledge with our physical
knowledge.

## Open-source software{.smaller}

Various open-source repositories and codes are available for both
academic and operational data assimilation.

1.  DARC: <https://research.reading.ac.uk/met-darc/> from Reading, UK.

2.  DAPPER: <https://github.com/nansencenter/DAPPER> from Nansen,
    Norway.

3.  DART: <https://dart.ucar.edu/> from NCAR, US, specialized in
    ensemble DA.

4.  OpenDA: <https://www.openda.org/>.

5.  Verdandi: <http://verdandi.sourceforge.net/> from INRIA, France.

6.  PyDA: <https://github.com/Shady-Ahmed/PyDA>, a Python implementation
    for academic use.

7.  Filterpy: <https://github.com/rlabbe/filterpy>, dedicated to KF
    variants.

8.  EnKF; <https://enkf.nersc.no/>, the original Ensemble KF from Geir
    Evensen.

9. [DataAssim.jl](https://juliapackages.com/p/dataassim)

10. [EnKF.jl](https://nextjournal.com/mleprovost/enkfjl-tools-for-data-assimilation-with-ensemble-kalman-filter-1)

## References{.smaller}

1.  K. Law, A. Stuart, K. Zygalakis. *Data Assimilation. A Mathematical
    Introduction*. Springer, 2015.

2.  G. Evensen. *Data assimilation, The Ensemble Kalman Filter*, 2nd
    ed., Springer, 2009.

3.  A. Tarantola. *Inverse problem theory and methods for model
    parameter estimation.* SIAM. 2005.

4.  O. Talagrand. Assimilation of observations, an introduction. *J.
    Meteorological Soc. Japan*, **75**, 191, 1997.

5.  F.X. Le Dimet, O. Talagrand. Variational algorithms for analysis and
    assimilation of meteorological observations: theoretical aspects.
    *Tellus,* **38**(2), 97, 1986.

6.  J.-L. Lions. Exact controllability, stabilization and perturbations
    for distributed systems. *SIAM Rev.*, **30**(1):1, 1988.

7.  J. Nocedal, S.J. Wright. *Numerical Optimization*. Springer, 2006.

8.  F. Tröltzsch. *Optimal Control of Partial Differential Equations*.
    AMS, 2010.

<!-- # References {.unnumbered .smaller} -->

::: {#refs}
:::
