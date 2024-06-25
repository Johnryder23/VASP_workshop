##Implementation of DFT in VASP

VASP can perform methods other than DFT, but here we focus only on the DFT Implementation.

The "Hohenberg–Kohn Existence Theorem" and "Hohenberg–Kohn Variational Theorem" proved that it is possible to construct the Hamiltonian, and in turn the wavefunction, solely based on electron density, $n(r)$. Constructing the Hamiltonian in terms of density does not alleviate the Schrödinger equations centrosymmetry issue, though, as the electron-electron interaction has simply been redifned. So a further condition is required. The additional condition is to approximate our system of interest as a system of non-interacting electrons with the same overall density as the real system (this set of non-interacting electrons are the KS orbitals). KS orbitals are iteratively solved, returning lower energies until $n(r)KS=n(r)$ (Variational Theorem). Using this method the real density ($n(r)$) can been determined from one electron density functions *without approximation*. In VASP, we determine the calculation is complete when differences in $E[n(r)KS]$ are within `EDIFF`, or in other words, when $E[n(r)KS]$ is within `EDIFF` of $E[n(r)]$.

VASPs main goal is solve the Kohn-Sham (KS) one electron orbitals of our system:

$$ H^{ks} \lambda_N{r} $$

Where $H^{ks}$ is the Hamiltonian  


