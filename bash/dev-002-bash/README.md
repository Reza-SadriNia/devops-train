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
> **_NOTE:_** $TRY_INTERVAL and $TRY_NUMBER values ​​are received from the command line, and if they are not received from the command line, they are received from the environment variables. And if it is not received from the environment variables, the default values ​​are used in the program.