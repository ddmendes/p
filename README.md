# P
Path shortcuts manager

## Usage:

```sh
    p set <alias> <path>
    p list [<alias>]
    p rm <alias>
    p <alias>
```

## Commands:

* **set:** Stores (add or edit) a shortcut for directory <path> with key <alias>.
* **list:** If no alias is given list all known alias=path. If alias is given list according path.
* **rm:** Remove an alias.
* **\<alias\>:** Change working directory to respective path for the given alias.