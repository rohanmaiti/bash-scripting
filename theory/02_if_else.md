## 🚦 Lesson 2: If Statements - Making Decisions

We are learning `if/else` statements, which are fundamental for controlling the flow of your script. They allow your script to make decisions based on conditions.

### Understanding the Basic `if/else` Syntax

The core structure of an `if` statement in Bash is as follows:

```bash
if condition_to_test; then
    # Commands to execute if 'condition_to_test' is TRUE (exit status 0)
elif another_condition_to_test; then # 'elif' (else if) is optional
    # Commands to execute if 'another_condition_to_test' is TRUE
else # 'else' is optional
    # Commands to execute if ALL preceding conditions are FALSE
fi # MANDATORY: Marks the end of the if statement (if spelled backward)
```

**Key Points about the Syntax:**

* `if` and `then` are mandatory keywords.
* `fi` is mandatory to close the `if` block. It's simply `if` spelled backward.
* **Semicolon `;` or a newline** after the condition: The `then` keyword must be on a new line or separated by a semicolon from the condition. Both are valid:
    * `if condition; then` (common on one line)
    * `if condition`
        `then` (common over multiple lines for readability)
* `elif` (else if) and `else` blocks are optional. You can have multiple `elif` blocks.
* The `condition` part: This is where you specify what to test. Bash evaluates the command(s) or expression(s) within this condition.
    * If the command/expression exits with a `0` (zero) status, Bash interprets it as **TRUE**.
    * If the command/expression exits with a non-`0` (non-zero) status, Bash interprets it as **FALSE**.

Now, let's look at the best ways to write your conditions within `if` statements, including where `-lt`, `-gt`, etc., fit in.

---

### 1. For Numeric Comparisons (integers): Use `(( ... ))` (Recommended)

This is the preferred modern method for comparing numbers because it uses standard C-style arithmetic operators, which are intuitive and powerful.

**Syntax:** `(( arithmetic_expression ))`

**Operators:**

* `==` (equal to)
* `!=` (not equal to)
* `>` (greater than)
* `<` (less than)
* `>=` (greater than or equal to)
* `<=` (less than or equal to)
* `&&` (logical AND)
* `||` (logical OR)

**Key Advantage:** Variables inside `((...))` do not need to be prefixed with `$`.

**Example:**

```bash
#!/bin/bash
echo "Enter your age:"
read age

if (( age >= 18 )); then
    echo "You are an adult."
elif (( age >= 13 && age < 18 )); then
    echo "You are a teenager."
else
    echo "You are a child."
fi

# Another example: Check if a number is even
echo "Enter a number to check if it's even:"
read num
if (( num % 2 == 0 )); then
    echo "$num is an even number."
else
    echo "$num is an odd number."
fi
```

---

### 2. For String Comparisons, File Tests, and Regex Matching: Use `[[ ... ]]` (Recommended)

This is the preferred modern method for dealing with strings, checking file attributes, and performing more complex pattern matching. It's a Bash-specific keyword, making it more robust and safer than the older `[ ]` syntax.

**Syntax:** `[[ conditional_expression ]]`

**Operators for Strings:**

* `==` or `=` (equal to)
* `!=` (not equal to)
* `<` (less than, ASCII alphabetical order)
* `>` (greater than, ASCII alphabetical order)
* `=~` (matches regular expression)

**Operators for Files:**

* `-e file`: True if file exists.
* `-f file`: True if file is a regular file.
* `-d file`: True if file is a directory.
* `-s file`: True if file has a size greater than zero.
* `-r file`: True if file is readable.
* `-w file`: True if file is writable.
* `-x file`: True if file is executable.

**Key Advantage:**

* **Safer with Unquoted Variables**: While it's still good practice to quote variables within `[[ ]]` (e.g., `"$name"`), `[[ ]]` is much more forgiving than `[ ]`. It prevents accidental word splitting and globbing if a variable contains spaces or wildcards and is unquoted. This significantly reduces common scripting errors.
* **Logical Operators**: You can use `&&` (logical AND) and `||` (logical OR) directly within `[[ ... ]]`.

**Example:**

```bash
#!/bin/bash
echo "Enter your name:"
read name

if [[ "$name" == "Alice" ]]; then
    echo "Hello, Alice! Welcome back."
elif [[ "$name" == "Bob" || "$name" == "Robert" ]]; then
    echo "Hey Bob/Robert!"
else
    echo "Nice to meet you, $name."
fi

# Example: Check if a file exists
file_name="my_document.txt"
if [[ -f "$file_name" ]]; then # Checks if 'my_document.txt' is a regular file
    echo "File '$file_name' exists and is a regular file."
else
    echo "File '$file_name' does not exist or is not a regular file."
fi

# Example: Regular expression matching
echo "Enter a word (check for digits):"
read word
if [[ "$word" =~ [0-9] ]]; then # =~ checks if the word contains any digit
    echo "The word '$word' contains digits."
else
    echo "The word '$word' does not contain digits."
fi
```

