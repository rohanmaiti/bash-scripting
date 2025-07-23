# 📖 Shell Scripting Basics

Hey there, future scripter! Ready to dive into the world of shell scripting? This guide will walk you through some fundamental concepts, making sure you grasp the "why" behind every command. Let's get started!

---

## 🚀 Lesson 1: Your First Script - "Hello, World!"

Every journey begins with a single step, and in coding, that step is usually "Hello, World!".

```bash
#!/bin/bash
echo "Hello, world!"
```

---

### 🤔 What's with the `#!` and `/bin/bash`?

Ever wondered what that mysterious first line means?

* **`#!` is called a `shebang`**. Think of it as a special instruction for your operating system.
* It tells the operating system **which interpreter to use** to run the script. Without it, your system might just guess, and sometimes it guesses wrong!
* **/bin/bash** is the **path to the Bash shell**. This ensures your script runs specifically with Bash, guaranteeing consistent behavior. Imagine if your script was written for a specific language, but the computer tried to run it with another – it wouldn't make sense, right? The `shebang` prevents that confusion.

---

### ▶️ How to Run Your Script

Got your script ready? Let's make it executable and run it!

1.  **Make the script executable:**
    ```bash
    chmod +x hello.sh
    ```
    This command grants your script the permission to be run as a program. It's like giving it the "go-ahead" to perform its actions.

2.  **Run the script in your terminal:**
    ```bash
    ./hello.sh
    ```
    The `./` simply tells your terminal to look for the script in the **current directory**.

You should see this glorious output:

```
Hello, world!
```

---

## 🤝 Lesson 2: Variables & User Input (`read`)

Scripts become much more powerful when they can interact with you! Let's learn how to take input and store it.

```bash
#!/bin/bash

echo "Enter your name:"
read name
echo "Hello, $name!"
```

---

### 🔍 Explanation: `read` and `$`

* `read name`: This command does exactly what it says: it **reads input from you** (the user) and **stores it in a variable named `name`**.
* `$name`: When you see a variable with a `$` in front of it (like `$name`), it means you are **accessing the value** stored inside that variable. It's like saying, "Hey Bash, give me whatever is inside `name`!"

---

## ➕ Lesson 3: Basic Arithmetic

Time to do some number crunching! Bash makes basic arithmetic surprisingly straightforward.

```bash
#!/bin/bash

a=5
b=3
sum=$((a + b))
echo "Sum is: $sum"
```

---

### 🤯 Understanding `$(())`

This special syntax is your go-to for arithmetic operations in Bash. Let's break it down:

* **`((...))`**: The inner double parentheses create an **arithmetic context**. Inside these, Bash treats expressions as mathematical operations. You can use standard operators like `+` (addition), `-` (subtraction), `*` (multiplication), `/` (division), `%` (modulo), `**` (exponentiation), and even comparison operators (like `==`, `!=`, `<`, `>`).
    * **Pro-tip**: Variables inside `((...))` **do not need to be prefixed with `$`**! Bash is smart enough to know you're referring to their values.

* **`$`**: The outer `$` is for **command substitution**. It captures the numerical **result** of the arithmetic evaluation inside `((...))` and substitutes it into your command line.

**Example:**

```bash
a=5
b=3
sum=$((a + b)) # 5 + 3 = 8
echo "Sum is: $sum" # Output: Sum is: 8
```
Here, `a + b` is evaluated as arithmetic inside `((...))`, giving `8`. The `$` then captures this `8` and substitutes it, so `sum` gets assigned the value `8`. Simple, right?

---

### 🧐 What if you use `$(...)` or just `((...))`?

This is where it can get a little tricky, but understanding the nuances will make you a Bash pro!

#### 1. `$(...)` (Single Parentheses with a Dollar Sign)

This is a **general command substitution**. Whatever is inside the parentheses is **executed as a command**, and its standard output is captured and substituted into the command line.

**Example:**

```bash
current_date=$(date) # Executes the 'date' command and captures its output
echo "Today's date is: $current_date"

result=$(echo "Hello World") # Executes 'echo "Hello World"' and captures "Hello World"
echo $result
```

**What happens if you try arithmetic directly with `$(...)`?**

```bash
a=5
b=3
sum=$(a + b) # This would try to execute 'a + b' as a command, which will fail!
              # Bash would look for a command named 'a' and then try to interpret '+ b'
              # as arguments to 'a'.
```
You'd likely get an error like "command not found: a". See the difference? `$(...)` runs commands, `$(())` does math!

#### 2. `((...))` (Only Double Parentheses without a Dollar Sign)

When used alone, `((...))` **evaluates the arithmetic expression**, but it **does not substitute the result**. Instead, it typically returns an **exit status** based on the result:

