# Intermediate topics for VASP users on NeSI

## Learning goals
Many of you are experienced VASP users, and have been using the programme for some time. As VASP evolves and more features become available, however, it is easy to carry on with the same workflows and neglect new release features. It is important we optimise our VASP calculations because  VASP users **use the most core hours on NeSI, more than any other programme!**. In the last year

- understand parallelisation options of VASP and how to quickly optimize them for your problem
- Explore machine learning capability of VASP
- accelerate your VASP calculations using NeSI's GPUs.
- ........

## The basics - VASP input files
VASP generally requires four input files
1. INCAR
The runtime settings file for VASP. Tells VASP what type of calculation you want to perform, and the parameters for it to run in.
2. KPOINTS
File specifying the **k** points density. **k** points are points at which the electronic structure is sampled in the Brillouin zone (*reciprocal* lattice of a crystalline material). More **k** points is required for systems with large fluctuations in electron density, as these fluctuations may otherwise be poorly described by corse grain sampling.
3. POTCAR
File containing the pseudopotential(s) for all atom(s). Order in which pseudopotentials are given must match the atom order in the `POSCAR`.
4. POSCAR
File specifying atomic coordinates. This file will not be update as the calculation proceeds, instead, updated atomic coordinates are printed to the `CONTCAR`.


!!! tip
    We can use ASEs sort utility to sort our `POSCAR` by atom type, and remove duplicates. This will make writing the `POTCAR` file much eaiser.
    ``` 
    #!/usr/bin/env python
    
    from ase.io import read
    import sys
    from ase.build import sort
    from ase.io import write
    
    input=read(str(sys.argv[1]))
    arrange=sort(input)
    write(str(sys.argv[1]),arrange,format="vasp")
    ```

## Workshop material structure
NOT UP-TO-DATE
```
$ tree
.
├── ethene_in_vacuum
│   ├── input
│   │   ├── INCAR
│   │   ├── KPOINTS
│   │   ├── POSCAR
│   │   ├── POTCAR
│   │   └── start.sh
│   ├── output
│   │   ├── CHG
│   │   ├── CHGCAR
│   │   ├── CONTCAR
│   │   ├── DOSCAR
│   │   ├── EIGENVAL
│   │   ├── IBZKPT
│   │   ├── OSZICAR
│   │   ├── OUTCAR
│   │   ├── PCDAT
│   │   ├── PROCAR
│   │   ├── REPORT
│   │   ├── vaspout.h5
│   │   ├── vasprun.xml
│   │   ├── WAVECAR
│   │   └── XDATCAR
│   └── README.md
├── GPU_calulation
│   ├── input
│   │   └── file
│   └── output
│       └── file
├── H2O_machine_learning_MD
│   ├── input
│   │   └── file
│   ├── output
│   │   └── file
│   └── run.sl
├── INCAR_orig
├── parallel_NEB
│   ├── input
│   │   └── file
│   └── output
│       └── file
├── README.md
└── very_parallel
    ├── input
    │   └── file
    └── output
        └── file

15 directories, 32 files
```
