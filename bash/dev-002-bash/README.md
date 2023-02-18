# simple-retry-script

A simple script to retry any command with specified switches.

## How to use:

```bash
Usage: $0 [OPTIONS] COMMAND
Options:
    -n              : Number of tries.
    -i              : Interval second.
```

### Example:

```bash
  $0 COMMAND
  $0 -i 3 COMMAND
  $0 -i 3 -n 2 COMMAND
```
