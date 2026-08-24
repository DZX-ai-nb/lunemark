///|
/// A plain Gregorian date used by Lunemark's deterministic lunar engine.
pub(all) struct CivilDate {
  year : Int
  month : Int
  day : Int
} derive(Eq, Debug)

///|
/// Eight coarse Moon phases derived from a synodic-month approximation.
pub(all) enum MoonPhase {
  NewMoon
  WaxingCrescent
  FirstQuarter
  WaxingGibbous
  FullMoon
  WaningGibbous
  LastQuarter
  WaningCrescent
} derive(Eq, Debug)

///|
/// Practical planning lanes that can use lunar rhythm as a deterministic signal.
pub(all) enum RhythmLane {
  NightSky
  TideWatch
  GardenPlanning
  DeepWork
  WellnessRest
  EventTiming
} derive(Eq, Debug)

///|
/// One catalog rule used to adjust a lane score for a phase and month.
pub(all) struct RhythmRule {
  id : String
  month : Int
  phase : MoonPhase
  lane : RhythmLane
  weight : Int
  label : String
} derive(Eq, Debug)

///|
/// A complete analysis for one date and one planning lane.
pub(all) struct DayRhythm {
  date : CivilDate
  phase : MoonPhase
  lunar_day : Int
  illumination : Int
  lane : RhythmLane
  score : Int
  tide_bias : String
  advice : Array[String]
  rules : Array[RhythmRule]
  signature : String
} derive(Eq, Debug)

///|
/// Build a date value without exposing calendar internals.
pub fn date(year : Int, month : Int, day : Int) -> CivilDate {
  CivilDate::{ year, month, day }
}

///|
/// Return whether a year follows Gregorian leap-year rules.
pub fn is_leap_year(year : Int) -> Bool {
  year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
}

///|
/// Number of days in a Gregorian month. Returns 0 for invalid months.
pub fn days_in_month(year : Int, month : Int) -> Int {
  match month {
    1 | 3 | 5 | 7 | 8 | 10 | 12 => 31
    4 | 6 | 9 | 11 => 30
    2 => if is_leap_year(year) { 29 } else { 28 }
    _ => 0
  }
}

///|
/// Validate the supported Gregorian date range.
pub fn is_valid_date(day : CivilDate) -> Bool {
  day.year >= 1600 &&
  day.year <= 9999 &&
  day.month >= 1 &&
  day.month <= 12 &&
  day.day >= 1 &&
  day.day <= days_in_month(day.year, day.month)
}

///|
/// Return the estimated phase for one date.
pub fn phase_on(day : CivilDate) -> MoonPhase {
  phase_from_cycle(lunar_cycle_millis(day))
}

///|
/// Return the estimated lunar day in the current synodic cycle.
pub fn lunar_day_on(day : CivilDate) -> Int {
  lunar_cycle_millis(day) / 1000
}

///|
/// Return the approximate illuminated percentage for one date.
pub fn illumination_on(day : CivilDate) -> Int {
  illumination_from_cycle(lunar_cycle_millis(day))
}

///|
/// Analyze one day for a given planning lane.
pub fn analyze_day(day : CivilDate, lane : RhythmLane) -> DayRhythm {
  let cycle = lunar_cycle_millis(day)
  let phase = phase_from_cycle(cycle)
  let lunar_day = cycle / 1000
  let illumination = illumination_from_cycle(cycle)
  let rules = matching_rules(day, phase, lane)
  let score = clamp_int(
    base_lane_score(phase, lane, illumination) + catalog_score(rules),
    0,
    100,
  )
  DayRhythm::{
    date: day,
    phase,
    lunar_day,
    illumination,
    lane,
    score,
    tide_bias: tide_bias(phase, illumination),
    advice: lane_advice(phase, lane, score),
    rules,
    signature: rhythm_signature(day, phase, lane, score),
  }
}