* If the arithmetic evaluation results in a **non-zero value**, the exit status is `0` (success).
* If the arithmetic evaluation results in a **zero value**, the exit status is `1` (failure).

This is primarily useful for **conditional checks** in `if` statements or `while` loops, or for **modifying variables directly**.

**Example 1: Using `((...))` for conditional logic**

```bash
a=5
b=3

if (( a > b )); then # 5 > 3 is true (non-zero result), so exit status is 0
    echo "a is greater than b"
fi

c=10
d=10

if (( c == d )); then # 10 == 10 is true (non-zero result), so exit status is 0
    echo "c is equal to d"
fi

x=0
if (( x )); then # x is 0, so exit status is 1 (failure)
    echo "This won't be printed"
else
    echo "x is zero"
fi
```

**Example 2: Arithmetic with `((...))` (but not storing the result)**

```bash
a=5
b=3
(( a += b )) # This will add b to a, so 'a' becomes 8.
              # The result of the addition itself isn't captured for substitution,
              # but the variable 'a' is modified.
echo "New value of a: $a" # Output: New value of a: 8
```

---

### 📝 Summary of Arithmetic Syntaxes in Bash

To recap, here are your main options for arithmetic:

* **`$((expression))`**: **Recommended for arithmetic expansion**. Evaluates `expression` as an integer arithmetic operation and substitutes the numerical result. Variables inside `expression` **do not need `$`**.
    ```bash
    result=$((10 + 5))
    echo $result # 15
    ```

* **`((expression))`**: Used for **arithmetic evaluation**, often in conditionals or for side effects on variables. Evaluates `expression` as integer arithmetic. Sets an exit status (`0` for non-zero result, `1` for zero result). Variables inside `expression` **do not need `$`**.

    ```bash
    (( x++ )) # increments x
    if (( y > 0 )); then ... fi
    ```

* **`$(expr expression)` (Legacy/Alternative)**: You might sometimes see older scripts using `expr`. This is an **external command**, making it less efficient than `$(())`.

    ```bash
    result=$(expr 10 + 5)
    echo $result # 15
    ```

    **Note**: `expr` requires spaces around operators and variables *need* `$` (e.g., `expr $a + $b`).

* **`$[expression]` (Deprecated)**: This is an older, deprecated form of arithmetic expansion and **should be avoided** in new scripts.

    ```bash
    # result=$[10 + 5] # Avoid this!
    ```

---

### 🤔 What does "substitute" mean anyway?

In shell scripting, **"substitute"** means to **replace one piece of text with another piece of text** *before* the command is actually executed.

Think of it like Bash reading your script. When it encounters something special (like `$`, `$(...)`, or `$(())`), it pauses, calculates a value or fetches some content, and then **replaces the original special construct with that new value/content**. *Only after all these replacements are done* does Bash finally try to execute the command.

Let's use your example:

```bash
a=5
b=3
sum=$((a + b))
```

Here's the step-by-step process of **substitution** for the line `sum=$((a + b))`:

1.  **Bash sees `sum=`**: It knows an assignment is coming.

2.  **Bash sees `$(...)`**: It recognizes this as a command substitution (specifically, an arithmetic expansion here). It needs to figure out what value to put inside.

3.  **Bash evaluates `((a + b))`**:

    * It looks up `a` (which is `5`).

    * It looks up `b` (which is `3`).

    * It performs the arithmetic: `5 + 3`, which results in `8`.

4.  **The `$` captures the result `8`**: This `8` is now the value that will be substituted.

5.  **Substitution occurs**: The entire `$((a + b))` part is **removed** from the command line, and `8` is **inserted** in its place.

6.  **Final command line (after substitution)**: The line effectively becomes:

    ```bash
    sum=8
    ```

7.  **Assignment**: Now Bash performs the assignment: the value `8` is assigned to the variable `sum`.

So, "substitute" means that the `$(())` expression is **replaced by its calculated numerical value** *before* the assignment actually takes place. It's a preprocessing step!

---

### ❌ Does "substitute" mean to assign?

**Not directly!** Substitution is a step that often happens *before* an assignment. The *result* of the substitution is what gets assigned.

---

### 🚫 What if I write `sum=((...))`?

If you write `sum=((a + b))`, it **won't work** as you expect for assigning the sum.

```bash
a=5
b=3
sum=((a + b)) # This will NOT assign '8' to sum
echo "Sum is: $sum"
```

**Why doesn't it work?**

1.  **`sum=`**: Bash sees an assignment.

2.  **`((a + b))`**: Bash evaluates this arithmetic expression. `a + b` (which is `5 + 3`) results in `8`.

