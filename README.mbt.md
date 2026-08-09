# Lunemark

Lunemark 是一个用 MoonBit 实现的项目验收轨道印章工具。它把 MoonBit 黑客松验收中常见的证据项，转换成稳定的分数、缺口清单和短签名，方便在 README、Issue、Release note 或 CI 日志里追踪项目是否已经达到可验收状态。

当前包名是 `username/lunemark`。发布到 mooncakes.io 前，请把 `moon.mod` 和示例包里的 `username` 替换成你的 mooncakes.io 用户名。

## 项目用途

Lunemark 解决一个很具体的问题：项目快到验收时，README、CI、测试、示例、许可证、发布记录等材料很容易散落在不同地方。Lunemark 不扫描你的文件系统，而是让维护者显式提交已经具备的证据项，然后输出一份可复制、可测试、可复现的验收状态。

## 主要功能

- MoonBit 库 API：`audit`、`format_report`、`badge`、`complete_evidence`、`draft_evidence`
- CLI 示例：`moon run cmd/main`
- 可运行示例包：`moon run examples/partial`
- 100 分权重模型：12 个验收证据项总分刚好为 100
- 稳定签名：相同证据集合会生成相同 `LMK-...` 短码
- 测试覆盖：完整项目、草稿项目、重复证据、badge 输出
- CI 配置：格式检查、静态检查、构建、测试、示例运行

## 功能边界

Lunemark 专注于“验收证据状态建模”，不做以下事情：

- 不自动扫描本地仓库
- 不保存 mooncakes.io token
- 不替你发布包
- 不判断业务代码质量
- 不替代许可证审计

后续维护可以在这个边界上扩展，例如增加 README 结构扫描器、GitHub API 检查器或 mooncakes.io 发布状态检查器。

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

主示例输出：

```text
Lunemark report for lunemark-draft
score: 48/100 (48%)
level: Blocked
signature: LMK-48-dr5
missing:
- [8] public repository is reachable -> push the repository to a public Git host and verify anonymous access
- [10] CI workflow is configured -> add a GitHub Actions workflow that runs check, build, test, and example
- [12] project builds successfully -> make `moon build` pass on a clean checkout
- [8] package is published to mooncakes.io -> run `moon login`, update the module namespace, then `moon publish`
- [8] development history is traceable -> keep small Git commits, issues, changelog entries, and release tags
- [6] third-party code and assets are license-clean -> record dependency and asset licenses before release

Lunemark Sealed 100% LMK-100-lvz
```

库示例输出：

```text
Lunemark Blocked 48% LMK-48-8nv
```

## 使用方法

在另一个 MoonBit 可执行包中导入根库：

```text
import {
  "username/lunemark" @lunemark,
}

pkgtype(kind: "executable")
```

然后传入证据项：

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

## 测试

```sh
moon test
```

当前测试数量：5。测试记录见 `docs/TESTING.md`。

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
7. 创建 Git tag，例如 `v0.1.0`
8. 在 `CHANGELOG.md` 写入发布记录

详细清单见 `docs/RELEASE.md`。

## 开发追踪建议

本仓库已经放入以下材料，便于验收时展示开发过程：

- `CHANGELOG.md`：更新日志
- `docs/DESIGN.md`：技术方案和设计说明
- `docs/TESTING.md`：测试记录
- `docs/RELEASE.md`：版本发布记录和 mooncakes.io 发布步骤
- `.github/ISSUE_TEMPLATE/`：Issue 模板
- `.github/workflows/ci.yml`：CI 记录入口

## 许可证

项目代码使用 Apache-2.0。当前没有第三方运行时依赖，也没有外部素材。工具链、CI Action 和 GitHub 平台不随本包再分发。
