# MacOS dot-files

```bash
brew install stow \
    fd \
    just
fd -t d -x echo | tr -d './' | xargs stow
```
