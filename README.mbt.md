# Lunemark

Lunemark 是一个用 MoonBit 实现的月相感知规划窗口评分器。它把公历日期转换为粗粒度月相、月龄、照明比例和场景化窗口分数，并能生成终端报告、紧凑 badge、最佳日期列表和 iCalendar 文本。

当前包名：`DZX-ai-nb/lunemark`  
GitHub 仓库：<https://github.com/DZX-ai-nb/lunemark>  
mooncakes.io：<https://mooncakes.io/docs/DZX-ai-nb/lunemark>

## 项目用途

Lunemark 面向需要稳定日期节律信号的 MoonBit 应用：天文观测计划、潮汐提醒前置筛选、园艺安排、活动日期选择、低干扰深度工作窗口和轻量个人日历工具。项目不调用外部网络服务，所有结果都由 MoonBit 代码和内置规则目录确定性生成，适合在 CI、示例项目和 Wasm 环境中复现。

## 公开相邻项目排查

公开检索发现 `tyme4mb` 已覆盖中国传统历法、农历、节气、八字、宜忌和月相等大型历法能力；`moon-schedule` 已覆盖 Cron 与 RFC 5545 RRULE 的确定性日程规则。Lunemark 不重复这些方向：它不做农历/节气/八字，也不实现 Cron/RRULE 复发规则；它的核心是把粗粒度月相信号、月份和使用场景输入到 576 条规则目录，输出可排序的规划窗口分数和轻量 ICS 事件文本。

## 主要功能

- 公历日期建模：`date`、`format_date`、`compact_date`
- 日期边界：`is_valid_date`、`is_leap_year`、`days_in_month`
- 月相估算：`NewMoon`、`FirstQuarter`、`FullMoon` 等 8 个阶段
- 轻量查询：`phase_on`、`lunar_day_on`、`illumination_on`
- 节律评分：按 `NightSky`、`TideWatch`、`GardenPlanning`、`DeepWork`、`WellnessRest`、`EventTiming` 六类规划场景计算窗口分
- 规则目录：`rhythm_rule_catalog` 提供 576 条月份、月相和场景规则，并在 `matching_rules` / `analyze_day` 中实际参与评分
- 日期窗口：`analyze_span` 和 `best_windows` 可对一段日期排序筛选
- 文本输出：`format_day_report`、`rhythm_badge`
- 日历导出：`export_ics` 和 `export_ics_with_threshold` 输出简洁 iCalendar 文本
- 测试覆盖：月相锚点、跨度分析、最佳窗口排序、规则目录、报告格式和 ICS 导出

## 功能边界

Lunemark 是月相感知规划窗口评分器，不处理报名材料、仓库质量、项目相似度或法律层面的许可证结论。月相计算采用适合软件规划的整数近似模型，不替代专业天文历书；潮汐和园艺建议只作为可重复的计划信号，实际使用时应结合地点、天气和专业数据。

## 快速开始

需要 MoonBit 工具链。

```sh
moon fmt --check
moon check --deny-warn
moon build
moon test
moon run cmd/main
moon run examples/partial
```

当前补救版已用 `moonc v0.10.10` 验证，满足群公告提出的 `>= v0.10.9` 要求。

主示例会输出某一天的月相节律报告、未来两周的最佳观测窗口和 iCalendar 文本：

```text
Lunemark lunar rhythm for 2026-08-24
phase: ...
lane: night-sky observation
score: .../100
signature: LNR-...
```

## 使用方法

在另一个 MoonBit 可执行包中导入：

```text
import {
  "DZX-ai-nb/lunemark" @lunemark,
}

pkgtype(kind: "executable")
```

分析单日：

```text
let day = @lunemark.date(2026, 9, 7)
let report = @lunemark.analyze_day(day, @lunemark.DeepWork)
println(@lunemark.rhythm_badge(report))
```

单独查询月相信号：

```text
let phase = @lunemark.phase_on(day)
let light = @lunemark.illumination_on(day)
println(phase.label() + " " + light.to_string())
```

筛选最佳窗口：

```text
let windows = @lunemark.best_windows(day, 14, @lunemark.NightSky, 3)
for item in windows {
  println(@lunemark.format_date(item.date) + " " + item.phase.label())
}
```

导出 iCalendar：

```text
let ics = @lunemark.export_ics("Night sky window", day, 30, @lunemark.NightSky)
println(ics)
```

使用自定义阈值导出：

```text
let ics = @lunemark.export_ics_with_threshold(
  "Event timing window",
  day,
  30,
  @lunemark.EventTiming,
  80,
)
println(ics)
```

## 代码规模

当前 MoonBit 源码超过 4k 有效行。`lunemark_catalog.mbt` 中的 576 条 `RhythmRule` 会被 `matching_rules` 遍历，并通过 `catalog_score` 进入最终窗口评分，不是空白填充。

## CI 和测试

GitHub Actions 工作流位于 `.github/workflows/ci.yml`，会运行：

- `moon fmt --check`
- `moon check --deny-warn`
- `moon build`
- `moon test`
- `moon run cmd/main`
- `moon run examples/partial`

本地测试命令：

```sh
moon test
```

## 发布

当前补救版版本号为 `0.3.0`。重新提交前需要在 GitHub 推送本版本，并执行 `moon publish` 让 mooncakes.io 页面同步到月相感知规划窗口评分器说明。

## 开源合规

项目代码使用 Apache-2.0。当前没有第三方运行时代码依赖，也没有外部素材。规则目录为项目内生成的确定性测试/评分数据。
