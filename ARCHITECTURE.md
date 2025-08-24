# 🏗️ RuboCop HK Architecture

> **Comprehensive architecture documentation for RuboCop HK configuration gem**

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🏛️ System Architecture](#️-system-architecture)
- [📦 Module Structure](#-module-structure)
- [⚙️ Configuration System](#️-configuration-system)
- [🔄 Plugin Integration](#-plugin-integration)
- [🧪 Testing Architecture](#-testing-architecture)
- [🚀 Deployment Flow](#-deployment-flow)
- [🔧 Extension Points](#-extension-points)
- [📊 Performance Considerations](#-performance-considerations)

## 🎯 Overview

RuboCop HK is a comprehensive configuration gem that provides curated RuboCop rules for modern Ruby and Rails applications. It follows a modular architecture that allows for flexible configuration inheritance and extensibility.

### Design Principles

- **🔧 Modular Configuration** - Separate configs for different concerns
- **📈 Gradual Adoption** - Easy migration path for existing projects
- **🎯 Rails-First** - Optimized for Rails development patterns
- **🔌 Extensible** - Plugin architecture for custom cops
- **⚡ Performance** - Minimal overhead and fast execution

## 🏛️ System Architecture

### High-Level Architecture

```mermaid
graph TB
    subgraph "User Project"
        UP[.rubocop.yml] --> IG[inherit_gem]
    end
    
    subgraph "RuboCop HK Gem"
        IG --> DC[config/default.yml]
        
        subgraph "Configuration Modules"
            DC --> RS[rubocop-style.yml]
            DC --> RR[rubocop-rails.yml]
            DC --> RSP[rubocop-rspec.yml]
            DC --> RL[rubocop-layout.yml]
            DC --> RM[rubocop-metrics.yml]
            DC --> RLI[rubocop-lint.yml]
        end
        
        subgraph "Ruby Modules"
            LIB[lib/rubocop/hk.rb] --> VER[version.rb]
            LIB --> CMD[command.rb]
        end
    end
    
    subgraph "RuboCop Core"
        RS --> RC[RuboCop Engine]
        RR --> RC
        RSP --> RC
        RL --> RC
        RM --> RC
        RLI --> RC
    end
    
    subgraph "Analysis Output"
        RC --> OUT[Analysis Results]
        RC --> FIX[Auto Corrections]
        RC --> REP[Reports]
    end
```

### Component Interaction Flow

```mermaid
sequenceDiagram
    participant User as User Project
    participant Gem as RuboCop HK
    participant Core as RuboCop Core
    participant FS as File System
    
    User->>Gem: inherit_gem: rubocop-hk
    Gem->>FS: Load config/default.yml
    FS->>Gem: Return configuration
    Gem->>Core: Merge configurations
    
    loop For each Ruby file
        Core->>FS: Read source code
        Core->>Core: Apply cops from config
        Core->>User: Report violations
        
        opt Auto-correct enabled
            Core->>FS: Write corrected code
        end
    end
```

## 📦 Module Structure

### Directory Layout

```
lib/
├── rubocop/
│   └── hk/
│       ├── version.rb          # Gem version
│       ├── command.rb          # CLI commands
│       └── cops/              # Custom cops (future)
│           └── custom/
│               └── business_logic.rb
├── rubocop/
│   └── hk.rb                  # Main module
config/
├── default.yml               # Main configuration
├── rubocop-style.yml         # Style rules
├── rubocop-rails.yml         # Rails-specific rules
├── rubocop-rspec.yml         # RSpec rules
├── rubocop-layout.yml        # Code layout rules
├── rubocop-metrics.yml       # Complexity metrics
└── rubocop-lint.yml          # Lint rules
```

### Module Dependencies

```mermaid
graph TD
    A[rubocop-hk.gemspec] --> B[lib/rubocop/hk.rb]
    B --> C[lib/rubocop/hk/version.rb]
    B --> D[lib/rubocop/hk/command.rb]
    
    E[config/default.yml] --> F[config/rubocop-style.yml]
    E --> G[config/rubocop-rails.yml]
    E --> H[config/rubocop-rspec.yml]
    E --> I[config/rubocop-layout.yml]
    E --> J[config/rubocop-metrics.yml]
    E --> K[config/rubocop-lint.yml]
    
    L[User Project] --> E
    
    subgraph "External Dependencies"
        M[rubocop ~> 1.79]
        N[rubocop-rails ~> 2.32]
        O[rubocop-rspec ~> 3.6]
    end
    
    B --> M
    G --> N
    H --> O
```

## ⚙️ Configuration System

### Configuration Inheritance

```mermaid
flowchart TD
    A[User .rubocop.yml] --> B{inherit_gem?}
    B -->|Yes| C[Load gem config]
    B -->|No| D[Use default RuboCop]
    
    C --> E[config/default.yml]
    E --> F[Load inherited configs]
    
    subgraph "Inherited Configurations"
        F --> G[rubocop-style.yml]
        F --> H[rubocop-rails.yml]
        F --> I[rubocop-rspec.yml]
        F --> J[rubocop-layout.yml]
        F --> K[rubocop-metrics.yml]
        F --> L[rubocop-lint.yml]
    end
    
    G --> M[Merge all configurations]
    H --> M
    I --> M
    J --> M
    K --> M
    L --> M
    
    A --> N[User overrides]
    M --> O[Apply user overrides]
    N --> O
    
    O --> P[Final Configuration]
```

### Configuration Priority

1. **User .rubocop.yml** (Highest Priority)
2. **Gem default.yml** 
3. **Individual module configs**
4. **RuboCop defaults** (Lowest Priority)

### Dynamic Configuration

```mermaid
graph LR
    A[Rails Version Detection] --> B{Rails >= 7.0?}
    B -->|Yes| C[Enable Modern Rails Cops]
    B -->|No| D[Use Legacy Rails Cops]
    
    E[Ruby Version Detection] --> F{Ruby >= 3.2?}
    F -->|Yes| G[Enable Pattern Matching Cops]
    F -->|No| H[Skip Modern Ruby Cops]
    
    I[Project Type Detection] --> J{Has spec/ dir?}
    J -->|Yes| K[Enable RSpec Cops]
    J -->|No| L[Skip RSpec Cops]
```

## 🔄 Plugin Integration

### RuboCop Plugin System

```mermaid
graph TB
    subgraph "RuboCop Core"
        A[RuboCop Engine] --> B[Plugin Manager]
    end
    
    subgraph "RuboCop HK"
        C[default.yml] --> D[plugins: declaration]
        D --> E[rubocop-rails]
        D --> F[rubocop-rspec]
        D --> G[rubocop-performance]
    end
    
    B --> H[Load Plugin Cops]
    E --> H
    F --> H
    G --> H
    
    H --> I[Merged Cop Registry]
    I --> J[Analysis Engine]
    
    subgraph "Analysis Results"
        J --> K[Style Violations]
        J --> L[Rails Violations]
        J --> M[RSpec Violations]
        J --> N[Performance Issues]
    end
```

### Custom Cops Architecture

```mermaid
classDiagram
    class Base {
        +on_send(node)
        +add_offense(node, message)
        +autocorrect(corrector)
    }
    
    class CustomBusinessLogic {
        +on_class(node)
        +business_logic_service?(node)
        +MSG = "Use service objects"
    }
    
    class CustomSecurityCheck {
        +on_send(node)
        +dangerous_method?(method)
        +MSG = "Avoid dangerous methods"
    }
    
    Base <|-- CustomBusinessLogic
    Base <|-- CustomSecurityCheck
    
    class CopRegistry {
        +register_cop(cop_class)
        +cops_for_file(file)
    }
    
    CopRegistry --> CustomBusinessLogic
    CopRegistry --> CustomSecurityCheck
```

## 🧪 Testing Architecture

### Test Suite Structure

```mermaid
graph TD
    A[Test Suite] --> B[Unit Tests]
    A --> C[Integration Tests]
    A --> D[Configuration Tests]
    A --> E[CLI Tests]
    
    B --> F[Module Loading]
    B --> G[Version Management]
    B --> H[Command Functionality]
    
    C --> I[Rails Integration]
    C --> J[RSpec Integration]
    C --> K[Multi-version Testing]
    
    D --> L[Config Inheritance]
    D --> M[Cop Enablement]
    D --> N[Rule Validation]
    
    E --> O[CLI Commands]
    E --> P[Help Output]
    E --> Q[Error Handling]
```

### Test Execution Flow

```mermaid
sequenceDiagram
    participant CI as CI System
    participant Ruby as Ruby Matrix
    participant Rails as Rails Matrix
    participant Tests as Test Suite
    participant Coverage as Coverage Report
    
    CI->>Ruby: Test Ruby 3.1, 3.2, 3.3
    
    loop For each Ruby version
        Ruby->>Rails: Test Rails 7.0, 7.1, 7.2, 8.0
        
        loop For each Rails version
            Rails->>Tests: Run test suite
            Tests->>Coverage: Collect coverage
            Coverage->>CI: Report results
        end
    end
    
    CI->>CI: Aggregate results
    CI->>CI: Generate final report
```

## 🚀 Deployment Flow

### Release Process

```mermaid
flowchart TD
    A[Code Changes] --> B[Create PR]
    B --> C[CI Checks]
    C --> D{All Tests Pass?}
    D -->|No| E[Fix Issues]
    E --> B
    D -->|Yes| F[Merge to Main]
    
    F --> G[Version Bump]
    G --> H[Update CHANGELOG]
    H --> I[Create Git Tag]
    I --> J[Build Gem]
    J --> K[Run Final Tests]
    K --> L{Tests Pass?}
    L -->|No| M[Rollback]
    L -->|Yes| N[Publish to RubyGems]
    
    N --> O[Update Documentation]
    O --> P[Announce Release]
```

### Continuous Integration

```mermaid
graph TB
    subgraph "GitHub Actions"
        A[Push/PR Trigger] --> B[Setup Ruby Matrix]
        B --> C[Install Dependencies]
        C --> D[Run RuboCop on Self]
        D --> E[Run Test Suite]
        E --> F[Generate Coverage]
        F --> G[Deploy Documentation]
    end
    
    subgraph "Quality Gates"
        H[Code Coverage > 95%]
        I[RuboCop Score: 100%]
        J[Security Scan: Pass]
        K[Performance Tests: Pass]
    end
    
    E --> H
    D --> I
    C --> J
    E --> K
    
    subgraph "Notifications"
        L[Slack Integration]
        M[Email Alerts]
        N[GitHub Status]
    end
    
    G --> L
    G --> M
    G --> N
```

## 🔧 Extension Points

### Custom Cop Development

```mermaid
graph TD
    A[Identify Pattern] --> B[Create Cop Class]
    B --> C[Implement Detection Logic]
    C --> D[Add Auto-correction]
    D --> E[Write Tests]
    E --> F[Add Configuration]
    F --> G[Document Usage]
    
    subgraph "Cop Implementation"
        H[on_send method]
        I[on_class method]
        J[on_module method]
        K[Pattern Matching]
    end
    
    C --> H
    C --> I
    C --> J
    C --> K
    
    subgraph "Testing Strategy"
        L[Unit Tests]
        M[Integration Tests]
        N[Performance Tests]
    end
    
    E --> L
    E --> M
    E --> N
```

### Configuration Extension

```yaml
# Example custom configuration
inherit_gem:
  rubocop-hk: config/default.yml

# Custom cops namespace
CustomCops:
  BusinessLogic:
    Enabled: true
    Severity: warning
  
  SecurityCheck:
    Enabled: true
    Severity: error
    Exclude:
      - "lib/legacy/**/*"
```

## 📊 Performance Considerations

### Analysis Performance

```mermaid
graph LR
    A[File Input] --> B[Parsing]
    B --> C[AST Generation]
    C --> D[Cop Processing]
    D --> E[Result Collection]
    E --> F[Output Generation]
    
    subgraph "Optimization Points"
        G[File Filtering]
        H[Parallel Processing]
        I[Cache Utilization]
        J[Incremental Analysis]
    end
    
    A --> G
    D --> H
    C --> I
    B --> J
    
    subgraph "Performance Metrics"
        K[Files/Second]
        L[Memory Usage]
        M[CPU Utilization]
    end
    
    F --> K
    D --> L
    H --> M
```

### Memory Management

```mermaid
graph TD
    A[Gem Loading] --> B[Configuration Parsing]
    B --> C[Cop Registry]
    C --> D[File Processing Loop]
    
    subgraph "Memory Optimization"
        E[Lazy Loading]
        F[Object Pooling]
        G[GC Tuning]
        H[Cache Management]
    end
    
    A --> E
    C --> F
    D --> G
    B --> H
    
    subgraph "Memory Monitoring"
        I[Heap Size]
        J[Object Count]
        K[GC Frequency]
    end
    
    E --> I
    F --> J
    G --> K
```

## 🔍 Monitoring & Observability

### Usage Analytics

```mermaid
graph TB
    A[Gem Installation] --> B[Usage Tracking]
    B --> C[Configuration Analysis]
    C --> D[Performance Metrics]
    
    subgraph "Metrics Collection"
        E[Installation Count]
        F[Version Distribution]
        G[Configuration Patterns]
        H[Performance Data]
    end
    
    B --> E
    C --> F
    C --> G
    D --> H
    
    subgraph "Analytics Dashboard"
        I[User Growth]
        J[Feature Usage]
        K[Performance Trends]
        L[Error Rates]
    end
    
    E --> I
    G --> J
    H --> K
    D --> L
```

## 🛠️ Development Workflow

### Contributor Flow

```mermaid
flowchart TD
    A[Fork Repository] --> B[Clone Locally]
    B --> C[Create Feature Branch]
    C --> D[Make Changes]
    D --> E[Run Tests]
    E --> F{Tests Pass?}
    F -->|No| D
    F -->|Yes| G[Run RuboCop]
    G --> H{Style OK?}
    H -->|No| D
    H -->|Yes| I[Commit Changes]
    I --> J[Push to Fork]
    J --> K[Create PR]
    K --> L[CI Validation]
    L --> M[Code Review]
    M --> N[Merge to Main]
```

---

## 📚 Additional Resources

- [RuboCop Documentation](https://docs.rubocop.org/)
- [Ruby Style Guide](https://rubystyle.guide/)
- [Rails Style Guide](https://rails.rubystyle.guide/)
- [Contributing Guidelines](CONTRIBUTING.md)

---

<div align="center">

**Architecture designed with ❤️ for the Ruby community**

[📖 Back to README](README.md) • [🐛 Report Issue](https://github.com/hammadxcm/rubocop-hk/issues)

</div>