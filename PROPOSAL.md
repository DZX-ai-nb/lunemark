# Lunemark Lunar Rhythm Engine 项目申报书

## 项目基本信息

项目名称：Lunemark Phase Window Scorer  
项目类型：原创 MoonBit 开源库 / 月相感知规划窗口评分工具  
项目负责人：丁子玄  
GitHub 账号：DZX-ai-nb  
代码仓库：<https://github.com/DZX-ai-nb/lunemark>  
mooncakes.io：<https://mooncakes.io/docs/DZX-ai-nb/lunemark@0.3.0>  
开源许可证：Apache-2.0

## 针对初审反馈的修改

上一版 `Lunemark Originality Atlas` 因与 `constraint-lens` 在新颖性与撞题审查方向存在实质重叠而未通过初审。本次补救版已移除该方向，不再做项目相似度判断、报名材料审查或仓库质量审计，也不作为 `constraint-lens` 的扩展项目提交。新的项目定位是 MoonBit 月相感知规划窗口评分器，核心功能转为日期、月相、场景化窗口评分和 iCalendar 导出，功能边界与初审反馈中提到的项目不同。

公开检索也发现 `tyme4mb` 已覆盖中国传统历法、农历、节气、八字、宜忌和月相等大型历法能力，`moon-schedule` 已覆盖 Cron 与 RFC 5545 RRULE 的确定性日程规则。Lunemark 不重复这些方向：它不做农历/节气/八字，也不实现 Cron/RRULE 复发规则；它的核心是把粗粒度月相信号、月份和使用场景输入到内置规则目录，输出可排序的规划窗口分数和轻量 ICS 事件文本。

## 项目现有基础

Lunemark 现在是一个以 MoonBit 为主要实现语言的确定性月相感知规划窗口评分库。项目包含 MoonBit 核心库、命令行示例、可导入示例包、测试、README、CI、设计文档、发布文档、更新日志和 Apache-2.0 许可证。当前 MoonBit 源码超过 4k 有效行，其中 `lunemark_catalog.mbt` 提供 576 条 `RhythmRule`，这些规则会被 `matching_rules` 遍历并通过 `catalog_score` 进入最终评分，不是空白填充。

## 本次计划开发或新增内容

本次重新提交的新增内容包括：`CivilDate` 日期模型、日期合法性检查、`MoonPhase` 八阶段月相模型、`RhythmLane` 六类规划场景、确定性月龄和照明比例估算、按月份/月相/场景匹配的规则目录、单日节律报告、连续日期分析、最佳窗口排序、紧凑 badge 输出、自定义阈值筛选和 iCalendar 文本导出。

## 预期目标和技术路线

项目目标是为 MoonBit 应用提供一个可复用、可测试、可离线运行的轻量日历规则内核。技术路线是先用整数 Julian Day Number 算法把公历日期转为连续日序，再基于固定朔月锚点和朔望月周期估算月相、月龄与照明比例，随后结合内置规则目录对不同规划场景进行评分。该方案不依赖网络服务或第三方运行时库，适合在 CLI、Wasm、CI 和教学示例中复现。

## 预计完成的功能、测试和文档

预计交付功能包括：日期格式化、日期合法性判断、月相估算、月相节律评分、规则匹配、日期区间分析、最佳窗口筛选、终端报告、badge 输出和 ICS 导出。测试覆盖已知新月锚点、日期合法性、跨度分析、最佳窗口排序、规则目录规模、规则匹配参与评分、公开 API 报告格式、自定义 ICS 阈值和 ICS 导出。文档包括 `README.md`、`SUBMISSION.md`、`docs/DESIGN.md`、`docs/TESTING.md`、`docs/RELEASE.md`、`docs/RESUBMISSION.md`、`docs/SELF_CHECK.md`、`CHANGELOG.md` 和 `NOTICE.md`。

## 功能边界和维护价值

Lunemark 不替代专业天文历书，不输出地点相关潮汐结果，也不处理报名材料、仓库质量或项目相似度结论。它只提供确定性月相节律信号和日历文本生成。后续可维护方向包括：更精细的天文近似模型、地点时区适配、更多日历格式、JSON 输出、规则目录分层和与 MoonBit Wasm 前端示例结合。

## 开源合规说明

Lunemark 是原创实现项目，不属于移植项目；当前没有第三方运行时代码依赖，也没有外部素材。项目采用 Apache-2.0 许可证，仓库根目录提供 `LICENSE` 和 `NOTICE.md`。如果后续引入外部历表、地点数据或示例素材，将在文档中补充来源、许可证和使用范围。
