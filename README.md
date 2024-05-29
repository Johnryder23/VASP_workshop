This repository hosts the content of Using resources effectively with VASP: exploring GPU and machine learning capability.

Workshop atendees can follow along with the material deployed using GitHub Pages, [here](https://johnryder23.github.io/VASP_workshop/).  

The only other material needed are the scripts located in in the `./content` directory of this repository. Simply clone this repo (with `git clone git@github.com:Johnryder23/VASP_workshop.git`) and the navigate into `VASP_workshop/content`. The rest of the nessessary configurations are provided by the host machine, Mahuika.


## If you would like to contribute to this workshop

Commits to the `main` branch are deployed automatically at https://johnryder23.github.io/VASP_workshop/ .

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
