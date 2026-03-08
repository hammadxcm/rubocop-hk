# 🏗️ RuboCop HK Architecture

> **Comprehensive architecture documentation for RuboCop HK configuration gem**  
> **🆕 v1.2.1: Warning-Only Modern Rules with Team-Focused Adoption Strategy**

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🆕 v1.2.1 Architecture Changes](#-v120-architecture-changes)
- [🏛️ System Architecture](#️-system-architecture)
- [📦 Module Structure](#-module-structure)
- [⚙️ Configuration System](#️-configuration-system)
- [🔄 Plugin Integration](#-plugin-integration)
- [🧪 Testing Architecture](#-testing-architecture)
- [🚀 Deployment Flow](#-deployment-flow)
- [🔧 Extension Points](#-extension-points)
- [📊 Performance Considerations](#-performance-considerations)
- [🛠️ Team Adoption Architecture](#️-team-adoption-architecture)

## 🎯 Overview

RuboCop HK is a comprehensive configuration gem that provides curated RuboCop rules for modern Ruby and Rails applications. It follows a modular architecture that allows for flexible configuration inheritance and extensibility.

**🆕 v1.2.1 Enhancement**: Added 45+ warning-only modern rules with comprehensive team adoption tooling, educational documentation, and gradual migration strategies.

### Design Principles

- **🔧 Modular Configuration** - Separate configs for different concerns
- **📈 Gradual Adoption** - Easy migration path for existing projects
- **🎯 Rails-First** - Optimized for Rails development patterns
- **🔌 Extensible** - Plugin architecture for custom cops
- **⚡ Performance** - Minimal overhead and fast execution
- **⚠️ Warning-Only Modernization** - New rules as warnings to prevent build breaks
- **📚 Educational Approach** - Detailed explanations for every modern rule
- **🤝 Team-Focused** - Built-in tooling for team adoption workflows

## 🆕 v1.2.1 Architecture Changes

### Modern Rules Engine

```mermaid
graph TB
    subgraph "Traditional RuboCop (Error-Only)"
        A[Rule Violation] --> B[Build Failure]
        B --> C[Developer Frustration]
    end
    
    subgraph "RuboCop HK v1.2.1 (Warning-Only)"
        D[Rule Violation] --> E[Warning Message]
        E --> F[Educational Content]
        F --> G[Gradual Learning]
        G --> H[Voluntary Adoption]
    end
    
    subgraph "Team Tooling"
        I[make warning-summary] --> J[Team Progress]
        K[make promote COPS=...] --> L[Selective Enforcement]
        M[scripts/promote-warnings.rb] --> N[Safe Migration]
    end
    
    H --> I
    H --> K
    L --> M
```

### Warning-Only Implementation Strategy

```mermaid
flowchart TD
    A[New Modern Rule] --> B{Implementation Strategy}
    B --> C[Add as WARNING severity]
    C --> D[Add detailed Description]
    D --> E[Add Why Fix explanation]
    E --> F[Add Before/After examples]
    F --> G[Add to promotion script]
    G --> H[Update team documentation]
    
    subgraph "Educational Components"
        I[MODERN_RULES_REFERENCE.md]
        J[GRADUAL_ADOPTION_GUIDE.md]
        K[Code review templates]
        L[Sprint planning guides]
    end
    
    H --> I
    H --> J
    H --> K
    H --> L
    
    subgraph "Automation Tools"
        M[scripts/promote-warnings.rb]
        N[Makefile commands]
        O[CI/CD integration hooks]
    end
    
    G --> M
    G --> N
    G --> O
```

### Team Adoption Workflow

```mermaid
stateDiagram-v2
    [*] --> Warning: Install v1.2.1
    Warning --> Education: make warning-summary
    Education --> QuickWins: make fix-easy-wins
    QuickWins --> Strategic: Team consensus
    Strategic --> Enforcement: make promote COPS=...
    Enforcement --> Monitoring: Continuous improvement
    Monitoring --> Education: New team members
    
    state Warning {
        [*] --> NoFailure: 45+ new rules
        NoFailure --> Visibility: Show opportunities
        Visibility --> Learning: Educational content
    }
    
    state Education {
        [*] --> TeamGuides: GRADUAL_ADOPTION_GUIDE.md
        TeamGuides --> RuleReference: MODERN_RULES_REFERENCE.md
        RuleReference --> Discussion: Code review integration
    }
    
    state QuickWins {
        [*] --> AutoFix: Performance improvements
        AutoFix --> SafeChanges: Test pattern updates
        SafeChanges --> Momentum: Visible progress
    }
    
    state Strategic {
        [*] --> Rails8Compat: make check-rails8-warnings
        Rails8Compat --> Security: Lint improvements
        Security --> Modernization: Ruby 3.3 patterns
    }
    
    state Enforcement {
        [*] --> SelectivePromotion: Promote specific cops
        SelectivePromotion --> BackupRestore: Safe configuration changes
        BackupRestore --> TeamStandards: Agreed-upon rules
    }
```

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
├── rubocop-style.yml         # Style rules (🆕 10 warning-only modern rules)
├── rubocop-rails.yml         # Rails-specific rules (🆕 13 Rails 8.0 rules)
├── rubocop-rspec.yml         # RSpec rules (🆕 12 modern testing rules)
├── rubocop-layout.yml        # Code layout rules
├── rubocop-metrics.yml       # Complexity metrics
├── rubocop-performance.yml   # Performance rules (🆕 8 modern optimization rules)
└── rubocop-lint.yml          # Lint rules (🆕 10 security & quality rules)
scripts/                      # 🆕 Team adoption tooling
├── promote-warnings.rb       # Warning promotion automation
└── backup-restore.rb         # Configuration backup/restore
docs/                         # 🆕 Educational documentation
├── GRADUAL_ADOPTION_GUIDE.md # Team adoption strategy
├── MODERN_RULES_REFERENCE.md # Detailed rule explanations
└── CODE_REVIEW_TEMPLATES.md  # Review integration guides
Makefile                      # 🆕 15+ team workflow commands
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

## 🛠️ Team Adoption Architecture

### Warning Promotion System

```mermaid
graph TB
    subgraph "Warning Management"
        A[scripts/promote-warnings.rb] --> B[Configuration Parser]
        B --> C[Cop Identifier]
        C --> D[Backup Creator]
        D --> E[Severity Modifier]
        E --> F[Validation Engine]
        F --> G[Rollback Capability]
    end
    
    subgraph "Team Tooling Commands"
        H[make warning-summary] --> I[Progress Dashboard]
        J[make check-warnings] --> K[Active Warnings List]
        L[make promote COPS=...] --> A
        M[make fix-easy-wins] --> N[Auto-fix Safe Rules]
        O[make check-rails8-warnings] --> P[Rails 8.0 Compatibility]
    end
    
    subgraph "Educational Integration"
        Q[GRADUAL_ADOPTION_GUIDE.md] --> R[4-Phase Strategy]
        S[MODERN_RULES_REFERENCE.md] --> T[Rule Explanations]
        U[CODE_REVIEW_TEMPLATES.md] --> V[Team Integration]
    end
    
    I --> Q
    K --> S
    P --> U
```

### 4-Phase Adoption Strategy Architecture

```mermaid
stateDiagram-v2
    state "Phase 1: Team Education" as P1 {
        [*] --> ReadGuides: GRADUAL_ADOPTION_GUIDE.md
        ReadGuides --> ReviewWarnings: make warning-summary
        ReviewWarnings --> TeamDiscussion: Weekly standup
        TeamDiscussion --> FocusNewCode: No pressure on legacy
    }
    
    state "Phase 2: Quick Wins" as P2 {
        [*] --> AutoFix: make fix-easy-wins
        AutoFix --> PerformanceWins: Performance/* cops
        PerformanceWins --> TestPatterns: RSpec/* improvements
        TestPatterns --> BuildMomentum: Visible progress
    }
    
    state "Phase 3: Strategic" as P3 {
        [*] --> Rails8Compat: make check-rails8-warnings
        Rails8Compat --> SecurityImprovements: Lint/* cops
        SecurityImprovements --> ModernPatterns: Style/* cops
        ModernPatterns --> TeamConsensus: Group decision making
    }
    
    state "Phase 4: Enforcement" as P4 {
        [*] --> SelectivePromotion: make promote COPS=...
        SelectivePromotion --> TeamStandards: Agreed rules → errors
        TeamStandards --> ContinuousImprovement: Monthly review
        ContinuousImprovement --> Celebration: Milestone achievements
    }
    
    [*] --> P1
    P1 --> P2: Week 2
    P2 --> P3: Month 1
    P3 --> P4: Month 2
    P4 --> [*]: Ongoing
```

### Educational Content Architecture

```mermaid
graph TD
    subgraph "Rule Documentation Structure"
        A[Individual Rule] --> B[Description]
        B --> C[Why Fix explanation]
        C --> D[Before/After examples] 
        D --> E[Priority guidance]
        E --> F[Team communication tips]
    end
    
    subgraph "Documentation Files"
        G[MODERN_RULES_REFERENCE.md] --> H[45+ Rule Details]
        I[GRADUAL_ADOPTION_GUIDE.md] --> J[Implementation Strategy]
        K[CODE_REVIEW_TEMPLATES.md] --> L[Review Integration]
    end
    
    subgraph "Team Integration Points"
        M[Sprint Planning] --> N[Prioritized Rule Lists]
        O[Code Reviews] --> P[Template Responses]
        Q[Team Standups] --> R[Progress Metrics]
        S[Retrospectives] --> T[Improvement Planning]
    end
    
    A --> G
    J --> M
    L --> O
    H --> Q
    J --> S
```

### Automation & CI Integration

```mermaid
flowchart TD
    subgraph "Local Development"
        A[Developer Commits] --> B[Pre-commit Hook]
        B --> C[make check-warnings]
        C --> D[Show Modernization Opportunities]
        D --> E[Educational Moment]
    end
    
    subgraph "CI Pipeline Integration"
        F[PR Created] --> G[CI Runs RuboCop]
        G --> H[Warnings Collected]
        H --> I[Educational Comments Added]
        I --> J[No Build Failure]
        J --> K[Review Process Enhanced]
    end
    
    subgraph "Team Dashboard"
        L[make warning-summary] --> M[Progress Metrics]
        M --> N[Team Performance]
        N --> O[Modernization Score]
        O --> P[Celebration Milestones]
    end
    
    subgraph "Safe Migration Tools"
        Q[make promote COPS=...] --> R[Configuration Backup]
        R --> S[Selective Rule Promotion]
        S --> T[Team Agreement Enforcement]
        T --> U[Rollback if Issues]
    end
    
    E --> F
    K --> L
    P --> Q
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