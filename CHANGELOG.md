# Changelog

## 0.2.0 - 2026-08-20

### Changed

- 主定位从验收打分器升级为 MoonBit 选题原创性星图。
- `moon.mod` 描述与关键词改为 originality、fingerprint、anti-collision。
- README 和 mooncakes README 增加查重处理、功能转向、代码规模和原创性示例。

### Added

- `IdeaProfile`、`Archetype`、`SimilarityHit` 和 `OriginalityReport`。
- 281 个内置项目原型，供 `closest_archetypes` 实际计算近邻相似度。
- `analyze_originality`、`format_originality_report` 和 `originality_badge`。
- `docs/ORIGINALITY.md`，记录发现相近项目及规避方案。
- 原创性 API 测试和已知近重复检测测试。

## 0.1.0 - 2026-08-10

### Added

- 初始 MoonBit 库：验收证据枚举、评分、缺口清单、稳定签名和文本报告。
- CLI 示例：`moon run cmd/main`。
- 嵌入式示例包：`moon run examples/partial`。
- 5 个可运行测试，覆盖完整证据、草稿证据、重复证据和 badge 输出。
- GitHub Actions CI：格式检查、静态检查、构建、测试、示例运行。
- README、设计说明、测试记录、发布清单、Issue 模板和 Apache-2.0 许可证。

### Notes

- 发布到 mooncakes.io 前需要替换 `username/lunemark` 为真实 mooncakes.io 用户名。
