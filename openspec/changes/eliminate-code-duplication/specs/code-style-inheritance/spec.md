# 代码样式继承重构规格

## ADDED Requirements

### 需求1: 代码样式基础模块创建
#### Scenario: 建立代码样式基础设置时
- Given 需要创建代码样式的基础设置
- When 创建 `common/code-base-settings.tex` 文件
- Then 文件应该包含：颜色定义、基础框架设置、默认参数
- And 应该为布局特定优化提供继承基础
- And 不应该包含布局特定的调整

### 需求2: 布局特定的代码样式继承
#### Scenario: 双栏布局优化代码样式时
- Given 双栏布局需要适配的代码样式
- When 布局文件加载基础代码样式
- Then 应该继承基础设置并只覆盖必要的参数
- And 如字体大小（`\footnotesize`）、行号关闭、边距调整等
- And 不应该完全重复定义所有代码样式设置

### 需求3: 代码样式继承层次设计
#### Scenario: 检查代码样式加载顺序时
- Given 多层代码样式设置
- When 确定加载顺序
- Then 应该按照：基础设置 → 通用设置 → 布局特定覆盖 的顺序
- And 后加载的设置应该能够覆盖前面的设置
- And 继承关系应该清晰明确

## MODIFIED Requirements

### 需求4: layout_double/settings.tex 代码样式重构
#### Scenario: 重构双栏布局的代码样式时
- Given 重构后的 `layout_double/settings.tex`
- When 查看代码样式部分（第53-88行）
- Then 不应该完全重复定义代码样式
- And 应该通过继承基础设置进行差异化配置
- And 只保留双栏布局特定的优化参数

### 需求5: 代码样式设置职责分离
#### Scenario: 检查代码样式分布时
- Given 重构后的代码样式结构
- When 分析各个文件的代码样式设置
- Then `common/code-base-settings.tex` 包含基础样式
- And `common/commands.tex` 包含通用命令（移除代码样式）
- And 布局文件只包含布局特定的覆盖设置

## REMOVED Requirements

### 需求6: 移除布局文件中的代码样式重复定义
#### Scenario: 清理代码样式重复时
- Given 重构过程
- When 处理 `layout_double/settings.tex:53-88` 的代码样式设置
- Then 完整的代码样式定义应该被移除
- And 应该替换为基础设置继承 + 布局特定覆盖
- And 不应该与 `common/commands.tex` 中的设置重复

### 需求7: 移除commands.tex中的代码样式设置
#### Scenario: 分离代码样式和命令定义时
- Given 重构过程
- When 处理 `common/commands.tex` 中的代码样式部分
- Then 第23-76行的代码样式设置应该移至 `code-base-settings.tex`
- And 命令定义文件应该专注于命令和环境定义
- And 代码样式应该独立管理以支持继承

## 交叉引用

**相关能力**:
- [package-import-refactor](../package-import-refactor/spec.md): 确保代码样式相关的包正确加载
- [custom-commands-refactor](../custom-commands-refactor/spec.md): 分离命令定义和样式设置
- [variable-dependency-fix](../variable-dependency-fix/spec.md): 确保样式设置的变量依赖正确

**依赖关系**:
- 依赖于宏包导入重构，确保代码样式相关的包可用
- 与命令重构协调进行，分离职责
- 需要解决变量依赖问题，确保样式设置正常工作

**设计原则**:
- 基础样式与布局特定优化分离
- 继承优于重复
- 保持样式的一致性和可维护性
- 支持布局特定的合理差异化