---
name: jq-cli
description: Use jq to parse, filter, transform, and format JSON data from the terminal. Essential for processing API responses and structured data.
---

# jq

Lightweight command-line JSON processor. Parse, filter, map, and transform JSON.

- **Official repo:** https://github.com/jqlang/jq
- **Docs:** https://jqlang.github.io/jq/manual/

## Basic Syntax

```bash
echo '{"name":"John"}' | jq '.'              # Pretty-print
echo '{"name":"John"}' | jq '.name'          # Extract field
echo '{"name":"John"}' | jq -r '.name'       # Raw string (no quotes)
cat data.json | jq '.items[0]'               # First array element
cat data.json | jq '.items | length'         # Array length
```

## Common Patterns

### Object Access
```bash
jq '.user.name'                               # Nested field
jq '.user.name // "default"'                  # Default value if null
jq '{name: .user.name, id: .user.id}'         # Construct new object
jq 'keys'                                     # Get object keys
jq 'to_entries'                               # Convert to key-value pairs
```

### Array Operations
```bash
jq '.[0]'                                     # First element
jq '.[-1]'                                    # Last element
jq '.[2:5]'                                   # Slice
jq '.[] | .name'                              # Map over array, extract name
jq '[.[] | .name]'                            # Collect results into array
jq 'map(.name)'                               # Shorthand for above
jq 'map(select(.age > 30))'                   # Filter array
jq 'sort_by(.name)'                           # Sort by field
jq 'group_by(.category)'                      # Group by field
jq 'unique_by(.id)'                           # Deduplicate
jq 'first'                                    # First element
jq '[limit(5; .[])]'                          # Take first 5
```

### Filtering
```bash
jq '.[] | select(.status == "active")'        # Filter objects
jq '.[] | select(.name | test("^A"))'         # Regex filter
jq '.[] | select(.count > 10)'                # Numeric filter
jq '.[] | select(.tags | contains(["beta"]))' # Array contains
```

### Transformation
```bash
jq '.[] | {name, email}'                      # Select specific fields
jq '.items | map({id, title: .name})'         # Rename fields
jq '[.[] | . + {processed: true}]'            # Add field to all objects
jq '.[] | del(.password)'                     # Remove field
jq '.items | map(.price) | add'               # Sum values
jq '[.[] | .amount] | add / length'           # Average
```

### String Operations
```bash
jq -r '.[] | "\(.name): \(.email)"'           # String interpolation
jq '.name | ascii_downcase'                    # Lowercase
jq '.name | split(" ")'                        # Split string
jq '[.[] | .name] | join(", ")'               # Join array to string
```

### Input/Output
```bash
jq -r '.[] | [.name, .email] | @csv'          # Output as CSV
jq -r '.[] | @tsv'                             # Output as TSV
jq -r '@html'                                  # HTML escape
jq -r '@uri'                                   # URL encode
jq -s '.'                                      # Slurp multiple inputs into array
jq -c '.'                                      # Compact output (one line)
```

## Agent Best Practices

- Use `-r` (raw output) when the result is a string you want to use
- Use `-e` (exit status) for conditional checks: `jq -e '.error' && echo "has error"`
- Use `-c` for compact output when piping to other tools
- Use `-s` (slurp) to combine multiple JSON inputs into one array
- Use `//` for default values to handle null fields gracefully
- Chain filters with `|` for complex transformations
- Use `@base64d` to decode base64 values in JSON

## Example Workflows

### Parse API response
```bash
curl -s https://api.example.com/users | jq '[.data[] | {id, name, email}]'
```

### Transform and filter
```bash
cat orders.json | jq '[.[] | select(.total > 100) | {id, customer: .user.name, total}] | sort_by(-.total)'
```