3.  **Exit Status**: The `((...))` construct itself **doesn't output the result to standard output**. Instead, its primary function when used alone is to set an **exit status**. Since `8` is a non-zero value, the `((a + b))` expression evaluates successfully, and its exit status is `0`.

4.  **No Substitution**: Crucially, there's **no leading `$` for command substitution**. So, Bash doesn't replace `((a + b))` with `8`. It just evaluates it and then moves on.

What gets assigned to `sum`? Nothing from the `((...))` directly. If you run `sum=((a+b))` and then `echo "$sum"`, you'll likely see an **empty line**, or perhaps `0` if it's the first assignment and Bash initializes it. The main purpose of `((...))` without `$` is for its side effects (like `((a++)))` or its exit status for conditional logic.

---

## 🚦 Lesson 4: If Statements - Making Decisions

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

You will primarily encounter and `use -lt`, `-gt`, `-eq`, etc., when working with:

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

## 🔁 Lesson 5: Loops in Bash - `for` and `while` Loops

Loops are fundamental control structures that allow your script to execute a block of commands repeatedly, automating tasks efficiently.

### Part 1: The `for` Loop

A `for` loop is primarily used for iterating over a collection of items or for performing a set of commands a specific number of times using a counter.

#### 1. `for` Loop: Iterating Over a List (Most Common & Recommended)

This type of `for` loop processes each item in a given list, executing the loop's commands once per item.

**Syntax:**

```bash
for variable_name in item1 item2 item3 ...; do
    # Commands to execute for each item
    # Inside the loop, '$variable_name' will hold the current item
done
```

**Key Points:**

* `variable_name`: Defines the variable that will temporarily hold the value of the current item during each iteration.
* `in item1 item2 ...`: Specifies the list of items to iterate over. These can be literal words, shell wildcards (globs), command substitution, or array elements.
* `do` and `done` are mandatory and define the loop's body.
* **Quoting `$variable_name`**: Always quote `"$variable_name"` when using it within the loop's commands, especially if the items might contain spaces or special characters (like filenames or user input). This prevents unexpected word splitting or globbing issues.

**Examples:**

* **Simple List:**
    ```bash
    #!/bin/bash
    echo "--- Favorite Desserts ---"
    for dessert in cake pie ice_cream "chocolate bar"; do # "chocolate bar" is quoted as it has a space
        echo "I really enjoy $dessert."
    done
    echo "-------------------------"
    ```

* **Files (Globbing):**
    ```bash
    # Create dummy files for demonstration
    mkdir -p project/docs project/src
    touch project/docs/report.txt project/docs/notes.md project/docs/image.png
    touch project/src/main.sh project/src/helper_01.sh project/src/data_A.sh
    touch project/temp.log project/config.txt

    echo "--- All items in 'project/' ---"
    for item in project/*; do # Iterates over all files/directories directly under 'project/'
        echo "Found: $item"
    done

    echo "--- Specific shell scripts in 'project/src/' ---"
    for script in project/src/*_?.sh; do # Matches helper_01.sh, data_A.sh
        echo "Script with pattern: $script"
    done

    # Clean up dummy files
    rm -rf project # Removes the project directory and its contents
    ```

* **Command Output:**
    ```bash
    # Iterates over the first 3 usernames from /etc/passwd
    for user in $(cut -d: -f1 /etc/passwd | head -n 3); do
        echo "User: $user"
    done
    ```

#### 2. `for` Loop: C-style Numeric Loop (Bash-specific)

This loop works like traditional `for` loops in programming languages (C, Java, Python), using an initializer, a condition, and an incrementer. Ideal for looping a fixed number of times.

**Syntax:**

```bash
for (( initializer; condition; incrementer )); do
    # Commands to execute
done
```

**Key Points:**

* Uses the `(( ... ))` arithmetic context.
* Variables inside `((...))` do **NOT** need the `$` prefix (e.g., `i++` is correct, not `$i++`).
* Uses standard C-style arithmetic and comparison operators (`+`, `-`, `*`, `/`, `%`, `==`, `!=`, `>`, `<`, `>=`, `<=`, `&&`, `||`).

**Examples:**

* **Count Up:**
    ```bash
    #!/bin/bash
    echo "--- C-style Count Up ---"
    for (( i=1; i<=5; i++ )); do
        echo "Current count: $i"
    done
    ```

* **Count Down with Custom Step:**
    ```bash
    #!/bin/bash
    echo "--- Countdown by Twos ---"
    for (( k=10; k>=0; k-=2 )); do
        echo "Decreasing: $k"
    done
    ```

### Part 2: The `while` Loop

A `while` loop repeatedly executes a block of commands as long as a given condition remains true. It's perfect for situations where you don't know the exact number of iterations beforehand, like reading a file line by line or waiting for a certain event.

**Syntax:**

```bash
while condition_to_test; do
    # Commands to execute repeatedly
done
```

**Key Points:**

* The loop continues as long as `condition_to_test` returns `0` (true).
* You **must ensure the condition eventually becomes false**, otherwise you'll have an **infinite loop** (which can be stopped with `Ctrl+C`). This usually involves modifying a variable within the loop.
* `do` and `done` are mandatory.
* The same conditional constructs (`((...))`, `[[...]]`, `[ ]`) that you use in `if` statements can be used as the `condition_to_test` in `while` loops.

**Examples:**

* **Simple Counter:**
    ```bash
    #!/bin/bash
    echo "--- While Loop Counter ---"
    count=1 # Initialize the counter
    while (( count <= 3 )); do # Condition: loop while count is 3 or less
        echo "Count: $count"
        (( count++ )) # Increment the counter (crucial to avoid infinite loop)
    done
    ```

* **Reading a File Line by Line (Common Use Case):**
    ```bash
    #!/bin/bash
    # Create a dummy file for the example
    echo -e "apple\nbanana\norange" > fruits.txt

    echo "--- Reading fruits.txt ---"
    # 'read' command reads a line, and returns exit status 0 (true) if successful
    while IFS= read -r fruit_name; do # IFS= read -r is best practice for reading lines
        echo "Found fruit: $fruit_name"
    done < fruits.txt # Redirect fruits.txt as input to the while loop

    # Clean up
    rm -f fruits.txt
    ```
    * **Explanation of `while IFS= read -r fruit_name`:**
        * `IFS=`: Temporarily unsets the Internal Field Separator. This prevents `read` from splitting lines by spaces/tabs and preserves leading/trailing whitespace.
        * `read -r`: Reads one line from standard input. `-r` (raw) prevents backslash escapes from being interpreted.
        * `fruit_name`: The variable where the read line will be stored.
        * The `read` command itself returns an exit status: `0` (true) on successful read, non-`0` (false) on End-Of-File (EOF) or error. This makes it perfect as a `while` loop condition.

* **Waiting for a File to Appear:**
    ```bash
    #!/bin/bash
    echo "--- Waiting for 'trigger.txt' to appear ---"
    file="trigger.txt"
    while [[ ! -f "$file" ]]; do # Loop while file DOES NOT exist (! is logical NOT)
        echo "File '$file' not found yet. Waiting..."
        sleep 2 # Wait for 2 seconds before checking again
    done
    echo "File '$file' found! Proceeding..."

    # Clean up (assuming another process would create it, we'll remove it here for testing)
    rm -f "$file"
    ```
    * **Explanation:**
        * `[[ ! -f "$file" ]]`: The condition checks if the file does NOT (`!`) exist as a regular file (`-f`).
        * `sleep 2`: Pauses the script for 2 seconds. In a real scenario, another process or user would create `trigger.txt`.

---

### 🎉 Keep Going!

You're now equipped to automate tasks and create more dynamic scripts using loops. Onwards to the next challenge!

---

## 📦 Lesson 6: Arrays and Associative Arrays in Bash

Arrays allow you to store multiple values under a single variable name. Bash supports two types of arrays:

* **Indexed Arrays**: Values are accessed using numeric indices (starting from 0).
* **Associative Arrays**: Values are accessed using string keys (like a dictionary or hash map in other languages).

### Part 1: Indexed Arrays

Indexed arrays are the most common type. Each element in the array is identified by a numerical index, starting from 0.

#### 1. Declaration and Initialization

You don't always need to explicitly declare an array, but it's good practice.

* **a) Declare empty array:**

    ```bash
    declare -a my_array
    # Or simply: my_array=() (this is more common and implies indexed array)
    ```

