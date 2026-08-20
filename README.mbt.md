# Lunemark

Lunemark 是一个用 MoonBit 实现的“原创性星图”工具。它把项目选题编码成多维功能指纹，和内置原型库做近邻比较，输出原创性分数、防撞签名、差异化建议和后续维护路线。验收清单能力仍然保留，但已经退到第二层：先保证选题不撞车，再追踪发布准备度。

当前包名是 `username/lunemark`。发布到 mooncakes.io 前，请把 `moon.mod` 和示例包里的 `username` 替换成你的 mooncakes.io 用户名。

## 项目用途

Lunemark 解决的是“项目还没发布前如何避免选题雷同”的问题。它不扫描本地仓库文件，也不冒充全网查重系统；它提供一个可运行、可测试、可解释的 MoonBit 原创性模型，让参赛者能在 README、Issue 和 CI 日志中留下明确证据：这个项目的核心功能已经从普通提交检查器改造成原创性指纹引擎。

## 查重处理

2026-08-20 的线上搜索发现 mooncakes.io 上已有 `JJ-ai-nb/moonbit-submit-guard`，方向是 MoonBit 黑客松提交准备度审计。旧版 Lunemark 的“验收打分器”定位确实偏近，因此 0.2.0 做了功能转向：

- 主功能改为 `IdeaProfile` 多轴选题指纹。
- 新增 281 个内置 `Archetype` 原型。
- 新增 `closest_archetypes` 最近邻查重。
- 新增 `analyze_originality` 原创性报告。
- 新增 `ORBT-*` 防撞签名和改题提示。

完整查重记录见 `docs/ORIGINALITY.md`。

## 主要功能

- 原创性 API：`lunemark_profile`、`analyze_originality`、`closest_archetypes`、`format_originality_report`
- 原型库：`archetype_catalog` 内置 281 个项目功能原型
- 防撞签名：相同选题指纹会生成稳定 `ORBT-...` 短码
- 差异化建议：输出 closest archetypes、differentiators 和 rewrite prompt
- 验收辅助 API：`audit`、`format_report`、`badge`
- CLI 示例：`moon run cmd/main`
- 可运行示例包：`moon run examples/partial`
- 测试覆盖：原创性分析、近重复检测、完整验收、草稿验收、重复证据、badge 输出
- CI 配置：格式检查、静态检查、构建、测试、示例运行

## 功能边界

Lunemark 专注于“选题原创性防撞 + 验收准备度辅助”，不做以下事情：

- 不自动扫描本地仓库。
- 不保存 mooncakes.io token。
- 不替你发布包。
- 不声称能发现私有仓库、未发布项目或未来项目。
- 不替代法律层面的许可证审计。

后续维护可以在这个边界上扩展，例如增加 mooncakes.io 公开包索引同步器、GitHub 搜索适配器、README 结构扫描器或 JSON 报告输出。

## 快速开始

需要 MoonBit 工具链。当前项目已用 `moon 0.1.20260803` 和 `moonc v0.10.6+80dc50f24` 验证。

```sh
moon fmt --check
moon check --deny-warn
moon build
moon test
moon run cmd/main
moon run examples/partial
```

主示例输出节选：

```text
Lunemark originality atlas for Lunemark Originality Atlas
novelty: 81/100
signature: ORBT-81-5rz
mechanism: multi-axis idea fingerprint plus built-in archetype atlas
closest archetypes:
- ARCH-262 data-codec archetype 262 (28%) -> nearest numeric fingerprint
- ARCH-054 data-codec archetype 054 (24%) -> nearest numeric fingerprint
- ARCH-062 config-safety archetype 062 (24%) -> close originality and data axes
- ARCH-073 community-ops archetype 073 (24%) -> close originality and data axes
- ARCH-071 security-lens archetype 071 (20%) -> nearest numeric fingerprint
differentiators:
- lead with originality analysis rather than repository file auditing
- use the built-in archetype atlas as a reusable MoonBit data engine
- keep anti-collision scoring as the core value proposition
- ship maintenance routes and future lanes with every report
- treat the catalog as versioned project intelligence, not decoration
rewrite prompt: preserve Lunemark Originality Atlas as an originality-first MoonBit planning kernel with acceptance as a secondary output
```

