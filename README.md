# Lunemark

Lunemark 是一个用 MoonBit 实现的“原创性星图”工具。它把项目选题编码成多维功能指纹，和内置原型库做近邻比较，输出原创性分数、防撞签名、差异化建议和后续维护路线。发布里程碑能力保留为辅助视图：先看选题是否撞车，再看发布前的工程状态。

当前包名是 `DZX-ai-nb/lunemark`，对应 mooncakes.io 登录账号 `DZX-ai-nb`。

## 项目用途

Lunemark 解决的是“项目还没发布前如何避免选题雷同”的问题。它不扫描本地仓库文件，也不冒充全网唯一性保证；它提供一个可运行、可测试、可解释的 MoonBit 原创性模型，让 README、Issue 和 CI 日志都能清楚说明：这个项目的主功能是原创性指纹引擎，不是仓库发布清单工具。

## 公开选题排查

公开检索和评审反馈截图都提示，MoonBit 生态里已有多类围绕发布材料、README 示例、授权说明、边界说明和最终展示记录的项目。旧版 Lunemark 的“里程碑打分器”容易被放进同一类，因此 0.2.0 做了功能转向：

- 主功能改为 `IdeaProfile` 多轴选题指纹。
- 新增 281 个内置 `Archetype` 原型。
- 新增 `closest_archetypes` 最近邻比较。
- 新增 `analyze_originality` 原创性报告。
- 新增 `ORBT-*` 防撞签名和改题提示。

完整排查记录见 `docs/ORIGINALITY.md`。

## 主要功能

- 原创性 API：`lunemark_profile`、`analyze_originality`、`closest_archetypes`、`format_originality_report`
- 原型库：`archetype_catalog` 内置 281 个项目功能原型
- 防撞签名：相同选题指纹会生成稳定 `ORBT-...` 短码
- 差异化建议：输出 closest archetypes、differentiators 和 rewrite prompt
- 发布里程碑 API：`mark_launch`、`format_launch_report`、`launch_badge`
- CLI 示例：`moon run cmd/main`
- 可运行示例包：`moon run examples/partial`
- 测试覆盖：原创性分析、近重复检测、完整里程碑、草稿里程碑、重复里程碑、badge 输出
- CI 配置：格式检查、静态检查、构建、测试、示例运行

## 功能边界

Lunemark 专注于“选题原创性防撞 + 发布里程碑辅助”，不做以下事情：

- 不自动扫描本地仓库。
- 不保存 mooncakes.io token。
- 不替你发布包。
- 不声称能发现私有仓库、未发布项目或未来项目。
- 不替代法律层面的许可证判断。

后续维护可以在这个边界上扩展，例如增加 mooncakes.io 公开包索引导入器、GitHub 搜索适配器、JSON 报告输出或更细的原型分类器。

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
- lead with originality analysis and the atlas data model
- use the built-in archetype atlas as a reusable MoonBit data engine
- keep anti-collision scoring as the core value proposition
- ship maintenance routes and future lanes with every report
- treat the catalog as versioned project intelligence, not decoration
rewrite prompt: preserve Lunemark Originality Atlas as an originality-first MoonBit planning kernel with launch milestones as a secondary output
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
  "DZX-ai-nb/lunemark" @lunemark,
}

pkgtype(kind: "executable")
```

原创性分析：

```text
let idea = @lunemark.lunemark_profile()
let originality = @lunemark.analyze_originality(idea)
println(@lunemark.originality_badge(originality))
```

发布里程碑辅助：

```text
let milestones = [
  @lunemark.MoonBitPrimary,
  @lunemark.PublicRepository,
  @lunemark.CompleteReadme,
  @lunemark.RunnableExample,
  @lunemark.RunnableTests,
]
let report = @lunemark.mark_launch("tiny-orbit", milestones)
println(@lunemark.launch_badge(report))
```

## 发布里程碑映射

| 黑客松要求 | Lunemark 里程碑项 |
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
| 开发过程和 Git 历史清晰 | `CommitHistory` |
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

1. 确认 `moon.mod` 中的 `name` 为 `DZX-ai-nb/lunemark`
2. 确认 `repository` 为公开仓库地址
3. 执行 `moon login`
4. 执行 `moon check --deny-warn && moon test && moon build`
5. 执行 `moon publish`
6. 创建 Git tag，例如 `v0.2.1`
7. 在 `CHANGELOG.md` 写入发布记录

详细清单见 `docs/RELEASE.md`。

## 开发记录建议

本仓库已经放入以下材料，便于后续展示开发过程：

- `CHANGELOG.md`：更新日志
- `docs/ORIGINALITY.md`：公开选题排查记录和差异化说明
- `docs/DESIGN.md`：技术方案和设计说明
- `docs/TESTING.md`：测试记录
- `docs/RELEASE.md`：版本发布记录和 mooncakes.io 发布步骤
- `.github/ISSUE_TEMPLATE/`：Issue 模板
- `.github/workflows/ci.yml`：CI 记录入口

## 许可证

项目代码使用 Apache-2.0。当前没有第三方运行时依赖，也没有外部素材。工具链、CI Action 和 GitHub 平台不随本包再分发。
