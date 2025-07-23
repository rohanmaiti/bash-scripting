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
