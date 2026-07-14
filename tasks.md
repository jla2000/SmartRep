# SmartRep — Implementation Tasks

Implementation checklist derived from [SPEC.md](SPEC.md). Check items off as they are implemented.

## 1. Project setup

- [ ] Create Flutter project (iOS + Android) with `data/` / `domain/` / `presentation/` layering (§4.2)
- [ ] Add dependencies: drift, riverpod, fl_chart, flutter_local_notifications (§4.1)
- [ ] Set up CI: analyze, format check, unit tests
- [ ] Set up drift database with schema: `weight_entries`, `goals`, `settings`, `recommendation_log` (§4.3)

## 2. Weigh-in (§2.1)

- [ ] Weight entry model + DAO: one entry per calendar day, overwrite with confirmation (W-1)
- [ ] Unit handling: kg/lb display, canonical kg storage at 0.05 kg precision (W-3)
- [ ] Input validation: 20–350 kg range, > 5 % jump typo confirmation (W-4)
- [ ] Edit, delete, and back-date entries with immediate recompute of derived values (W-2, W-8)
- [ ] Optional note per entry (W-7)
- [ ] Daily reminder notification with user-chosen time, deep link to entry field, default off (W-5)

## 3. Goals (§2.2)

- [ ] Goal model + DAO: single active goal, deactivate-and-keep on change (G-1)
- [ ] Rate mode input (kg or lb, per week or per month) with normalization to kg/week
- [ ] Energy mode input (kcal/day) with normalization via 7700 kcal ≈ 1 kg
- [ ] Live conversion preview showing the other representation in the goal editor
- [ ] Maintain as first-class goal, `target_rate = 0` (G-2)
- [ ] Safety rails: warning above 1 % body weight/week loss or 0.5 kg/week gain; hard cap ±1.5 % (G-3)
- [ ] Optional target weight with projected arrival date, display-only (G-4)

## 4. Trend & recommendation engine (§2.3–2.4, pure domain logic)

- [ ] `trend.dart`: rolling 7-day trend weight, min. 3 entries per window (§2.3a)
- [ ] Weekly blocks from goal `start_date`, valid at ≥ 3 entries, block averages (§2.3b)
- [ ] Actual rate: OLS slope over last 4 valid block averages (min. 2), true block indices as x-values
- [ ] Edge cases: skip invalid blocks, exclude incomplete current block, reset blocks on goal change
- [ ] `recommendation.dart`: `adjustment = (target_rate − actual_rate) × 7700 / 7`, rounded to 10 kcal
- [ ] Statuses with thresholds: `insufficient_data` / `on_track` (< 50) / `eat_more` / `eat_less` (§2.4)
- [ ] Damping: update once per completed block (R-1), ±500 kcal/day clamp (R-2),
      require 2 valid blocks (R-3), reset after goal change (R-4)
- [ ] Persist recommendations to `recommendation_log` so the pinned card survives restarts
- [ ] Unit tests for all worked examples in §5.1 and edge cases in §5.2

## 5. Screens (§2.5)

- [ ] App shell: bottom nav with Weight, Workouts (placeholder), Nutrition (placeholder), Settings (§3)
- [ ] Dashboard: trend weight + weekly delta, goal summary, recommendation card, quick-add button
- [ ] Weigh-in entry: numeric pad pre-filled with last weight, date defaults to today, < 5 s flow
- [ ] History: reverse-chronological list, swipe to edit/delete, back-dating
- [ ] Chart: raw dots + trend line + goal projection line, 1M/3M/6M/1Y/all ranges,
      weekly-averages overlay toggle
- [ ] Goal setup wizard: direction → mode → value with live conversion → safety check → confirm
- [ ] Settings: units, advice display style (qualitative/numeric/both), reminder, CSV export, full erase

## 6. Release readiness (§5.3)

- [ ] Performance: derived values recompute in < 100 ms with 5 years of daily data
- [ ] Verify full functionality offline from first launch
- [ ] Widget/integration tests for the weigh-in and goal-setup flows
- [ ] App icons, store metadata, iOS + Android release builds
