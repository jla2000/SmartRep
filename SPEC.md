# SmartRep — Product & Technical Specification

| | |
|---|---|
| **Version** | 1.0 (draft) |
| **Date** | 2026-07-14 |
| **Status** | Proposed |
| **Platforms** | iOS, Android (Flutter) |

---

## 1. Overview & Goals

SmartRep is a cross-platform training app. Its core v1 feature is **adaptive weight management**: the user weighs in daily, sets a goal for how fast they want to gain, lose, or maintain weight, and the app tells them whether — and by how much — to eat more or less to stay on track.

The key insight the app is built around: **daily scale weight is noisy** (water retention, glycogen, gut content, salt intake can swing it by ±1–2 kg day to day), so no decision is ever made from a single weigh-in. All progress math runs on **weekly averages**, and recommendations adapt to the *trend*, not the last number on the scale.

### 1.1 Goals

- Make daily weigh-ins effortless (< 5 seconds from app open to saved entry).
- Let users express their goal in whichever form is natural to them: a rate of change ("lose 1 kg per month") or an energy target ("stay in a 250 kcal surplus").
- Turn the gap between planned and actual progress into actionable eating guidance, as a qualitative message, a concrete kcal/day number, or both (user-configurable).
- Be honest about uncertainty: while there isn't enough data, say so instead of guessing.
- Work fully offline. All data stays on the device.

### 1.2 Non-goals (v1)

- Cloud sync, user accounts, or any backend.
- Food logging / calorie-counting database (the app recommends *adjustments*, it does not track intake).
- Wearable / smart-scale integrations.
- Workout and nutrition modules (placeholder only, see §3).

---

## 2. Core Feature: Weight Tracking & Adaptive Recommendations

### 2.1 Daily weigh-in

**Requirements**

- **W-1** The user can record exactly one weight entry per calendar day (local time zone). Entering a weight on a day that already has one overwrites it after confirmation.
- **W-2** Entries can be edited and deleted from the history at any time; all derived values (averages, trend, recommendation) recompute immediately.
- **W-3** Weight is entered and displayed in the user's chosen unit (**kg** or **lb**) but is always stored canonically in **kg** as a decimal with 0.05 kg precision (1 lb = 0.45359237 kg).
- **W-4** Valid input range: 20.0–350.0 kg. Values outside the range are rejected; a value differing from the previous entry by more than 5 % prompts a "was this a typo?" confirmation but is accepted.
- **W-5** An optional daily reminder notification fires at a user-chosen time and deep-links straight to the entry field. Default: off.
- **W-6** Missed days are allowed and expected. The algorithm (§2.3) is defined to tolerate gaps; the app never scolds the user for missing a day.
- **W-7** An entry may carry an optional free-text note (e.g. "after vacation", "new scale").
- **W-8** Entries can be back-dated to any past day via the history screen.

### 2.2 Goal setting

A goal answers one question: *how fast should my weight change?* The user picks **one** of two equivalent input modes; the app converts between them so the engine always works with a single normalized quantity.

**Modes**

| Mode | User input | Examples |
|---|---|---|
| **Rate mode** | Target rate of weight change, in kg (or lb) per week **or** per month | "−1 kg / month", "+0.25 kg / week", "0 (maintain)" |
| **Energy mode** | Target daily caloric surplus or deficit, in kcal/day | "+250 kcal/day", "−300 kcal/day" |

**Normalization**

All goals are stored internally as `target_rate` in **kg/week** (positive = gain, negative = lose, 0 = maintain), using:

- 1 month = 30.44 days (365.25 / 12), so `kg/month × 7 / 30.44 = kg/week`
- **7700 kcal ≈ 1 kg** of body weight, so `kcal/day × 7 / 7700 = kg/week`

Examples: "−1 kg/month" → −0.23 kg/week. "+250 kcal/day" → +0.23 kg/week.

The goal editor always shows the *other* representation live ("−0.5 kg/week ≈ a 550 kcal daily deficit") so users learn the equivalence.

**Requirements**

- **G-1** Exactly one goal is active at a time. Creating a new goal deactivates (but keeps) the previous one; the goal's `start_date` anchors the recommendation cadence (§2.4).
- **G-2** Maintain is a first-class goal (`target_rate = 0`), not the absence of a goal.
- **G-3** Safety rails: if the target loss rate exceeds **1 % of current body weight per week**, or the target gain rate exceeds **0.5 kg/week**, the app shows a non-blocking warning explaining why slower is usually better. Hard cap: goals beyond ±1.5 % body weight per week cannot be saved.
- **G-4** A goal may optionally include a **target weight**; when set, the dashboard shows a projected date of arrival based on the current actual rate (§2.3). The target weight never affects recommendations — only the rate does.
- **G-5** Changing the goal takes effect immediately; past recommendations are not rewritten.

### 2.3 Trend calculation (weekly averages)

All progress math uses smoothed values derived from raw entries. Two derived series are defined:

**(a) Trend weight (for display).** The rolling 7-day average, computed for each day `d` that has an entry:

```
trend(d) = mean of all entries in days [d−6 … d]
```

Shown as the smooth line on the chart and as the headline "current weight" on the dashboard. Defined whenever at least **3 entries** exist in the window; otherwise the raw entry is shown, visually marked as unsmoothed.

**(b) Weekly averages and actual rate (for the engine).** Time since the active goal's `start_date` is divided into consecutive, non-overlapping 7-day **blocks**. A block is **valid** if it contains ≥ 3 entries; its value is the mean of its entries.

```
avg(k)        = mean of entries in block k          (valid iff ≥ 3 entries)
actual_rate   = slope, in kg/week, of the ordinary least-squares line fitted
                through the valid block averages of the last 4 blocks
                (minimum 2 valid blocks), x = block index, y = avg(k)
```

Using a regression over up to 4 weekly points (rather than just the difference of the last two) keeps one anomalous week from whipsawing the recommendation, while still responding within a couple of weeks to a real change.

**Edge cases**

| Situation | Behavior |
|---|---|
| Fewer than 2 valid blocks | No `actual_rate`; engine reports *insufficient data* (§2.4) |
| An invalid block (< 3 entries) between valid ones | Skipped; regression uses the true block indices as x-values, so gaps don't distort the slope |
| Current (incomplete) block | Never included until its 7 days have elapsed |
| Goal changed | Blocks restart from the new goal's `start_date`; earlier weekly averages remain visible on the chart but don't feed the new goal's rate |
| Backdated edits/deletions | Affected block averages and the rate recompute immediately (W-2) |

### 2.4 Recommendation engine