///|
/// Analyze a consecutive span of days.
pub fn analyze_span(
  start : CivilDate,
  days : Int,
  lane : RhythmLane,
) -> Array[DayRhythm] {
  let result = []
  let mut i = 0
  let total = clamp_int(days, 0, 366)
  let start_jdn = to_jdn(start)
  while i < total {
    result.push(analyze_day(from_jdn(start_jdn + i), lane))
    i = i + 1
  }
  result
}

///|
/// Return the highest scoring windows from a span.
pub fn best_windows(
  start : CivilDate,
  days : Int,
  lane : RhythmLane,
  limit : Int,
) -> Array[DayRhythm] {
  let items = analyze_span(start, days, lane)
  items.sort_by((a, b) => b.score - a.score)
  take_days(items, limit)
}

///|
/// Format one day as terminal-friendly text.
pub fn format_day_report(report : DayRhythm) -> String {
  let out = StringBuilder()
  out.write_string(
    "Lunemark lunar rhythm for " + format_date(report.date) + "\n",
  )
  out.write_string("phase: " + report.phase.label() + "\n")
  out.write_string(
    "lunar day: " +
    report.lunar_day.to_string() +
    ", illumination: " +
    report.illumination.to_string() +
    "%\n",
  )
  out.write_string("lane: " + report.lane.label() + "\n")
  out.write_string("score: " + report.score.to_string() + "/100\n")
  out.write_string("tide bias: " + report.tide_bias + "\n")
  out.write_string("signature: " + report.signature + "\n")
  out.write_string("advice:\n")
  for item in report.advice {
    out.write_string("- " + item + "\n")
  }
  if report.rules.is_empty() {
    out.write_string("catalog rules: none\n")
  } else {
    out.write_string("catalog rules:\n")
    for rule in report.rules {
      out.write_string(
        "- " +
        rule.id +
        " +" +
        rule.weight.to_string() +
        " " +
        rule.label +
        "\n",
      )
    }
  }
  out.to_string()
}

///|
/// Compact one-line badge for logs and examples.
pub fn rhythm_badge(report : DayRhythm) -> String {
  "Lunemark " +
  report.phase.label() +
  " " +
  report.score.to_string() +
  "% " +
  report.signature
}

///|
/// Export high-scoring days from a span as a tiny iCalendar document.
pub fn export_ics(
  title : String,
  start : CivilDate,
  days : Int,
  lane : RhythmLane,
) -> String {
  export_ics_with_threshold(title, start, days, lane, 70)
}

///|
/// Export days at or above a chosen score threshold as iCalendar events.
pub fn export_ics_with_threshold(
  title : String,
  start : CivilDate,
  days : Int,
  lane : RhythmLane,
  minimum_score : Int,
) -> String {
  let threshold = clamp_int(minimum_score, 0, 100)
  let out = StringBuilder()
  out.write_string("BEGIN:VCALENDAR\n")
  out.write_string("VERSION:2.0\n")
  out.write_string("PRODID:-//Lunemark//MoonBit//EN\n")
  for item in analyze_span(start, days, lane) {
    if item.score >= threshold {
      out.write_string("BEGIN:VEVENT\n")
      out.write_string("UID:" + item.signature + "@lunemark\n")
      out.write_string("DTSTART;VALUE=DATE:" + compact_date(item.date) + "\n")
      out.write_string(
        "SUMMARY:" +
        title +
        " - " +
        item.phase.label() +
        " " +
        item.score.to_string() +
        "\n",
      )
      out.write_string(
        "DESCRIPTION:" +
        item.lane.label() +
        "; illumination " +
        item.illumination.to_string() +
        "%; " +
        item.tide_bias +
        "\n",
      )
      out.write_string("END:VEVENT\n")
    }
  }
  out.write_string("END:VCALENDAR\n")
  out.to_string()
}

///|
/// Return true when a report reaches the default export threshold.
pub fn is_high_window(report : DayRhythm) -> Bool {
  report.score >= 70
}

