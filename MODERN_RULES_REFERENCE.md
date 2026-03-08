# 📚 Modern RuboCop Rules Reference (2025)

## 🎯 Quick Reference for Team Education

This document explains all 45+ new warning-only rules added to help your team understand **why** each rule matters and **when** to apply it.

---

## 🎨 **Style Rules (10 Rules) - Modern Ruby 3.3 Patterns**

### `Style/FetchEnvVar` ⚡ **HIGH PRIORITY**
```ruby
# ❌ Bad - Silent failure if ENV var missing
api_key = ENV['API_KEY']

# ✅ Good - Clear error if ENV var missing  
api_key = ENV.fetch('API_KEY')
```
**Why fix:** Prevents production bugs from missing environment variables.

### `Style/ArgumentsForwarding` 
```ruby
# ❌ Old way - verbose argument forwarding
def proxy_method(*args, **kwargs)
  target_method(*args, **kwargs)
end

# ✅ Ruby 2.7+ way - clean forwarding
def proxy_method(...)
  target_method(...)
end
```
**Why fix:** More concise and less error-prone method delegation.

### `Style/CollectionCompact` ⚡ **EASY WIN**
```ruby
# ❌ Verbose nil filtering
arr.reject(&:nil?)
hash.reject { |k, v| v.nil? }

# ✅ Clear and expressive
arr.compact
hash.compact
```
**Why fix:** More readable and potentially faster.

### `Style/HashTransformKeys/Values`
```ruby
# ❌ Manual hash transformation
hash.each_with_object({}) { |(k, v), h| h[k.upcase] = v }

# ✅ Purpose-built methods
hash.transform_keys(&:upcase)
hash.transform_values(&:upcase)
```
**Why fix:** Code clearly expresses intent to transform hash structure.

### `Style/StringChars`
```ruby
# ❌ Indirect conversion
str.each_char.to_a

# ✅ Direct method
str.chars
```
**Why fix:** More direct and readable character array creation.

---

## 🧪 **RSpec Rules (12 Rules) - Better Test Quality**

### `RSpec/BeNil` ⚡ **EASY WIN**
```ruby
# ❌ Generic matcher
expect(value).to be(nil)
expect(value).to eq(nil)

# ✅ Specific nil matcher
expect(value).to be_nil
```
**Why fix:** Better failure messages and clearer test intent.

### `RSpec/ChangeByZero` ⚡ **CLARITY WIN**
```ruby
# ❌ Confusing intent
expect { action }.to change { count }.by(0)

# ✅ Clear intent
expect { action }.not_to change { count }
```
**Why fix:** Explicitly states that nothing should change.

### `RSpec/ClassCheck`
```ruby
# ❌ Too strict - breaks with inheritance
expect(dog).to be_instance_of(Animal)

# ✅ Inheritance-friendly
expect(dog).to be_a(Animal)
expect(dog).to be_kind_of(Animal)
```
**Why fix:** Works correctly with object-oriented inheritance.

### `RSpec/IdenticalEqualityAssertion`
```ruby
# ❌ Pointless test (always passes)
expect(user).to eq(user)

# ✅ Meaningful comparison
expect(user).to eq(expected_user)
```
**Why fix:** Catches copy-paste errors and meaningless assertions.

---

## 🚄 **Rails 8.0 Rules (13 Rules) - Future Compatibility**

### `Rails/EnumSyntax` ⚡ **CRITICAL for Rails 8.0**
```ruby
# ❌ Rails 8.0 deprecated syntax
enum status: { active: 0, archived: 1 }, _prefix: true

# ✅ Rails 8.0+ required syntax
enum :status, { active: 0, archived: 1 }, prefix: true
```
**Why fix:** **REQUIRED** for Rails 8.0 compatibility. Old syntax will be removed.

### `Rails/ResponseParsedBody` ⚡ **TEST IMPROVEMENT**
```ruby
# ❌ Manual JSON parsing in tests
JSON.parse(response.body)

# ✅ Rails-provided method
response.parsed_body
```
**Why fix:** Handles different content types automatically and more reliable.

