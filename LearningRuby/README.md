# Learning Ruby

- [Learning Ruby](#learning-ruby)
  - [Primitive types](#primitive-types)
    - [Comparison with Primitive Types in Other Languages](#comparison-with-primitive-types-in-other-languages)
  - [Strings](#strings)
    - [Multiline](#multiline)
      - [Special character `\` or `+`](#special-character--or-)
        - [using `\`](#using-)
        - [Using `+`](#using--1)
    - [HEREDOC](#heredoc)
      - [Operator `<<-`, ignoring indentation](#operator---ignoring-indentation)
      - [Operator `<<~`, keep indentation](#operator--keep-indentation)
      - [HEREDOC data Interpolation](#heredoc-data-interpolation)
      - [HEREDOC using string  core methods](#heredoc-using-string--core-methods)
    - [Slice string](#slice-string)
      - [`.slice`](#slice)
      - [`.slice!`](#slice-1)
    - [removing prefix and suffix](#removing-prefix-and-suffix)
      - [`delete_prefix`](#delete_prefix)
      - [`delete_suffix`](#delete_suffix)
  - [Integer / Numbers](#integer--numbers)
  - [Equality operators](#equality-operators)
    - [operator `==` and `!=`](#operator--and-)
    - [operator `eql?`](#operator-eql)
    - [operator `equal?`](#operator-equal)
    - [operator `===`](#operator-)
      - [type comparator](#type-comparator)
      - [Implicit usage](#implicit-usage)
  - [Pattern matching operator](#pattern-matching-operator)
  - [Compare operator](#compare-operator)
  - [Variables](#variables)
    - [Local Variables](#local-variables)
    - [Instance Variables (`@`)](#instance-variables-)
    - [Class Variables (`@@`)](#class-variables-)
    - [Global Variables (`$`)](#global-variables-)
    - [Constants](#constants)
    - [Pseudo-Variables](#pseudo-variables)
    - [Special Variables](#special-variables)
    - [Summary of Variable Types](#summary-of-variable-types)
  - [Accumulator concept](#accumulator-concept)
  - [Concept](#concept)
    - [Comparing object values](#comparing-object-values)
  - [Reference](#reference)

## Primitive types

Ruby actually doesn't have primitive types, every type on Ruby is an instance of an class

### Comparison with Primitive Types in Other Languages

| Concept  | Ruby                     | Java/C/C++        |
| -------- | ------------------------ | ----------------- |
| Integer  | `Integer` class          | `int`             |
| Float    | `Float` class            | `float`, `double` |
| String   | `String` class           | `char*`, `String` |
| Boolean  | `TrueClass`/`FalseClass` | `bool`, `boolean` |
| Null/Nil | `NilClass` (`nil`)       | `null`, `         |

## Strings

### Multiline

There's few ways to handle multiline strings on ruby

#### Special character `\` or `+`

##### using `\`

```rb
"Something needs to be "\
"done so maybe, just maybe "\
"this might work"
```

**Output:**

```mono
"Something needs to bed one so maybe, just maybe this might work"
```

##### Using `+`

```rb
"Something needs to be " +
"done so maybe, just maybe " +
"this might work"
```

**Output:**

```mono
"Something needs to bed one so maybe, just maybe this might work"
```

### HEREDOC

#### Operator `<<-`, ignoring indentation

```rb
<<-TXT 
  Something needs to be
  done so maybe, just maybe
  this might work
TXT
```

**Output:**

```mono
"  Something needs to be\n  done so maybe, just maybe\n  this might work\n"
```

#### Operator `<<~`, keep indentation

```rb
<<~TXT 
  Something needs to be
  done so maybe, just maybe
  this might work
TXT
```

**Output:**

```mono
"Something needs to be\ndone so maybe, just maybe\nthis might work\n"
```

#### HEREDOC data Interpolation

Here docs also can have string interpolation

```rb
<<~HEREDOC
  Current time is #{Time.now}
HEREDOC
```

**Output:**

```mono
"Current time is 2022-12-21 17:12:42 -0300\n"
```

and still it could be used with a more complex interpolation

```rb
@patient = Patient.last

<<~HEREDOC
  Current time is #{@patient.first_name}
HEREDOC
```

**Output:**

```mono
"Current time is Lucas\n"
```

#### HEREDOC using string  core methods

HEREDOC also accept string methods, like `strip`, `chomp` and etc...

```rb
<<~HEREDOC.strip
  Current time is #{@patient.first_name}
HEREDOC
```

**Output:**

```mono
"Current time is Lucas"
```

### Slice string

#### `.slice`

```shell
irb(main):001:0> string = "prefix-content-suffix"
=> "prefix-content-suffix"
irb(main):002:0> string.slice("prefix-")
=> "prefix-"
irb(main):003:0> string
=> "prefix-content-suffix"
```

#### `.slice!`

```shell
irb(main):001:0> string = "prefix-content-suffix"
=> "prefix-content-suffix"
irb(main):002:0> string.slice!("prefix-")
=> "prefix-"
irb(main):003:0> string
=> "content-suffix"
```

### removing prefix and suffix

#### `delete_prefix`

```shell
irb(main):01:0> string = "prefix-content-suffix"
=> "prefix-content-suffix"
irb(main):02:0> string.delete_prefix("prefix-")
=> "content-suffix"
irb(main):03:0> 
```

It might use some sort of regex to remove only prefix, because it only removes what comes on prefix

```shell
irb(main):04:0> string.delete_prefix("-suffix")
=> "prefix-content-suffix"
irb(main):05:0> 
```

#### `delete_suffix`

```shell
irb(main):01:0> string = "prefix-content-suffix"
=> "prefix-content-suffix"
irb(main):02:0> string.delete_suffix("-suffix")
=> "prefix-content"
irb(main):03:0> 
```

Note that `delete_prefix` and `delete_suffix` returns the string modified, but it won't change the variable itself, as `slice!`, another interesting aspect is that if `slice` doesn't match the value to be removed it returns `nil`, however both delete methods returns always the string whether the value was matched or not.

## Integer / Numbers

| Type    |   limit    | Numeric Type | Column Size | Max value           |
| :------ | :--------: | :----------: | :---------: | :------------------ |
| integer |     1      |   tinyint    |   1 byte    | 127                 |
| integer |     2      |   smallint   |   2 bytes   | 32767               |
| integer |     3      |  mediumint   |   3 byte    | 8388607             |
| integer | nil, 4, 11 |   int(11)    |   4 byte    | 2147483647          |
| bigint  |    5..8    |    bigint    |   8 byte    | 9223372036854775807 |

## Equality operators

### operator `==` and `!=`

```rb
irb(main):001:0> "This string" == "This string"
=> true
irb(main):002:0> "This string" == "That string"
=> false
irb(main):003:0> "This string" != "This string"
=> false
irb(main):004:0> "This string" != "That string"
=> true
```

On string it's very easy to understand how it works, but if we attempt to check equality on numbers

```rb
irb(main):001:0> 1 == 1
=> true
irb(main):002:0> 1 == 1.0
=> true
irb(main):003:0> 1 == 2
=> false
irb(main):004:0> 
```

> **Notice:** that 1 == 1.0 are true however it has different type `integer` and `float`

### operator `eql?`

```rb
irb(main):001:0> 1.eql? 1.0
=> false
irb(main):002:0> 1.eql? 1
=> true
```

> **Notice:**  that it solves the type issue on `==`

```rb
irb(main):001:0> test_1 = 1
=> 1
irb(main):002:0> test_2 = 1.0
=> 1.0
irb(main):003:0> test_1 == test_2
=> true
irb(main):004:0> test_1.eql? test_2
=> false
```

### operator `equal?`

```rb
irb(main):001:0> test_1 = 1
=> 1
irb(main):002:0> test_2 = 1.0
=> 1.0
irb(main):003:0> test_1.equal? test_2
=> false
irb(main):004:0> test_1.eql? test_2
=> false
irb(main):005:0> test_1 == test_2
=> true
```

> I didn't get the difference between `equal?` and `eql?` but seems something related to the object memory address

### operator `===`

`===` operator is a range or collection operator, it works almost like `include?` method

```rb
irb(main):001:0> (1..4) === 3
=> true
irb(main):002:0> (1..4) === 5
=> false
irb(main):003:0> (1..4).include? 3
=> true
irb(main):004:0> (1..4).include? 5
=> false
```

However `===` doesn't work for a complex inclusion checking

```rb
irb(main):001:0> [{id: 1}, {id: 2}, {id: 4}] === ({id: 2})
=> false
irb(main):002:0> [{id: 1}, {id: 2}, {id: 4}].include?({id: 2})
=> true
```

#### type comparator

But `===` operator has a variety of usages including type comparator

```rb
irb(main):001:0> String === "Zen"
=> true
irb(main):002:0> Range === (..1)
=> true
irb(main):003:0> Array === []
=> true
irb(main):004:0> Integer === 1
=> true
irb(main):005:0> Float === 1.0
=> true
```

#### Implicit usage

```rb
minutes = 15

case minutes
  when 10..20
    puts "match"
  else
    puts "no match"
end
```

**Output:**

```mono
match
```

## Pattern matching operator

Ruby has a pattern matching operator (`=~`) that works like magic

```rb
irb(main):014:0> "There's a matching here" =~ /matching/
=> 10
```

It returns `10` since the first char match was on the `10` index of the sentence.

Let's try to find a partial match

```rb
irb(main):019:0> "There's a matching here" =~ /atching/
=> 11
```

it returns nil on case of mismatch

```rb
irb(main):019:0> "There's a matching here" =~ /tatching/
=> nil
```

But notice that it return the index of first match

```rb
irb(main):019:0> "There's a matching here" =~ /here/
=> 1
```

## Compare operator

Ruby has a special compare operator (`<=>`)

It's simple, comparing to values, in case a given value is different from the other it returns 1, 0 or -1

**Example:**

Comparing char/string

```rb
irb(main):001:0> "a" <=> "b"
=> -1
irb(main):002:0> "a" <=> "c"
=> -1
irb(main):003:0> "a" <=> "a"
=> 0
irb(main):004:0> "b" <=> "a"
=> 1
```

> **Notice:** that it compares based on the positioning on the alphabet, for instance `a` is on lesser positioning than `b`, so it returns `-1`, if we compare `a` with `a` it returns `0`, and if we compare `b` to `a`, ir returns `1` since `b` has a higher positioning than `a` .

On integers compare it's very straight forward

**Example:**

```rb
irb(main):001:0> 1 <=> 2
=> -1
irb(main):002:0> 2 <=> 2
=> 0
irb(main):003:0> 2 <=> 1
=> 1
irb(main):004:0> 
```

## Variables

### Local Variables

- **Scope**: Limited to the block, method, or class/module where they are defined.
- **Naming Convention**: Start with a lowercase letter or an underscore (`_`).
- **Example**:

  ```ruby
  def greet
    message = "Hello, World!" # Local variable
    puts message
  end

  greet # Output: Hello, World!
  # puts message # Error: undefined local variable
  ```

---

### Instance Variables (`@`)

- **Scope**: Belong to a specific object instance.
- Used to store object-specific state.
- Already covered in previous explanations.

---

### Class Variables (`@@`)

- **Scope**: Shared across all instances of a class and the class itself.
- Already covered in previous explanations.

---

### Global Variables (`$`)

- **Scope**: Accessible throughout the entire Ruby program.
- Already covered in previous explanations.

---

### Constants

- **Scope**: Associated with classes or modules. They are accessible using the class/module namespace and cannot be changed without a warning.
- **Naming Convention**: Start with a capital letter.
- **Example**:

  ```ruby
  class Config
    API_URL = "https://example.com" # Constant
  end

  puts Config::API_URL # Output: https://example.com
  ```

---

### Pseudo-Variables

- These are special variables provided by Ruby and cannot be assigned to. They represent particular values or objects in Ruby.

| Pseudo-Variable | Meaning                                     |
| --------------- | ------------------------------------------- |
| `self`          | Refers to the current object.               |
| `nil`           | Represents the absence of value (null).     |
| `true`          | Represents a boolean true value.            |
| `false`         | Represents a boolean false value.           |
| `__FILE__`      | The name of the current source file.        |
| `__LINE__`      | The current line number in the source file. |

**Example**:

```ruby
puts "This code is in file: #{__FILE__} on line #{__LINE__}"
```

---

### Special Variables

Ruby has some pre-defined special variables, typically used for advanced scripting. These are denoted by `$` followed by a single character.

| Variable     | Description                                  |
| ------------ | -------------------------------------------- |
| `$0`         | The name of the Ruby script.                 |
| `$?`         | Exit status of the last executed command.    |
| `$_`         | Last input line read by `gets`.              |
| `$LOAD_PATH` | Array of paths to search for required files. |

**Example**:

```ruby
puts $0 # Outputs the script name
```

---

### Summary of Variable Types

| Type               | Scope                                    | Example Naming            |
| ------------------ | ---------------------------------------- | ------------------------- |
| Local Variables    | Limited to a block or method.            | `my_var`, `_temp`         |
| Instance Variables | Object-specific.                         | `@instance_var`           |
| Class Variables    | Shared across a class and its instances. | `@@class_var`             |
| Global Variables   | Accessible across the entire program.    | `$global_var`             |
| Constants          | Associated with classes or modules.      | `CONSTANT_NAME`           |
| Pseudo-Variables   | Special system-defined variables.        | `self`, `nil`, `__LINE__` |

These variable types give Ruby its flexibility while maintaining clear scoping rules!

## Accumulator concept

In ruby we can use the Accumulator with two methods `inject` or `reduce`

```rb
enumerable.inject(initial_value) { |accumulator, element| block }


enumerable.reduce(initial_value) { |accumulator, element| block }
```

> **initial_value**: The starting value of the accumulator (optional).
> **accumulator**: The variable that holds the accumulated value throughout the iterations.
> **element**: The current element being processed.
> **block**: logical operation that will happen.

**Example:**

```rb
# Using inject
result1 = [1, 2, 3].inject(0) { |sum, num| sum + num }

# Using reduce
result2 = [1, 2, 3].reduce(0) { |sum, num| sum + num }

puts result1  # Output: 6
puts result2  # Output: 6
```

## Concept

### Comparing object values

```rb
products = [
  { type: "Product", title: "Notebook", value: 20.00 }, 
  { type: "Product", name: "Pencils", value: 5.00 }
]

services = [
  { type: "Service", title: "Copy", value: 10.0 }, 
  { type: "Service", title: "Colored copy", value: 15.00 }
]

totals = (products + services).sort { |first, second| first[:value] <=> second[:value] }

p totals
```

```mono
=> 
[{:type=>"Product", :name=>"Pencils", :value=>5.0},
 {:type=>"Service", :title=>"Copy", :value=>10.0},
 {:type=>"Service", :title=>"Colored copy", :value=>15.0},
 {:type=>"Product", :title=>"Notebook", :value=>20.0}]
```

## Reference

[Equality operators](https://medium.com/@khalidh64/difference-between-eql-equal-in-ruby-2ffa7f073532)