---

### 3. The `[ ]` (or `test`) Command: Where `-lt`, `-gt` Live

This is where the `-lt`, `-gt`, `-eq`, etc., operators come into play. They are operators specifically for the `[ ]` (or `test`) command.

**Syntax:** `[ expression ]` or `test expression`

**Numeric Comparison Operators (used with `[ ]` or `test`):**

* `-eq`: equal to
* `-ne`: not equal to
* `-gt`: greater than
* `-ge`: greater than or equal to
* `-lt`: less than
* `-le`: less than or equal to

**String Comparison Operators (used with `[ ]` or `test`):**

* `=`: equal to
* `!=`: not equal to
* `<`: less than (ASCII alphabetical order)
* `>`: greater than (ASCII alphabetical order)
* `-z string`: True if the string is empty (zero length).
* `-n string`: True if the string is not empty (non-zero length).

**Key Considerations:**

* You **MUST quote variables** (e.g., `"$num"`, `"$name"`) inside `[ ]` to prevent word splitting and globbing issues, which can lead to syntax errors.
* It uses different, less intuitive operators for logical AND (`-a`) and OR (`-o`), which also have tricky precedence rules and are generally harder to use correctly than `&&` and `||` in `[[ ]]`.
* `[ ]` is either an external program or a shell builtin that behaves like one.

**When to use them (`-lt`, `-gt`, etc.)?**

You will primarily encounter and use `-lt`, `-gt`, `-eq`, etc., when working with:

* **Older Bash scripts**: Many legacy scripts still use `[ ]` extensively. You need to understand them to read and maintain these scripts.
* **Scripts intended for wider shell compatibility**: If you need your script to run not just in Bash, but also in older shells like `sh`, `dash`, or `csh` (which might not support `[[ ]]` or `(( ))`), then `[ ]` (and thus `-lt`, `-gt` etc.) becomes necessary. However, for Bash-specific scripting, `(( ))` for numbers and `[[ ]]` for strings/files are strongly preferred.

**Example using `[ ]` with `-gt`, `-lt`, etc.:**

```bash
#!/bin/bash
echo "Enter a number (for [ ] example):"
read num_val

# Example using -gt and -le with [ ]
if [ "$num_val" -gt 10 ]; then # Using -gt for greater than
    echo "With [ ]: $num_val is greater than 10."
elif [ "$num_val" -le 5 ]; then # Using -le for less than or equal to
    echo "With [ ]: $num_val is 5 or less."
else
    echo "With [ ]: $num_val is between 6 and 10 (inclusive)."
fi

# Example using string comparison with = in [ ]
echo "Enter your favorite color:"
read color
if [ "$color" = "blue" ]; then # Using = for string equality
    echo "With [ ]: Blue is a great color!"
else
    echo "With [ ]: Your color is not blue."
fi
```

**Why we recommend avoiding `[ ]` for new Bash scripts:**

The primary reason is the necessity of quoting variables and its less intuitive logical operators for combined conditions. Forgetting to quote can lead to subtle bugs that are hard to trace. `[[ ]]` and `(( ))` address these shortcomings, making your code safer and often more readable for Bash-specific scripting.

---

### 🎯 When to Use What? (Summary)

* **For Numeric Comparisons (integers)**: Use `(( num > 10 ))`. (Modern, C-style operators, no `$` for variables).
* **For String Comparisons, File Tests, Regex**: Use `[[ "$name" == "Alice" ]]` or `[[ -f "$file" ]]`. (Modern, safer, more features).
* **If you must use `[ ]` (for old scripts or POSIX compatibility)**: Then you use `-eq`, `-ne`, `-gt`, `-ge`, `-lt`, `-le` for numbers, and `=`, `!=` for strings. **ALWAYS quote your variables!**

Hopefully, this fully clarifies where `-lt`, `-gt`, and their friends fit in, and why the distinction between `[ ]`, `[[ ]]`, and `(( ))` is so important!

---

### 🎉 Keep Going!

You're mastering the art of decision-making in Bash. Understanding these conditional structures is a huge step forward in writing dynamic and useful scripts!


## some string realted things 
## 🔤 String Operators
Expression	    Meaning	                     Example
-z "$str"	    True if string is empty	    [[ -z "$name" ]]
-n "$str"	    True if string is not empty	[[ -n "$input" ]]
"$a" = "$b"	    Strings are equal	        [[ "$user" = "admin" ]]
"$a" != "$b"	Strings are not equal	    [[ "$choice" != "yes" ]]