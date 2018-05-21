# Dotfiles
This repository has my dotfiles and some config files.

# Setup dotfiles
Exectute all:
`./setup.sh`

Execute interactively:
`./setup.sh -i`

# Setup my_script.sh
You can prepare files for each environment that are not tracked by git.
If you prepare a file called my_script.sh, .bash_profile will read it.

# Setup config files
## terminal
Preferences > Import
Import a `./terminal/my-profile-city-lights-based.terminal`

## tmux
Before you start, you need to install tpm.

cf. [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)

## vscode
Copy and paste your snippets files.
`vscode/snippets/**.json`

## vimium
Vimium Options > Custom key mappings
Copy and paste from `vimium/custom_key_mappings.txt`

## iterm2
### Save a preferences settings to directory
Preferences > General > Load prefences from a custom folder or URL 
                      > Save changes to folder when iTerms2 quits  Save Current Settings to Folde

### Use a preferences settings 
Copy a preferences setting file to ~/Library/Preferences/com.googlecode.iterm2.plist

### Use a color presets
Preferences > Profiles > Colors > Color Presets... > Import...
