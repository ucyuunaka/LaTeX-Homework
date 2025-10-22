# 自定义命令重构规格

## ADDED Requirements

### 需求1: 通用命令集中管理
#### Scenario: 用户使用定理环境时
- Given 用户在文档中使用 `\begin{theorem}` 环境
- When LaTeX编译处理该环境
- Then 定理环境应该由 `common/commands.tex` 统一定义
- And 不应该在多个文件中重复定义
- And 环境样式应该保持一致

### 需求2: 命令职责分离
#### Scenario: 检查命令分布时
- Given 重构后的命令结构
- When 分析各个文件的命令定义
- Then 通用命令（如 `\highlight`、`\notebox`）应该在 `common/commands.tex` 中
- And 布局特定命令（如 `\insertfigwide`）应该在对应布局文件中
- And `mylab_style.sty` 不应该包含具体的命令实现

### 需求3: 代码样式统一配置
#### Scenario: 用户插入代码块时
- Given 用户使用 `\inputcode` 命令
- When 编译处理代码高亮
- Then minted和listings的配置应该由 `common/commands.tex` 统一管理
- And 颜色定义和样式设置应该集中配置
- And 不应该在每个文件中重复设置

## MODIFIED Requirements

### 需求4: commands.tex 功能增强
#### Scenario: 查看通用命令文件时
- Given 重构后的 `common/commands.tex`
- When 检查文件内容
- Then 应该包含：定理环境、代码样式、通用命令、数学环境
- And 应该按功能模块组织，使用清晰的注释分隔
- And 应该提供命令的使用说明注释

### 需求5: mylab_style.sty 逻辑简化
#### Scenario: 检查主样式文件时
- Given 重构后的 `mylab_style.sty`
- When 查看命令相关部分
- Then 文件应该主要处理包管理和模块引用逻辑
- And 不应该包含具体的命令实现代码
- And 应该通过 `\RequirePackage{common/commands}` 引用命令库

## REMOVED Requirements

### 需求6: 移除定理环境重复定义
#### Scenario: 清理重复定义时
- Given 重构过程
- When 处理定理环境定义
- Then `mylab_style.sty:91-96` 的定理环境定义应该被移除
- And `common/commands.tex:7-12` 应该保持为唯一的数据源
- And 所有定理环境（定义、定理、引理等）应该集中定义

### 需求7: 移除代码样式重复设置
#### Scenario: 整理代码样式时
- Given 重构过程
- When 处理代码高亮配置
- Then `mylab_style.sty:99-143` 的代码样式设置应该被移除
- And 颜色定义、minted设置、listings配置应该集中在 `common/commands.tex`
- And JavaScript语言定义等扩展配置也应该统一管理

### 需求8: 移除自定义命令重复实现
#### Scenario: 清理自定义命令时
- Given 重构过程
- When 处理通用自定义命令
- Then `mylab_style.sty:176-213` 的自定义命令应该被移除
- And `\highlight`、`\notebox`、`\insertfig`、`\inputcode`、`\dlmu` 等命令应该在 `common/commands.tex` 中定义
- And 命令参数和实现应该保持完全一致

## 交叉引用

**相关能力**:
- [package-import-refactor](../package-import-refactor/spec.md): 处理宏包导入的重构，是此规格的前置条件
- [layout-settings-cleanup](../layout-settings-cleanup/spec.md): 处理布局设置中可能存在的命令重复

**依赖关系**:
- 依赖于宏包导入重构的完成，确保命令定义的包已正确加载
- 需要与布局重构协调，避免命令定义冲突

**注意事项**:
- 移除重复命令时要确保参数和实现完全一致
- 保持对外接口的向后兼容性
- 注意命令的加载顺序，避免未定义错误