* **b) Initialize with values (on one line):**

    ```bash
    my_array=(value0 value1 "value with space" value3)
    #   Index:    0       1          2              3
    ```
    Values are separated by spaces. If a value contains spaces, it must be enclosed in quotes.

* **c) Assigning values to specific indices:**

    ```bash
    my_array[0]="first element"
    my_array[1]="second element"
    my_array[5]="sixth element (skips 2, 3, 4)" # You can skip indices
    ```

#### 2. Accessing Array Elements

To retrieve the value of an element, use the syntax `${array_name[index]}`.

```bash
my_array=(apple banana "kiwi fruit" orange)
echo "First fruit: ${my_array[0]}"    # Output: First fruit: apple
echo "Third fruit: ${my_array[2]}"    # Output: Third fruit: kiwi fruit

# Accessing a non-existent index returns nothing (empty string)
echo "Non-existent: ${my_array[99]}" # Output: Non-existent:
```

#### 3. Accessing All Array Elements

To get all elements of an array, use `${array_name[@]}` or `${array_name[*]}`.

* **`${array_name[@]}` (RECOMMENDED)**: Expands each element into a separate word, preserving spaces within elements. This is crucial for `for` loops.
* **`${array_name[*]}`**: Expands all elements into a single word, separated by the first character of `IFS` (Internal Field Separator, usually space). Less common and can be problematic.

