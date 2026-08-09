# Lunemark Design

## 目标

Lunemark 的目标是提供一个小而清楚的 MoonBit 验收状态模型。它不猜测项目是否合格，而是把维护者确认过的证据项转换成可追踪报告。

## 数据模型

核心类型位于 `lunemark.mbt`：

- `Evidence`：12 个验收证据项。
- `Readiness`：`Blocked`、`Warming`、`Ready`、`Sealed`。
- `Finding`：缺失证据项、权重、标签和修复动作。
- `Report`：总分、已得分、百分比分、状态、缺口和签名。

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