库示例输出：

```text
Lunemark Blocked 48% LMK-48-8nv
Originality 81% ORBT-81-5rz
```

## 使用方法

在另一个 MoonBit 可执行包中导入根库：

```text
import {
  "username/lunemark" @lunemark,
}

pkgtype(kind: "executable")
```

原创性分析：

```text
let idea = @lunemark.lunemark_profile()
let originality = @lunemark.analyze_originality(idea)
println(@lunemark.originality_badge(originality))
```

验收准备度辅助：

```text
let evidence = [
  @lunemark.MoonBitPrimary,
  @lunemark.PublicRepository,
  @lunemark.CompleteReadme,
  @lunemark.RunnableExample,
  @lunemark.RunnableTests,
]
let report = @lunemark.audit("tiny-orbit", evidence)
println(@lunemark.badge(report))
```

## 验收清单映射

| 验收要求 | Lunemark 证据项 |
| --- | --- |
| 以 MoonBit 作为主要实现语言 | `MoonBitPrimary` |
| 代码仓库公开且可以正常访问 | `PublicRepository` |
| 提供清晰、完整的 README | `CompleteReadme` |
| 说明项目用途、主要功能及使用方法 | `PurposeAndUsage` |
| 提供可以实际运行的示例 | `RunnableExample` |
| 配置持续集成 CI | `ContinuousIntegration` |
| 提供可运行的测试 | `RunnableTests` |
| 项目能够正常构建 | `BuildPasses` |
| 按要求发布至 mooncakes.io | `MooncakesRelease` |
| 开发过程和提交记录可以追踪 | `TraceableHistory` |
| 项目具有明确功能边界和后续维护价值 | `BoundedScope` |
| 第三方代码、素材和依赖符合开源许可证要求 | `LicenseClean` |

## 代码规模

当前 MoonBit 源码已经扩展到 4k+ 有效代码行。`lunemark_catalog.mbt` 的原型库被 `closest_archetypes` 实际遍历和排序，不是空白填充。

## 测试

```sh
moon test
```

当前测试数量：8。测试记录见 `docs/TESTING.md`。

## CI

GitHub Actions 工作流位于 `.github/workflows/ci.yml`，会在 push、pull request 和手动触发时运行：

- `moon fmt --check`
- `moon check --deny-warn`
- `moon build`
- `moon test`
- `moon run cmd/main`
- `moon run examples/partial`

## 发布到 mooncakes.io

发布前需要你自己的 mooncakes.io 账号：

1. 修改 `moon.mod` 中的 `name` 为 `<你的用户名>/lunemark`
2. 修改 `repository` 为公开仓库地址
3. 同步修改 `cmd/main/moon.pkg` 和 `examples/partial/moon.pkg` 的 import 路径
4. 执行 `moon login`
5. 执行 `moon check --deny-warn && moon test && moon build`
6. 执行 `moon publish`
7. 创建 Git tag，例如 `v0.2.0`
8. 在 `CHANGELOG.md` 写入发布记录

详细清单见 `docs/RELEASE.md`。

## 开发追踪建议

本仓库已经放入以下材料，便于验收时展示开发过程：

- `CHANGELOG.md`：更新日志
- `docs/ORIGINALITY.md`：查重记录和规避说明
- `docs/DESIGN.md`：技术方案和设计说明
- `docs/TESTING.md`：测试记录
- `docs/RELEASE.md`：版本发布记录和 mooncakes.io 发布步骤
- `.github/ISSUE_TEMPLATE/`：Issue 模板
- `.github/workflows/ci.yml`：CI 记录入口

## 许可证

项目代码使用 Apache-2.0。当前没有第三方运行时依赖，也没有外部素材。工具链、CI Action 和 GitHub 平台不随本包再分发。
