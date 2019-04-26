# touch with ~/Templates support

## Description

The plugin provides a touch like function supporting templates in `~/Templates`.

## Functions

`toucht` is a wrapper function around `touch` that uses existing templates in the `~/Templates` directory if possible.

Example: <br />
```
$ ls -R ~/Templates
~/Templates:
cpp_header.hpp  cpp_source.cpp  LaTex  python.py

~/Templates/LaTex:
article.tex  beamer.tex

$ toucht foo.txt    # Creates a new empty txt-file using touch
$ toucht bar.cpp    # Creates a new file with the content of the template file "cpp_source.cpp" using 'cp'
$ toucht baz.tex    # The user has to choose the correct template file from a selection dialog

Please select one of the following 2 templates for 'baz.tex':

  [0] beamer.tex
  [1] article.tex

Your choice:
```
