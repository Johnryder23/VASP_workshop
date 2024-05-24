This repository hosts the content of the 'Using resources effectively with VASP: exploring GPU and machine learning capability' workshop run by NeSI.

Following instructions are for maintainers only, not for attendees.

First, install [MkDocs](https://www.mkdocs.org/) and other dependencies in a Python virtual environment:

## How to contribure to this workshop material

Commits to the 'main' branch are deployed automatically at https://johnryder23.github.io/VASP_workshop/ .

If you would like to make your own edits and deploy them, create a new branch and install MkDocs in a Python virtual environment:
```
python3 -m venv venv
. venv/bin/activate
pip install mkdocs
```

Once your virtual environment is ready, compile a local version of the workshop material using:

```
mkdocs serve
```

and open your web browser at the address returned by the command.
