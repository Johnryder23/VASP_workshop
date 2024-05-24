# Improving VASP efficiency on NeSI platforms

## Learning goals
Many of you are experienced VASP users, and have been using the programme for some time. As VASP evolves and more features become available, however, it is easy to carry on with the same workflows and neglect new release features. It is important we optimise our VASP calculations because  VASP users **use the most core hours on NeSI, more than any other programme!**. In the last year

- understand parallelisation options of VASP and how to quickly optimize them for your problem
- Explore machine learning capability of VASP
- accelerate your VASP calculations using NeSI's GPUs.
- 

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
