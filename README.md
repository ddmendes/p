# P
Path shortcuts manager

## Instalation

Just clone the repo somewhere and source `p.sh` into your shell rc (~/.zshrc or
~/.bashrc or whatever you use).

```sh
cd <script_install_location>
git clone git@github.com:ddmendes/p.git
echo "source <script_install_location>/p/p.sh" >> ~/.zshrc
```

The script will keep it's data in `~/.pdata.properties`. If you want to change
it export `P_PROPERTIES_FILE` with new file location and name.

```sh
export P_PROPERTIES_FILE="<script_install_location>/p/.pdata.properties"
```

## Usage

```sh
p set <alias> <path>
p list [<alias>]
p rm <alias>
p <alias>
```

## Commands

* **set:** Stores (add or edit) a shortcut for directory <path> with key <alias>.
* **list:** If no alias is given list all known alias=path. If alias is given list according path.
* **rm:** Remove an alias.
* **\<alias\>:** Change working directory to respective path for the given alias.

## Contribute

Feel free to open a PR, file a bug or just request a feature.