```bash
my_array=(red green "light blue" yellow)
echo "All elements (separate words): ${my_array[@]}"
# Output: All elements (separate words): red green light blue yellow

# Loop through all elements (common and correct way)
echo "--- Looping through elements ---"
for color in "${my_array[@]}"; do # CRITICAL: Quote "${my_array[@]}" to handle spaces
    echo "Color: $color"
done
# Output:
# Color: red
# Color: green
# Color: light blue
# Color: yellow
```

#### 4. Getting Array Length (Number of Elements)

Use `${#array_name[@]}` or `${#array_name[*]}` to get the count of elements. Both work similarly for length.

```bash
my_array=(cat dog bird fish)
echo "Number of animals: ${#my_array[@]}" # Output: Number of animals: 4
```

#### 5. Getting Length of a Specific Element

Use `${#array_name[index]}`.

```bash
my_array=(cat dog bird fish)
echo "Length of first animal name: ${#my_array[0]}" # Output: Length of first animal name: 3 (for "cat")
```

#### 6. Adding Elements

You can append elements or add them at specific indices.

```bash
my_array=(apple banana)
my_array+=(cherry grape) # Append new elements
echo "Appended: ${my_array[@]}" # Output: Appended: apple banana cherry grape

my_array[4]="mango" # Add at a specific index
echo "Added at index 4: ${my_array[@]}" # Output: Added at index 4: apple banana cherry grape mango
```

#### 7. Removing Elements

Use `unset` to remove specific elements or the entire array.

```bash
my_array=(a b c d e)
unset my_array[2] # Remove element at index 2 (c)
echo "After unset index 2: ${my_array[@]}" # Output: After unset index 2: a b d e (index 2 is now empty/null)

unset my_array     # Remove the entire array
echo "After unset array: ${my_array[@]}" # Output: (empty line)
```
**Note:** When you `unset` an element in the middle, the indices don't "shift" down. That index just becomes empty.

### Part 2: Associative Arrays (Bash 4+ Specific)

Associative arrays (also called hash maps or dictionaries) store key-value pairs, where the keys are strings instead of numbers.

**Requirement:** Associative arrays require Bash version 4.0 or newer.

#### 1. Declaration

You must explicitly declare an associative array using `declare -A`.

```bash
declare -A my_assoc_array
```

#### 2. Initialization and Assignment

```bash
declare -A colors
colors=(
    [red]="#FF0000"
    [green]="#00FF00"
    [blue]="#0000FF"
    [yellow]="#FFFF00"
)

# Assigning individual elements
my_assoc_array["name"]="Alice"
my_assoc_array["age"]=30
my_assoc_array["city"]="New York"
```
Keys must be enclosed in `[ ]`. Values must be enclosed in quotes if they contain spaces.

#### 3. Accessing Elements

Access elements using the key: `${array_name[key]}`.

```bash
declare -A user_info
user_info["name"]="Bob"
user_info["email"]="bob@example.com"
user_info["status"]="active"

echo "User name: ${user_info["name"]}"   # Output: User name: Bob
echo "User email: ${user_info["email"]}" # Output: User email: bob@example.com
```

#### 4. Accessing All Keys or All Values

* **All Keys**: `${!array_name[@]}` or `${!array_name[*]}`
* **All Values**: `${array_name[@]}` or `${array_name[*]}` (same as indexed arrays)

```bash
declare -A capitals
capitals[France]="Paris"
capitals[Germany]="Berlin"
capitals[Japan]="Tokyo"

echo "All keys (countries): ${!capitals[@]}" # Output: All keys (countries): France Germany Japan (order not guaranteed)
echo "All values (cities): ${capitals[@]}" # Output: All values (cities): Paris Berlin Tokyo (order not guaranteed)

# Looping through keys and values
echo "--- Capitals ---"
for country in "${!capitals[@]}"; do
    city="${capitals[$country]}"
    echo "The capital of $country is $city."
done
# Output (order may vary):
# The capital of France is Paris.
# The capital of Germany is Berlin.
# The capital of Japan is Tokyo.
```

#### 5. Getting Length (Number of Key-Value Pairs)