### `Rails/ThreeStateBooleanColumn`
```ruby
# ❌ Confusing three-state column
# Migration: t.boolean :active (allows true/false/null)

# ✅ Clear two-state with default
# Migration: t.boolean :active, default: false, null: false
```
**Why fix:** Eliminates confusion between `false` and `null` states.

### `Rails/DeprecatedActiveModelErrorsMethods` ⚡ **COMPATIBILITY**
```ruby
# ❌ Rails 6.1+ deprecated
errors[:name] = "can't be blank"

# ✅ Modern error API
errors.add(:name, "can't be blank")
```
**Why fix:** Future-proofs validation error handling.

---

## ⚡ **Performance Rules (8 Rules) - Speed Improvements**

### `Performance/ConstantRegexp` ⚡ **PERFORMANCE WIN**
```ruby
# ❌ Regexp compiled every time
def validate_email(email)
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i  # ❌ Inside method
  email.match?(EMAIL_REGEX)
end

# ✅ Compile once, reuse
EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i  # ✅ Outside method

def validate_email(email)
  email.match?(EMAIL_REGEX)
end
```
**Why fix:** Avoids expensive regexp compilation in loops/frequent calls.

### `Performance/RangeInclude` ⚡ **BIG PERFORMANCE WIN**
```ruby
# ❌ Slow - iterates through entire range
(1..1_000_000).include?(500_000)

# ✅ Fast - simple boundary check
(1..1_000_000).cover?(500_000)
```
**Why fix:** `#cover?` is O(1), `#include?` can be O(n) for large ranges.

### `Performance/Sum`
```ruby
# ❌ Generic reduction
numbers.inject(:+)
numbers.reduce(:+)

# ✅ Optimized for numeric sums
numbers.sum
```
**Why fix:** `#sum` is optimized specifically for numeric addition.

---

## 🔒 **Security & Quality (Lint Rules) - Bug Prevention**

### `Lint/RequireRangeParentheses` ⚡ **SUBTLE BUG PREVENTION**
```ruby
# ❌ Parsed as (x == 1)..10 (always 1..10 or 0..10)
if x == 1..10

# ✅ Clear intent
if x == (1..10)
if (1..10).include?(x)  # Even better
```
**Why fix:** Prevents hard-to-debug precedence bugs.

### `Lint/EmptyBlock`
```ruby
# ❌ Empty block - usually incomplete code
items.each { }

# ✅ Either remove or implement
items.each { |item| process(item) }
# OR remove entirely if not needed
```
**Why fix:** Often indicates incomplete implementation or dead code.

### `Lint/DuplicateBranch`
```ruby
# ❌ Identical branches (likely bug)
if condition
  puts "Processing..."
  result = process_data
else  
  puts "Processing..."  # ❌ Same code
  result = process_data
end

# ✅ Extract common logic
puts "Processing..."
result = process_data
```
**Why fix:** Usually indicates logic errors or unnecessary complexity.

---

## 🏆 **Priority Learning Path**

### Week 1: **Critical Rails 8.0**
Focus on `Rails/EnumSyntax` and `Rails/DeprecatedActiveModelErrorsMethods`

### Week 2: **Security & Performance** 
Learn `Style/FetchEnvVar` and `Performance/ConstantRegexp`

### Week 3: **Easy Quality Wins**
Apply `Style/CollectionCompact`, `RSpec/BeNil`, and `Performance/Sum`

### Week 4: **Advanced Patterns**
Explore `Style/ArgumentsForwarding` and `Style/HashTransform*`

---

## 💡 **Code Review Integration**

### Review Comment Templates
```markdown
💡 **Modern Ruby Pattern**: Consider using `arr.compact` instead of `arr.reject(&:nil?)`
📊 **Performance**: This regexp is compiled every call - consider extracting to a constant
🚨 **Rails 8.0**: This enum syntax will be deprecated - use `enum :status, {...}` instead
🧪 **Test Quality**: Use `be_nil` matcher for clearer failure messages
```

### Review Checklist
- [ ] Are new ENV variables accessed with `ENV.fetch`?
- [ ] Are Rails 8.0 enum patterns used?
- [ ] Are performance-critical regexps extracted to constants?
- [ ] Are RSpec matchers specific and descriptive?

---

**Remember**: All these rules are **warnings only**. Use them as learning opportunities to gradually improve code quality without pressure! 🎯