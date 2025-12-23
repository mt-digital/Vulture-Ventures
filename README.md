# Numerical Fragility Scenario Explorer


## Purpose

This application explores **numerical fragility** in complex systems by
running **user-specified stress scenarios** on reported quantities.

It does not predict outcomes, recommend trades, or assign probabilities.
Instead, it addresses a narrower question:

> Under what numerical assumptions do reported systems violate hard
> constraints?

The goal is to make structural weakness visible, not to prescribe
action.

## Disclaimer

This system is for informational purposes only and does not constitute
advice. Users assume all risk and responsibility for decisions made
using this system.

## Vulturing: a historical example

A well-documented historical illustration of degrees of freedom being
consumed comes from the collapse of Enron.

In the late 1990s and into 2000, Enron’s stock price rose dramatically
and experienced multiple periods of recovery, even as structural
constraints tightened behind the scenes. The company relied increasingly
on special purpose entities (SPEs) and off-balance-sheet arrangements to
obscure liabilities and maintain reported solvency. These mechanisms did
not resolve underlying constraints; they postponed their recognition.

During this period, capital continued to flow in, confidence was
periodically restored, and adverse information was repeatedly absorbed
rather than eliminated. Prices moved up and down rather than
monotonically anticipating failure.

What mattered was not the exact timing of collapse, but arithmetic. Each
response to pressure consumed degrees of freedom: greater dependence on
continued refinancing, increasing sensitivity to confidence shocks, and
narrower conditions under which the firm could remain viable. Time
passed between early warning signals and bankruptcy, but recovery
required increasingly unlikely alignment of external conditions.

A vulturing approach does not require predicting bankruptcy, fraud
exposure, or legal outcomes. It requires recognizing when degrees of
freedom are being consumed faster than they can be restored, and when
apparent stability depends on fragile, non-robust assumptions rather
than slack.

This gap — between early structural signals and final repricing — is
where prices may rise, fall, and recover, even as the set of viable
futures steadily collapses.

## References

- McLean, B., & Elkind, P. (2003). *The Smartest Guys in the Room: The
  Amazing Rise and Scandalous Fall of Enron*. Portfolio.  
- U.S. Senate Permanent Subcommittee on Investigations. (2003). *The
  Role of the Board of Directors in Enron’s Collapse*.  
- Healy, P. M., & Palepu, K. G. (2003). The fall of Enron. *Journal of
  Economic Perspectives*, 17(2), 3–26.  
- Wikipedia contributors. *Enron scandal*.
  https://en.wikipedia.org/wiki/Enron_scandal  
- Corporate Finance Institute. *Enron Scandal*.
  https://corporatefinanceinstitute.com/resources/esg/enron-scandal/

### Core Design

The app strictly separates:

1.  **Data**  
    Reported or assumed quantities (e.g. assets, liabilities, cash
    flow).

2.  **Scenarios**  
    Counterfactual stressors specified by the user (e.g. liability
    amplification, refinancing stress, revenue contraction).

3.  **Outputs**  
    Deterministic numerical consequences and constraint checks.

This separation keeps the analysis transparent, editable, and ethically
neutral.

## Core Mathematical Object

The system evaluates **constraint violation under stress**.

### Baseline Quantities

Let the baseline system be represented by:

$$
x = (A, L, C, D)
$$

where:

- $A$ = Assets  
- $L$ = Reported liabilities  
- $C$ = Cash flow (per period)  
- $D$ = Debt service (per period)

### Stress Parameters

A scenario is defined by:

$$
s = (\lambda_L, \lambda_D, \delta_C)
$$

where:

- $\lambda_L \ge 1$ inflates liabilities  
- $\lambda_D \ge 1$ inflates debt service  
- $\delta_C \in [0,1]$ reduces cash flow

### Stressed System

The stressed quantities are computed deterministically:

$$
L' = \lambda_L L
$$

$$
D' = \lambda_D D
$$

$$
C' = C (1 - \delta_C)
$$

### Constraint Checks

The app evaluates simple, interpretable constraints such as:

- **Solvency** $$
  A - L' \ge 0
  $$

- **Liquidity** $$
  C' - D' \ge 0
  $$

Violations are flagged explicitly. No aggregation, weighting, or
optimization is performed.

## Scenario Suggestions

The application may suggest default stress ranges (e.g. “test
liabilities at $1$–$5\times$ reported”), but these are templates, not
conclusions.

All scenarios remain fully user-controlled.

## Ethical Framing

This tool supports **salvage analysis**:

- It does not cause system failure.
- It does not rely on private or illicit information.
- It enforces arithmetic consistency on public or assumed numbers.
- It highlights when continued operation depends on assumptions that
  violate hard constraints.

Any downstream interpretation or action is the responsibility of the
user.

## Limitations

- The model is intentionally simple.
- No probabilities are inferred.
- No timing is assumed unless supplied by the user.
- Results are conditional, not predictive.

This is a numerical exploration tool, not a decision engine.

## Getting Started

1.  Enter baseline quantities.
2.  Specify a stress scenario.
3.  Observe which constraints bind or fail.
4.  Adjust assumptions and repeat.

If no constraints fail, the system is numerically survivable under the
given assumptions. If constraints fail, the system is fragile under that
scenario.