Use `${#array_name[@]}` or `${#array_name[*]}`.

```bash
echo "Number of countries stored: ${#capitals[@]}" # Output: Number of countries stored: 3
```

#### 6. Removing Elements

Use `unset` to remove specific key-value pairs or the entire array.

```bash
unset capitals[Germany] # Remove the "Germany" entry
echo "After removing Germany: ${!capitals[@]}" # Output: After removing Germany: France Japan

unset capitals # Remove the entire associative array
```

**Key Takeaways for Arrays:**

* **Indexed Arrays (`my_array=(...)`)**: Use for ordered lists where elements are accessed by number (0, 1, 2...).
    * Access all elements with `"${my_array[@]}"` (always quote!).
* **Associative Arrays (`declare -A my_assoc_array`)**: Use for key-value pairs where elements are accessed by string names.
    * Requires `declare -A`.
    * Access all keys with `"${!my_assoc_array[@]}"`.
    * Access all values with `"${my_assoc_array[@]}"`.
* `unset` for removal.
* `${#array[@]}` for size.
* `${#array[index]}` for element string length.

Arrays are extremely useful for managing collections of data in your Bash scripts!

---

## ⚙️ Lesson 7: Functions in Bash

Functions allow you to group a set of commands together and give them a name. You can then "call" (execute) these commands simply by referring to the function's name.

### 1. Function Definition Syntax

There are two main ways to define a function in Bash, both are equivalent in most modern Bash versions:

* **a) `function` keyword syntax (Recommended for clarity):**

    ```bash
    function function_name {
        # Commands to be executed when the function is called
        # ...
    }
    ```

* **b) POSIX-compatible syntax (Older, but more widely compatible across shells):**

    ```bash
    function_name () {
        # Commands to be executed when the function is called
        # ...
    }
    ```
    * `function_name`: The name you choose for your function.
    * `{ ... }`: The curly braces enclose the body of the function (the commands it executes).
    * **Important**: The opening curly brace `{` must be on the same line as the function name or on the next line, but if it's on the same line, there must be a space after the function name or parentheses. The closing curly brace `}` must be on its own line or preceded by a semicolon.

### 2. Calling a Function

Once a function is defined, you call it just like any other command:

```bash
function_name argument1 argument2 ...
```

### 3. Function Arguments

Functions in Bash don't declare arguments explicitly by name. Instead, they access arguments passed to them using special positional parameters, similar to how a script accesses its own arguments:

* `$1`, `$2`, `$3`, ...: Represent the first, second, third, etc., arguments passed to the function.
* `$@`: Represents all arguments passed to the function, as separate words (recommended when iterating).
* `$*`: Represents all arguments passed to the function, as a single word (less common, can cause issues with spaces).
* `$#`: Represents the number of arguments passed to the function.

**Example 1: Simple Function with Arguments**

```bash
#!/bin/bash

# Function definition using 'function' keyword
function greet_user {
    echo "Hello, $1!"            # Accesses the first argument
    echo "You provided $# arguments." # Accesses the number of arguments
}

# Call the function
greet_user "Alice"
greet_user "Bob" "Smith" # Bob is $1, Smith is $2
greet_user "Charlie" "Delta" "Echo"

echo "--- Using all arguments ---"
function display_args {
    echo "All arguments received: $@" # All arguments as separate words
    echo "First argument: $1"
    echo "Number of arguments: $#"
    echo "--- Looping through arguments ---"
    for arg in "$@"; do # Always quote "$@" when looping!
        echo "Argument: $arg"
    done
}

display_args "apple pie" 123 "another arg"
```

### 4. Return Values (Exit Status)

Functions in Bash don't "return" values in the traditional sense like in C or Python. Instead, they typically return an exit status (an integer between 0 and 255).

* `return N`: Sets the exit status of the function to `N`. `0` usually indicates success, and non-zero indicates failure.
* The exit status of the last command executed within the function also becomes the function's exit status if `return` is not explicitly used.
* You can access the exit status of the last executed command (including a function call) using `$?`.

If you want a function to "return" a string or a more complex data type, you should:

* `echo` the value, and then capture it using command substitution (`$()`) when calling the function.
* Assign a value to a global variable (less recommended for large scripts due to potential side effects).

**Example 2: Function Return Values**

```bash
#!/bin/bash

# Function that returns an exit status
function check_number {
    local num=$1 # Use 'local' for variables inside functions!
    if (( num % 2 == 0 )); then
        echo "$num is even."
        return 0 # Success
    else
        echo "$num is odd."
        return 1 # Failure
    fi
}

echo "--- Checking Numbers ---"
check_number 10
status=$? # Capture the exit status
echo "Status for 10: $status"

check_number 7
status=$?
echo "Status for 7: $status"

echo "--- Function returning a string ---"
function get_current_date {
    date +"%Y-%m-%d %H:%M:%S" # This command's output will be the "return value"
}

current_datetime=$(get_current_date) # Capture the output using command substitution
echo "Current date and time: $current_datetime"
```

