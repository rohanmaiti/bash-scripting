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