Once per completed block (i.e. every 7 days from the goal's `start_date`), the engine compares plan to reality:

```
gap        = target_rate − actual_rate          (kg/week)
adjustment = gap × 7700 / 7                     (kcal/day, rounded to nearest 10)
```

A positive `adjustment` means *eat more*; negative means *eat less*.

**Statuses**

| Status | Condition | Example message |
|---|---|---|
| `insufficient_data` | < 2 valid weekly blocks | "Collecting data — keep weighing in. First guidance in N days." |
| `on_track` | \|adjustment\| < 50 kcal/day | "Right on track. Keep doing what you're doing." |
| `eat_more` | adjustment ≥ 50 kcal/day | "You're losing faster than planned — eat a bit more." |
| `eat_less` | adjustment ≤ −50 kcal/day | "Progress is slower than planned — trim your portions a little." |

**Damping rules** (to prevent overreaction to noise):

- **R-1** Recommendations update at most **once per completed 7-day block**, never daily. Between updates the last recommendation stays pinned to the dashboard with its date.
- **R-2** The displayed adjustment is **clamped to ±500 kcal/day**. If the raw value exceeds the clamp, the message adds "…and consider whether your goal is realistic," with a shortcut to the goal editor.
- **R-3** No recommendation is issued until 2 valid weekly blocks exist (`insufficient_data` until then — typically the first 14 days).
- **R-4** After a goal change, the engine returns to `insufficient_data` and re-earns its first recommendation under the new goal.

**Advice display style** — a user setting with three options (default **both**):

| Setting | Dashboard card shows |
|---|---|
| Qualitative | Message only ("eat a bit more") |
| Numeric | kcal number only ("+180 kcal/day") |
| Both | Message with the number as supporting detail |

The underlying computation is identical in all three; only presentation differs.

### 2.5 UI screens

1. **Dashboard (home).** Current trend weight (§2.3a) with delta vs. last week; goal summary ("−1 kg/month · started 12 May"); the active recommendation card (status color + message per §2.4); prominent quick-add weigh-in button. If G-4 target weight is set: projected arrival date.
2. **Weigh-in entry.** Numeric pad pre-filled with the last weight, date defaulting to today, optional note. One tap to save (< 5 s total, Goal 1.1).
3. **History.** Reverse-chronological list of entries (date, weight, note) with swipe to edit/delete; back-dating supported.
4. **Chart.** Raw daily entries as dots, trend line (rolling 7-day average) as a smooth curve, and the goal projection line from the goal's start weight at `target_rate`. Ranges: 1M / 3M / 6M / 1Y / all. Weekly block averages available as an overlay toggle.
5. **Goal setup wizard.** Choose direction (lose / maintain / gain) → choose mode (rate or energy) → enter value with live conversion to the other representation → safety check (G-3) → confirm.
6. **Settings.** Units (kg/lb), advice display style (§2.4), reminder on/off + time, data export (CSV) and full erase.

---

## 3. App Skeleton (future modules sketched)

SmartRep ships with a bottom-navigation shell of four tabs. Only **Weight** is functional in v1; placeholders communicate the roadmap without dead-ends.

| Tab | v1 state | Sketch |
|---|---|---|
| **Weight** | Full feature (§2) | — |
| **Workouts** | Placeholder | Rep/set/exercise logging, routines, progression tracking. Will write `workout_sessions` tables into the same local DB and contribute a "trained today" marker to the dashboard. |
| **Nutrition** | Placeholder | Optional meal logging. Would let the recommendation engine compare *actual* intake against the recommended adjustment instead of assuming the user's baseline is constant. |
| **Settings** | Functional (§2.5.6) | — |

Design rule for future modules: each module owns its own tables and screens, communicates with others only through the shared database and a small set of dashboard widget slots. The weight engine (§2.3–2.4) is pure domain logic with no knowledge of other modules.

---

## 4. Technical Architecture

### 4.1 Stack

- **Flutter + Dart**, single codebase for iOS and Android.
- Suggested packages: **drift** (typed local SQLite; `sqflite` acceptable fallback), **riverpod** (state management), **fl_chart** (charts), **flutter_local_notifications** (weigh-in reminder).

### 4.2 Layering

```
lib/
  data/           # drift database, tables, DAOs, settings store
  domain/         # entities + pure logic: trend.dart, recommendation.dart, goal_conversion.dart
  presentation/   # screens, widgets, riverpod providers
```

The trend and recommendation algorithms (§2.3–2.4) live in `domain/` as **pure functions** of `(entries, goal, today)` with no I/O — every formula and edge case in this spec maps 1:1 to a unit test.

### 4.3 Data model

```sql
weight_entries (
  date        TEXT PRIMARY KEY,   -- ISO-8601 local calendar day, e.g. '2026-07-14'
  weight_kg   REAL NOT NULL,      -- canonical kg (W-3)
  note        TEXT
);

goals (
  id                      INTEGER PRIMARY KEY,
  mode                    TEXT NOT NULL,      -- 'rate' | 'energy' (what the user typed, for display)
  target_rate_kg_per_week REAL NOT NULL,      -- normalized value the engine uses
  target_kcal_delta       REAL,               -- as entered, if mode = 'energy'
  target_weight_kg        REAL,               -- optional (G-4)
  start_date              TEXT NOT NULL,
  active                  INTEGER NOT NULL DEFAULT 1
);

settings (key TEXT PRIMARY KEY, value TEXT);  -- unit, advice_style, reminder_time, …
```

Derived values (trend, block averages, actual rate, recommendation) are **computed, never stored**, except a small `recommendation_log` (date, status, adjustment) kept so the pinned card (R-1) survives restarts and history is auditable.

---

## 5. Acceptance Criteria & Test Scenarios

### 5.1 Worked examples (must pass as unit tests)

1. **Losing too fast.** Goal: −1 kg/month → target −0.23 kg/week. Weekly averages give actual −0.50 kg/week. Gap = −0.23 − (−0.50) = **+0.27 kg/week** → adjustment = 0.27 × 7700 / 7 ≈ **+300 kcal/day** → status `eat_more`, "You're losing faster than planned."
2. **Surplus goal, on track.** Goal: +250 kcal/day → target +0.23 kg/week. Actual +0.20 kg/week. Gap = +0.03 kg/week → adjustment ≈ +30 kcal/day → \|30\| < 50 → status `on_track`.
3. **Maintain, drifting up.** Goal: 0 kg/week. Actual +0.15 kg/week. Adjustment = −0.15 × 1100 ≈ **−170 kcal/day** → status `eat_less`.
4. **Clamp.** Goal −0.25 kg/week, actual +0.60 kg/week (holiday fortnight). Raw adjustment = −0.85 × 1100 ≈ −940 kcal/day → displayed as **−500 kcal/day** (R-2) with the "is your goal realistic?" note.
5. **Insufficient data.** Days 1–13 of a new goal: only 1 complete block → status `insufficient_data`, countdown message (R-3).

### 5.2 Edge-case scenarios

- **Gaps:** user weighs in Mon/Wed/Fri only → blocks remain valid (3 entries); a week-long vacation with 0 entries → that block invalid, regression skips it using true block indices, no recommendation update that week.
- **Goal change mid-stream:** switching from −1 kg/month to maintain on day 20 → engine resets to `insufficient_data` (R-4); chart history intact.
- **Unit switching:** entering 176.4 lb, switching settings to kg, displays 80.0 kg; stored value unchanged.
- **Backdated edit:** correcting a typo (85.0 → 58.0 rejected as > 5 % jump unless confirmed, W-4) recomputes the affected block average and may flip the status.
- **Safety rail:** 70 kg user entering "−1 kg/week" (1.4 %) sees the warning (G-3); "−1.2 kg/week" (1.7 %) cannot be saved.

### 5.3 Non-functional

- Weigh-in flow completable in < 5 s; all derived values recompute in < 100 ms for 5 years of daily data.
- App fully functional in airplane mode from first launch.
- All algorithm code covered by unit tests implementing §5.1–5.2 verbatim.

---

## 6. Roadmap

| Release | Contents |
|---|---|
| **v1.0** | Weight feature complete (§2), app shell (§3), settings, CSV export |
| **v1.x** | Workouts module: exercises, sets/reps, routines, progression |
| **v2.0** | Nutrition module (meal logging feeding the engine); optional encrypted device-to-device sync |
