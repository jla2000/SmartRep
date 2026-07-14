# SmartRep — Specification Tasks

Breakdown of the plan for authoring the SmartRep specification. Check items off as they are completed.

## 1. Document skeleton

- [x] Create `SPEC.md` at the repo root with metadata (version, date, status, platforms)
- [x] Write §1 Overview & Goals: purpose, Flutter iOS + Android, offline-first/local-only principle
- [x] List explicit v1 non-goals (cloud sync, accounts, food database, wearables)
- [x] Lay out section headings for the rest of the document

## 2. Daily weigh-in & goal setting (spec §2.1–2.2)

- [x] Specify daily weigh-in: one entry per calendar day, edit/delete, back-dating, optional note
- [x] Specify units: kg/lb display, canonical kg storage, input validation and typo guard
- [x] Specify optional daily reminder notification
- [x] Specify goal modes: rate mode (e.g. −1 kg/month) and energy mode (e.g. +250 kcal/day)
- [x] Define normalization to kg/week via 7700 kcal ≈ 1 kg and 30.44-day months
- [x] Define safety rails: warning above 1 % body-weight loss per week, hard cap at ±1.5 %
- [x] Define maintain as a first-class goal and optional target weight (display-only)

## 3. Trend calculation & recommendation engine (spec §2.3–2.4)

- [x] Define rolling 7-day trend weight for display (min. 3 entries per window)
- [x] Define weekly blocks from goal start (valid at ≥ 3 entries) and actual rate as an
      ordinary-least-squares slope over the last 4 valid block averages (min. 2)
- [x] Cover edge cases: data gaps, invalid blocks, incomplete current block, goal change, backdated edits
- [x] Define recommendation formula: `adjustment = (target_rate − actual_rate) × 7700 / 7` kcal/day
- [x] Define statuses: `insufficient_data` / `on_track` / `eat_more` / `eat_less` with thresholds
- [x] Define damping rules: weekly cadence, ±500 kcal/day clamp, no advice until 2 valid blocks,
      reset on goal change
- [x] Define advice display setting: qualitative / numeric / both (default both)

## 4. UI screens & app skeleton (spec §2.5, §3)

- [x] Specify dashboard: trend weight, goal summary, recommendation card, quick-add button
- [x] Specify weigh-in entry, history list, and chart (raw dots + trend line + goal projection)
- [x] Specify goal setup wizard and settings screen
- [x] Sketch app shell: bottom nav with Weight (v1), Workouts (placeholder), Nutrition (placeholder), Settings
- [x] Define how future modules plug into the shared local DB and dashboard

## 5. Technical architecture (spec §4)

- [x] Choose stack and packages: Flutter/Dart, drift (SQLite), riverpod, fl_chart, flutter_local_notifications
- [x] Define layering: `data/` / `domain/` (pure, unit-testable algorithms) / `presentation/`
- [x] Define data model: `weight_entries`, `goals`, `settings`, `recommendation_log`

## 6. Acceptance criteria & roadmap (spec §5–6)

- [x] Write worked examples with verified math (losing too fast, surplus on track, maintain drift,
      clamp, insufficient data)
- [x] Write edge-case scenarios: gaps, mid-stream goal change, unit switching, backdated edit, safety rail
- [x] Write non-functional requirements: < 5 s weigh-in flow, < 100 ms recompute, offline-only, test coverage
- [x] Write roadmap: v1 weight feature, v1.x workouts, v2 nutrition + optional sync

## 7. Finalize

- [x] Consistency review: verify all kcal↔kg conversions and worked-example arithmetic
- [x] Add minimal `README.md` pointing to the spec
- [x] Commit and push to `claude/training-app-spec-8ldop0`
