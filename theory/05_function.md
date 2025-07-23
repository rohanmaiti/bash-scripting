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
