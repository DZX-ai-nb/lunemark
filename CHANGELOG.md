# Changelog

## 0.2.1 - 2026-08-21

### Changed

- 将公开发布辅助 API 术语统一为 `Milestone` / `MilestoneGap` / `CommitHistory`。
- README、mooncakes README 和 `docs/ORIGINALITY.md` 改为原创性星图优先表述，降低与发布材料类项目的误判风险。
- 近邻测试负样本从文件扫描形态改为发布里程碑规划形态，保留差异化检测能力。

### Published

- 发布到 mooncakes.io：<https://mooncakes.io/docs/DZX-ai-nb/lunemark>

## 0.2.0 - 2026-08-20

### Changed

- 主定位从里程碑打分器升级为 MoonBit 选题原创性星图。
- `moon.mod` 描述与关键词改为 originality、fingerprint、anti-collision。
- README 和 mooncakes README 增加公开选题排查、功能转向、代码规模和原创性示例。

### Added

- `IdeaProfile`、`Archetype`、`SimilarityHit` 和 `OriginalityReport`。
- 281 个内置项目原型，供 `closest_archetypes` 实际计算近邻相似度。
- `analyze_originality`、`format_originality_report` 和 `originality_badge`。
- `docs/ORIGINALITY.md`，记录公开选题排查和差异化方案。
- 原创性 API 测试和已知近重复检测测试。

## 0.1.0 - 2026-08-10

### Added

- 初始 MoonBit 库：发布里程碑枚举、评分、缺口清单、稳定签名和文本报告。
- CLI 示例：`moon run cmd/main`。
- 嵌入式示例包：`moon run examples/partial`。
- 5 个可运行测试，覆盖完整里程碑、草稿里程碑、重复里程碑和 badge 输出。
- GitHub Actions CI：格式检查、静态检查、构建、测试、示例运行。
- README、设计说明、测试记录、发布清单、Issue 模板和 Apache-2.0 许可证。

### Notes

- 发布到 mooncakes.io 前需要替换 `username/lunemark` 为真实 mooncakes.io 用户名。