///|
/// Human-facing phase labels.
pub fn MoonPhase::label(self : MoonPhase) -> String {
  match self {
    NewMoon => "New Moon"
    WaxingCrescent => "Waxing Crescent"
    FirstQuarter => "First Quarter"
    WaxingGibbous => "Waxing Gibbous"
    FullMoon => "Full Moon"
    WaningGibbous => "Waning Gibbous"
    LastQuarter => "Last Quarter"
    WaningCrescent => "Waning Crescent"
  }
}

///|
/// Human-facing lane labels.
pub fn RhythmLane::label(self : RhythmLane) -> String {
  match self {
    NightSky => "night-sky observation"
    TideWatch => "tide watch"
    GardenPlanning => "garden planning"
    DeepWork => "deep work"
    WellnessRest => "wellness rest"
    EventTiming => "event timing"
  }
}

///|
pub fn format_date(day : CivilDate) -> String {
  day.year.to_string() +
  "-" +
  pad2(day.month.to_string()) +
  "-" +
  pad2(day.day.to_string())
}

///|
pub fn compact_date(day : CivilDate) -> String {
  day.year.to_string() + pad2(day.month.to_string()) + pad2(day.day.to_string())
}

///|
pub fn matching_rules(
  day : CivilDate,
  phase : MoonPhase,
  lane : RhythmLane,
) -> Array[RhythmRule] {
  let hits = []
  for rule in rhythm_rule_catalog() {
    if rule.month == day.month && rule.phase == phase && rule.lane == lane {
      hits.push(rule)
    }
  }
  hits
}

///|
fn lunar_cycle_millis(day : CivilDate) -> Int {
  positive_mod((to_jdn(day) - 2451550) * 1000, 29530)
}

///|
fn phase_from_cycle(cycle : Int) -> MoonPhase {
  if cycle < 1845 {
    NewMoon
  } else if cycle < 5537 {
    WaxingCrescent
  } else if cycle < 9228 {
    FirstQuarter
  } else if cycle < 12920 {
    WaxingGibbous
  } else if cycle < 16611 {
    FullMoon
  } else if cycle < 20303 {
    WaningGibbous
  } else if cycle < 23995 {
    LastQuarter
  } else if cycle < 27685 {
    WaningCrescent
  } else {
    NewMoon
  }
}

///|
fn illumination_from_cycle(cycle : Int) -> Int {
  if cycle <= 14765 {
    cycle * 100 / 14765
  } else {
    (29530 - cycle) * 100 / 14765
  }
}

///|
fn base_lane_score(
  phase : MoonPhase,
  lane : RhythmLane,
  illumination : Int,
) -> Int {
  match lane {
    NightSky => 100 - illumination
    TideWatch =>
      if phase == NewMoon || phase == FullMoon {
        86
      } else if phase == FirstQuarter || phase == LastQuarter {
        54
      } else {
        68
      }
    GardenPlanning =>
      match phase {
        NewMoon => 82
        WaxingCrescent => 78
        FirstQuarter => 72
        WaxingGibbous => 66
        FullMoon => 58
        WaningGibbous => 62
        LastQuarter => 70
        WaningCrescent => 76
      }
    DeepWork =>
      if illumination <= 35 {
        84
      } else if illumination >= 80 {
        58
      } else {
        70
      }
    WellnessRest =>
      if phase == WaningCrescent || phase == NewMoon {
        86
      } else {
        64
      }
    EventTiming =>
      if illumination >= 60 && illumination <= 95 {
        80
      } else {
        62
      }
  }
}

///|
fn catalog_score(rules : Array[RhythmRule]) -> Int {
  let mut total = 0
  for rule in rules {
    total = total + rule.weight
  }
  total
}

