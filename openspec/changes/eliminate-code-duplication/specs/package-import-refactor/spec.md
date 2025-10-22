# 宏包导入重构规格

## ADDED Requirements

### 需求1: 集中化宏包管理
#### Scenario: 用户编译主文档时
- Given 用户编译 `main.tex`
- When LaTeX处理到 `\usepackage{mylab_style}`
- Then 所有必需的宏包应该通过 `common/packages.tex` 统一加载
- And 不应该出现宏包重复定义警告
- And 编译时间应该比重构前减少

### 需求2: 消除重复宏包导入
#### Scenario: 检查代码重复时
- Given 分析 `mylab_style.sty` 和 `packages.tex`
- When 比较两个文件的宏包导入部分
- Then `mylab_style.sty` 中不应该包含重复的 `\RequirePackage` 语句
- And 应该通过 `\RequirePackage{common/packages}` 引用
- And 两个文件的重复率应该降至0%

### 需求3: 保持向后兼容性
#### Scenario: 用户使用现有的自定义命令时
- Given 重构后的代码结构
- When 用户在文档中使用如 `\insertfig`、`\notebox` 等命令
- Then 所有命令应该正常工作
- And 不需要修改现有的文档内容
- And 编译不应该报错

## MODIFIED Requirements

### 需求4: mylab_style.sty 职责重新定义
#### Scenario: 检查样式包结构时
- Given 重构后的 `mylab_style.sty`
- When 查看文件内容
- Then 文件应该主要包含：包声明、选项处理、模块引用、布局逻辑
- And 不应该包含具体的宏包导入列表
- And 不应该包含重复的命令定义
- And 文件大小应该显著减少

### 需求5: 编译流程优化
#### Scenario: 比较编译性能时
- Given 重构前后的代码
- When 使用相同的文档进行编译测试
- Then 重构后的编译时间应该少于或等于重构前
- And 内存使用应该保持稳定或减少
- And 生成的PDF内容应该完全一致

## REMOVED Requirements

### 需求6: 移除重复的宏包列表
#### Scenario: 清理重复代码时
- Given 重构过程
- When 删除 `mylab_style.sty` 中的重复宏包导入
- Then 第15-74行的60个 `\RequirePackage` 语句应该被完全移除
- And 相关的注释结构也应该被移除
- And 保留必要的包管理和选项处理代码

### 需求7: 移除重复的命令定义
#### Scenario: 整理自定义命令时
- Given 重构过程
- When 处理 `mylab_style.sty` 中的命令定义部分
- Then 第91-96行的定理环境定义应该被移除
- And 第99-143行的代码样式设置应该被移除
- And 第176-213行的自定义命令应该被移除
- And 这些内容应该已经存在于 `common/commands.tex` 中

## 交叉引用

**相关能力**:
- [custom-commands-refactor](../custom-commands-refactor/spec.md): 处理自定义命令的重构
- [layout-settings-cleanup](../layout-settings-cleanup/spec.md): 处理布局设置的清理

**依赖关系**:
- 此规格是重构的第一步，为后续的命令重构提供基础
- 需要确保包的正确加载顺序，避免循环依赖