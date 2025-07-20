## 📦 Lesson 4: Arrays and Associative Arrays in Bash

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
