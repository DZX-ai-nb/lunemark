# Lunemark Design

## 目标

Lunemark 的目标是提供一个 MoonBit 选题原创性星图。它先把项目想法编码成多维功能指纹，再和内置原型库做近邻比较，输出原创性分数、防撞签名和改题建议。验收状态模型仍然保留，但作为发布准备度辅助，而不是主功能。

## 数据模型

核心类型位于 `lunemark.mbt`：

- `Evidence`：12 个验收证据项。
- `Readiness`：`Blocked`、`Warming`、`Ready`、`Sealed`。
- `Finding`：缺失证据项、权重、标签和修复动作。
- `Report`：总分、已得分、百分比分、状态、缺口和签名。

原创性类型位于 `lunemark_originality.mbt`：

- `IdeaProfile`：项目选题的 12 轴功能指纹。
- `Archetype`：一个内置原型库条目。
- `SimilarityHit`：最近邻匹配结果。
- `OriginalityReport`：原创性分数、最近原型、差异化建议、改题提示和 `ORBT-*` 签名。

原型库位于 `lunemark_catalog.mbt`，当前包含 281 个条目。`closest_archetypes` 会遍历整个原型库、计算距离、排序并截取前 N 个结果。

## 原创性算法

每个选题和原型都有 12 个 1~10 的轴：

- namespace
- runtime
- docs
- ci
- release
- originality
- maintenance
- data
- interactive
- security
- portability
- community

距离是 12 轴绝对差之和。相似度使用严格近重复阈值：

```text
similarity = clamp(100 - distance * 100 / 25, 0, 100)
```

这个阈值故意偏严格：只有非常接近的向量才被视为撞题风险，宽泛领域相邻只作为差异化参考。

Lunemark 0.2.0 自查结果：

- novelty: 81/100
- signature: `ORBT-81-5rz`
- nearest internal archetype: 28%

## 权重设计

总权重固定为 100，方便在 README、Issue 和 CI 中直接读取结果。

| Evidence | Weight |
| --- | ---: |
| `MoonBitPrimary` | 12 |
| `PublicRepository` | 8 |
| `CompleteReadme` | 10 |
| `PurposeAndUsage` | 3 |
| `RunnableExample` | 8 |
| `ContinuousIntegration` | 10 |
| `RunnableTests` | 10 |
| `BuildPasses` | 12 |
| `MooncakesRelease` | 8 |
| `TraceableHistory` | 8 |
| `BoundedScope` | 5 |
| `LicenseClean` | 6 |

## 状态规则

- `Sealed`：没有缺失项。
- `Ready`：仍有缺失项，但分数不低于 85。
- `Warming`：分数不低于 60。
- `Blocked`：分数低于 60。

这个规则故意保守：只要还有缺失项，就不会返回 `Sealed`。

## 签名规则

签名格式为 `LMK-<earned>-<token>`。`token` 来自证据位图、已得分和总分的确定性组合。同一组证据不受输入顺序或重复项影响，会得到相同签名。

## 非目标

- 不做自动仓库扫描。
- 不直接调用 mooncakes.io。
- 不管理登录凭证。
- 不解析 GitHub Actions 日志。
- 不提供法律层面的许可证结论。

## 可维护扩展

后续可以添加以下包或模块：

- `scan/readme`：README 结构检查。
- `scan/git`：提交记录和 tag 检查。
- `scan/github`：Issue、PR 和 CI 状态检查。
- `scan/mooncakes`：发布状态检查。
- `json`：机器可读报告输出。
