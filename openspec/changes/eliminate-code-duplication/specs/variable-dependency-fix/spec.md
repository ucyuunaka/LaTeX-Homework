# 变量依赖重构规格

## ADDED Requirements

### 需求1: 布局感知的notebox命令
#### Scenario: 用户在不同布局中使用notebox命令时
- Given 用户在单栏或双栏布局中使用 `\notebox{文本}` 命令
- When LaTeX编译处理该命令
- Then 命令应该自动适应当前布局的宽度设置
- And 单栏布局使用 `0.9\textwidth`，双栏布局使用 `0.9\columnwidth`
- And 不应该出现未定义变量的编译错误

### 需求2: 统一的模块引用接口
#### Scenario: 布局文件引用通用模块时
- Given 布局文件需要引用通用模块
- When 检查引用方式
- Then 所有布局文件应该统一使用 `\RequirePackage{common/module-name}`
- And 不应该混用 `\input` 和 `\RequirePackage`
- And 引用顺序应该严格控制确保依赖关系正确

### 需求3: 变量定义的本地化管理
#### Scenario: 布局特定变量定义时
- Given 需要定义布局特定的长度变量
- When 在布局文件中定义变量
- Then 变量定义应该在布局文件中本地化处理
- And 通用命令不应该直接依赖布局特定变量
- And 应该通过命令参数或条件判断来处理布局差异

## MODIFIED Requirements

### 需求4: commands.tex 变量依赖清理
#### Scenario: 检查通用命令文件时
- Given 重构后的 `common/commands.tex`
- When 查看命令定义
- Then 不应该包含对布局特定变量的直接引用
- And `\notebox` 命令应该重新设计为布局感知
- And 所有命令应该在任何布局中正常工作

### 需求5: 布局文件接口标准化
#### Scenario: 检查布局文件结构时
- Given 重构后的布局文件
- When 查看模块引用部分
- Then 应该使用统一的 `\RequirePackage` 接口
- And 引用顺序应该保持一致
- And 不应该出现接口不一致的问题

## REMOVED Requirements

### 需求6: 移除noteboxwidth变量依赖
#### Scenario: 清理变量依赖时
- Given 重构过程
- When 处理 `commands.tex:98` 的变量引用
- Then `\parbox{\noteboxwidth}{%}` 的直接引用应该被移除
- And 应该替换为布局感知的宽度计算机制
- And 不应该再依赖布局文件中定义的变量

### 需求7: 移除input引用方式
#### Scenario: 统一引用接口时
- Given 重构过程
- When 处理布局文件中的模块引用
- Then `\input{preamble/common/packages}` 应该替换为 `\RequirePackage{common/packages}`
- And `\input{preamble/common/commands}` 应该替换为 `\RequirePackage{common/commands}`
- And 所有引用应该遵循LaTeX包管理最佳实践

## 交叉引用

**相关能力**:
- [package-import-refactor](../package-import-refactor/spec.md): 确保包加载顺序正确
- [custom-commands-refactor](../custom-commands-refactor/spec.md): 重新设计命令实现
- [layout-interface-standardization](../layout-interface-standardization/spec.md): 统一布局接口

**依赖关系**:
- 依赖于宏包导入重构的正确执行
- 需要与命令重构协调进行
- 为布局特定功能提供基础

**设计原则**:
- 命令应该布局感知，但不直接依赖布局变量
- 接口一致性比实现细节更重要
- 遵循LaTeX包管理最佳实践
- 确保向后兼容性