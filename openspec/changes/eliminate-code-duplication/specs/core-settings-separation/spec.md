# 核心设置分离规格

## ADDED Requirements

### 需求1: 核心格式设置文件创建
#### Scenario: 建立新的设置文件时
- Given 需要分离格式设置
- When 创建 `common/core-settings.tex` 文件
- Then 文件应该包含：基础格式配置、颜色定义、超链接设置、页面样式基础配置
- And 应该使用清晰的模块化结构
- And 应该提供详细的配置说明注释

### 需求2: 格式设置职责分离
#### Scenario: 检查设置分布时
- Given 重构后的设置结构
- When 分析各个设置文件
- Then `core-settings.tex` 应该包含通用格式设置
- And 布局特定设置应该在对应的布局文件中
- And 不应该存在跨文件的设置重复

### 需求3: 颜色和样式统一管理
#### Scenario: 配置文档样式时
- Given 用户需要自定义颜色
- When 修改颜色设置
- Then 所有颜色定义应该在 `core-settings.tex` 中统一管理
- And 代码高亮颜色、超链接颜色、强调色等应该集中配置
- And 不应该分散在多个文件中

## MODIFIED Requirements

### 需求4: mylab_style.sty 简化
#### Scenario: 检查主样式文件内容时
- Given 重构后的 `mylab_style.sty`
- When 查看格式设置部分
- Then 文件不应该包含具体的格式设置代码
- And 应该通过 `\RequirePackage{common/core-settings}` 引用设置
- And 主要职责应该是包管理和模块协调

### 需求5: 设置层次结构优化
#### Scenario: 理解设置继承关系时
- Given 重构后的设置体系
- When 分析设置的加载顺序
- Then 应该按照：基础设置 → 通用设置 → 布局特定设置 的顺序加载
- And 后加载的设置应该能够覆盖前面的设置
- And 继承关系应该清晰明确

## REMOVED Requirements

### 需求6: 移除格式设置重复
#### Scenario: 清理重复格式配置时
- Given 重构过程
- When 处理 `mylab_style.sty` 中的格式设置
- Then 第81-87行的页面格式设置应该移至 `core-settings.tex`
- And 第99行的超链接设置应该移至 `core-settings.tex`
- And 第101-104行的颜色定义应该移至 `core-settings.tex`

### 需求7: 移除样式设置重复
#### Scenario: 整理样式配置时
- Given 重构过程
- When 处理样式相关设置
- Then 第165-170行的标题设置应该移至 `core-settings.tex`
- And 第172-173行的列表设置应该移至 `core-settings.tex`
- And 样式配置应该从命令定义中分离出来

## 交叉引用

**相关能力**:
- [package-import-refactor](../package-import-refactor/spec.md): 确保格式设置所需的包已正确加载
- [custom-commands-refactor](../custom-commands-refactor/spec.md): 分离命令定义和格式设置

**依赖关系**:
- 依赖于宏包导入重构，确保格式设置相关的包可用
- 与命令重构并行进行，但注意避免循环依赖
- 为布局重构提供统一的格式基础

**设计原则**:
- 格式设置与功能命令分离
- 通用设置与布局特定设置分离
- 保持设置的可配置性和可扩展性
- 确保设置的加载顺序正确