### 5. Variable Scope (`local` keyword)

By default, any variable you define inside a function is a **global variable**, meaning it's accessible outside the function. This can lead to unexpected side effects if your function accidentally overwrites a variable with the same name elsewhere in your script.

To prevent this, use the `local` keyword to declare variables within a function. `local` variables are only accessible within that function (and any functions it calls).

**Example 3: Variable Scope**

```bash
#!/bin/bash

global_var="I am a global variable."

function demonstrate_scope {
    local func_var="I am a local variable." # Declared as local
    global_var="I was changed inside the function!" # This modifies the global variable

    echo "Inside function:"
    echo "  Local var: $func_var"
    echo "  Global var: $global_var"
}

echo "Before function call:"
echo "  Global var: $global_var"
# echo "  Local var: $func_var" # This would cause an error as func_var is not defined globally

demonstrate_scope

echo "After function call:"
echo "  Global var: $global_var" # Shows the changed value
# echo "  Local var: $func_var" # Still an error, func_var only existed inside the function
```

**Key Takeaways for Functions:**

* Define with `function name { ... }` or `name () { ... }`.
* Call like a command: `name arg1 arg2`.
* Access arguments inside: `$1`, `$2`, `$@`, `$#`.
* Return exit status with `return N` (0 for success, non-zero for failure).
* "Return" strings by echoing and capturing with `$(function_name)`.
* **ALWAYS use `local` for variables declared within functions** to prevent accidental global variable modification. This is a crucial best practice for writing robust scripts.

Functions are incredibly powerful for modularizing your Bash scripts, making them easier to read, debug, and reuse.


## 🚦 Lesson 10: `case` Statement - Multi-way Branching

