# google-java-format hook for pre-commit
A handy [pre-commit](http://pre-commit.com/) hook which will run Google's java
code style formatter for you on your code!

Usage:

```
repos:
- repo: https://github.com/maltzj/google-style-precommit-hook
  sha: b7e9e7fcba4a5aea463e72fe9964c14877bd8130
    hooks:
      - id: google-style-java
        args: [-v1.15.0]
```

*Note*: this file stores Google's code style formatter jar in a `.cache/`
directory so that it doesn't need to be re-downloaded each time.  You will
probably want to add `.cache/` to the `.gitignore` file of the project which
uses this hook.

## Arguments
-v forces to use specific (default=1.15.0) google-java-format version. e.g. -v1.15.0