///|
fn tide_bias(phase : MoonPhase, illumination : Int) -> String {
  if phase == NewMoon || phase == FullMoon {
    "spring-tide watch"
  } else if illumination <= 15 {
    "low-light planning"
  } else if phase == FirstQuarter || phase == LastQuarter {
    "neap-tide watch"
  } else {
    "moderate lunar pull"
  }
}

///|
fn lane_advice(
  phase : MoonPhase,
  lane : RhythmLane,
  score : Int,
) -> Array[String] {
  let items = []
  if score >= 80 {
    items.push("mark this date as a primary window")
  } else if score >= 65 {
    items.push("use this date as a backup window")
  } else {
    items.push("avoid treating this date as the main window")
  }
  items.push("current phase is " + phase.label())
  match lane {
    NightSky =>
      items.push("prefer darker phases for visibility and simple equipment")
    TideWatch =>
      items.push("pair the phase signal with local tide tables before action")
    GardenPlanning =>
      items.push("use the phase as a repeatable planning cue, not as biology")
    DeepWork => items.push("reserve low-light phases for quiet focus blocks")
    WellnessRest =>
      items.push("use waning phases to plan lower-intensity routines")
    EventTiming =>
      items.push("use brighter phases for outdoor ambience and visibility")
  }
  items.push("computed by a deterministic MoonBit calendar model")
  items
}

///|
fn take_days(items : Array[DayRhythm], limit : Int) -> Array[DayRhythm] {
  let result = []
  let mut i = 0
  let capped = clamp_int(limit, 0, items.length())
  while i < capped {
    result.push(items[i])
    i = i + 1
  }
  result
}

///|
fn rhythm_signature(
  day : CivilDate,
  phase : MoonPhase,
  lane : RhythmLane,
  score : Int,
) -> String {
  let seed = to_jdn(day) * 17 + phase_index(phase) * 97 + lane_index(lane) * 31
  let token = positive_mod(seed + score * 13, 46656)
  "LNR-" + score.to_string() + "-" + pad3(token.to_string(radix=36))
}

///|
fn phase_index(phase : MoonPhase) -> Int {
  match phase {
    NewMoon => 0
    WaxingCrescent => 1
    FirstQuarter => 2
    WaxingGibbous => 3
    FullMoon => 4
    WaningGibbous => 5
    LastQuarter => 6
    WaningCrescent => 7
  }
}

///|
fn lane_index(lane : RhythmLane) -> Int {
  match lane {
    NightSky => 0
    TideWatch => 1
    GardenPlanning => 2
    DeepWork => 3
    WellnessRest => 4
    EventTiming => 5
  }
}

///|
fn to_jdn(day : CivilDate) -> Int {
  let a = (14 - day.month) / 12
  let y = day.year + 4800 - a
  let m = day.month + 12 * a - 3
  day.day + (153 * m + 2) / 5 + 365 * y + y / 4 - y / 100 + y / 400 - 32045
}

///|
fn from_jdn(jdn : Int) -> CivilDate {
  let a = jdn + 32044
  let b = (4 * a + 3) / 146097
  let c = a - 146097 * b / 4
  let d = (4 * c + 3) / 1461
  let e = c - 1461 * d / 4
  let m = (5 * e + 2) / 153
  CivilDate::{
    day: e - (153 * m + 2) / 5 + 1,
    month: m + 3 - 12 * (m / 10),
    year: 100 * b + d - 4800 + m / 10,
  }
}

///|
fn clamp_int(value : Int, low : Int, high : Int) -> Int {
  if value < low {
    low
  } else if value > high {
    high
  } else {
    value
  }
}

///|
fn positive_mod(value : Int, divisor : Int) -> Int {
  let result = value % divisor
  if result < 0 {
    result + divisor
  } else {
    result
  }
}

///|
fn pad2(value : String) -> String {
  if value.length() == 1 {
    "0" + value
  } else {
    value
  }
}

///|
fn pad3(value : String) -> String {
  if value.length() == 1 {
    "00" + value
  } else if value.length() == 2 {
    "0" + value
  } else {
    value
  }
}
