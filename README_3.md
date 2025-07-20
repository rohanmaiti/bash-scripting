
## 🔁 Lesson 5: Loops in Bash - `for` and `while` Loops

### Part 1: The `for` Loop

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