The `case` statement provides a multi-way branching mechanism. It compares a single value (typically a variable's content) against several patterns and executes a block of commands for the first pattern that matches. It's often cleaner and more efficient than a long chain of `if/elif/else` statements for string comparisons.

### ✅ Syntax:

```bash
case $variable_to_check in
  pattern1)
    # Commands to execute if $variable_to_check matches pattern1
    ;;
  pattern2 | pattern3) # Multiple patterns separated by | (OR)
    # Commands to execute if $variable_to_check matches pattern2 OR pattern3
    ;;
  pattern*) # Wildcard pattern (globbing)
    # Commands for patterns starting with "pattern"
    ;;
  *) # Default case (matches anything else)
    # Commands for when no other pattern matches
    ;;
esac # MANDATORY: Closes the case statement (case spelled backward)
```

**Key Elements:**

* `case $variable_to_check in`: Initiates the `case` statement. The value of `$variable_to_check` is what will be compared against the patterns.
* `pattern)`: Each pattern to match against. This is where the globbing patterns (like `*`, `?`, `[]`) are very useful.
* `commands`: The block of commands to execute if the pattern matches.
* `;;`: **Crucial!** This terminates a block of commands for a given pattern. Once a match is found and its commands are executed, `;;` ensures the script exits the `case` statement entirely and continues after `esac`. Without it, Bash would "fall through" and try to match the next pattern (though this behavior can be altered for advanced uses, it's rare and discouraged for beginners).
* `esac`: **MANDATORY!** Marks the end of the `case` statement (`case` spelled backward).

### 🧠 What’s happening (Detailed):

* **Expression Evaluation**: The `case` statement first evaluates the expression following `case` (e.g., `$fruit` or `$1`).
* **Pattern Matching**: It then sequentially compares the result of that expression against each pattern.
* **First Match Wins**: The commands associated with the first matching pattern are executed.
* **No Fall-Through (by default)**: Once a pattern matches and its commands are executed, the `;;` terminates that block, and control immediately jumps to the command after the `esac`. This is different from `switch` statements in C-like languages where `break` is often required to prevent "fall-through."
* **Default Case**: The `*)` pattern acts as a wildcard, matching anything. It's typically placed last to serve as a default or "catch-all" condition.

### 🧪 Example 1: Basic Fruit Matching

```bash
#!/bin/bash
echo "Enter a fruit name:"
read fruit

case $fruit in
  apple)
    echo "Apples are red or green."
    ;;
  banana)
    echo "Bananas are yellow."
    ;;
  mango)
    echo "Mango is the king of fruits!"
    ;;
  *) # Default case if no other matches
    echo "Unknown fruit! Please try apple, banana, or mango."
    ;;
esac
echo "--- Fruit check complete ---"
```
**How it works:**

* If you type `apple`, it matches `apple)`, executes `echo "Apples are red or green."`, then `;;` exits the `case`.
* If you type `orange`, it won't match `apple`, `banana`, or `mango`. It will then match `*)`, execute `echo "Unknown fruit!"`, and exit.

### ✅ Case With Multiple Patterns (OR condition)

You can specify multiple patterns for a single block of commands using the `|` (pipe) symbol, which acts as a logical OR.

```bash
#!/bin/bash
read -p "Enter a letter: " letter

case $letter in
  [aeiouAEIOU]) # Matches any lowercase or uppercase vowel
    echo "It's a vowel."
    ;;
  [a-zA-Z]) # Matches any lowercase or uppercase letter (which aren't vowels, due to order)
    echo "It's a consonant."
    ;;
  [0-9]) # Matches any digit
    echo "It's a digit."
    ;;
  *) # Default case for anything else
    echo "Not an alphabet or digit. Please enter a letter or number."
    ;;
esac
echo "--- Letter check complete ---"
```
**Important Note on Order:** `case` statements evaluate patterns sequentially. The first match wins. In the example above, if you enter `a`, it matches `[aeiouAEIOU]` first. It will never reach `[a-zA-Z]` for `a` because it already matched. This is often the desired behavior for specific conditions first, then broader ones.

### ✅ Case With Wildcard Patterns (Globbing in Patterns)

This is where `case` statements truly shine, as they natively support shell globbing patterns.

```bash
#!/bin/bash
echo "Enter a filename (e.g., report.txt, image.jpg, data.csv):"
read filename

case $filename in
  *.txt | *.md) # Matches any file ending with .txt or .md
    echo "This looks like a text document."
    echo "You might want to view it with 'cat' or 'less'."
    ;;
  *.jpg | *.png | *.gif) # Matches common image file extensions
    echo "This is an image file."
    echo "You could open it with an image viewer."
    ;;
  data_*.csv) # Matches files starting with 'data_' and ending with '.csv'
    echo "This is a CSV data file."
    echo "Consider importing it into a spreadsheet."
    ;;
  [Rr]eadme | [Ll][Ii][Cc][Ee][Nn][Cc][Ee]*) # Matches "Readme" or "readme", "License" or "license" etc.
    echo "This is likely an important project file."
    ;;
  *)
    echo "Unknown file type or pattern."
    ;;
esac
echo "--- File type check complete ---"
```

### ✅ Case With Command-Line Arguments (`$1`, `$2`, etc.)

`case` statements are frequently used to parse command-line arguments in scripts, creating simple command interfaces.

```bash
#!/bin/bash
# $0 is the name of the script itself
# $1 is the first argument passed to the script (e.g., 'start' in './myscript.sh start')

case $1 in
  start)
    echo "Service: Starting up..."
    # Add commands to start your service here
    ;;
  stop)
    echo "Service: Shutting down..."
    # Add commands to stop your service here
    ;;
  restart)
    echo "Service: Restarting..."
    # Add commands to restart your service here (often stop then start)
    ;;
  status)
    echo "Service: Checking status..."
    # Add commands to check service status
    ;;
  '') # Matches if $1 is empty (no argument provided)
    echo "No command provided. Please specify an action."
    echo "Usage: $0 {start|stop|restart|status}"
    ;;
  *) # Default for any other invalid argument
    echo "Unknown command: '$1'."
    echo "Usage: $0 {start|stop|restart|status}"
    ;;
esac
echo "--- Script execution complete ---"
```
**How to run this example:**

```bash
./your_script_name.sh start
./your_script_name.sh stop
./your_script_name.sh status
./your_script_name.sh # No argument provided
./your_script_name.sh foo # Invalid argument
```

### Key Takeaways for `case` Statements:

* **Pattern Matching**: Great for matching a variable's value against various string patterns.
* **No Fall-Through**: By default, `;;` ensures only the first matching block executes, then the `case` statement is exited.
* **Globbing Support**: Patterns naturally use shell wildcards (`*`, `?`, `[]`), making them powerful for flexible matching.
* **Multiple Patterns (`|`)**: Use `|` for an OR condition to match multiple patterns to the same block of commands.
* **Order Matters**: Patterns are evaluated from top to bottom; the first match wins. Place more specific patterns before more general ones.
* **Default `*)`**: Always include a `*)` at the end for a default or "catch-all" case.
* `esac`: Don't forget to close with `esac`!

The `case` statement is a very elegant and readable alternative to complex `if/elif/else` structures for dispatching actions based on string values.
