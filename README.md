This repository hosts the content of Using resources effectively with VASP: exploring GPU and machine learning capability.

Workshop atendees can follow along with the material deployed using GitHub Pages, [here](https://johnryder23.github.io/VASP_workshop/).  

The only other material needed are the scripts located in in the `./content` directory of this repository. Simply clone this repo (with `git clone git@github.com:Johnryder23/VASP_workshop.git`) and the navigate into `VASP_workshop/content`. The rest of the nessessary configurations are provided by the host machine, Mahuika.


## If you would like to contribute to this workshop

If you would like to contribute to this workshop please create a branch and submit pull request to `main`. The `main` branch is deployed automatically at https://johnryder23.github.io/VASP_workshop/ .

If you want to build a local version the only required python packages are `mkdocs` and `mkdocs-material`:
```
python3 -m venv venv
. venv/bin/activate
pip install mkdocs
pip install mkdocs-material
```
Once your virtual environment is ready, compile a local version of the workshop material using:
```
mkdocs serve
```
and open your web browser at the address returned by the command.
