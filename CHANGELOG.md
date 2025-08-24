## [Unreleased]

## [0.1.0] - 2021-06-04

- Initial release

## [1.0.0] - 2025-04-07
### Breaking Changes
- Updated required Ruby version to 3.1.7
- Updated RuboCop dependency to ~> 1.75.2
- Updated rubocop-rails dependency to ~> 2.31.0
- Updated rubocop-rspec dependency to ~> 3.5.0

### Security
- Updated rubocop-rails dependency to ~> 2.27 to address Rack security vulnerabilities (CVE-2025-27610, CVE-2025-25184, CVE-2025-27111)

## [1.0.1] - 2025-04-08
### Fixed
- Updated RuboCop configuration to use `plugins` instead of `require` for rubocop-rspec and rubocop-rails extensions
