recomemded reading:
 
- Cramer, C. J. Essentials of Computational Chemistry: Theories and Models; John
Wiley & Sons, 2004; Chapter 8.

##Implementation of DFT in VASP

VASP can perform methods other than DFT, but here we focus only on the DFT Implementation.

The *Hohenberg–Kohn Existence Theorem* and *Hohenberg–Kohn Variational Theorem* proved that it is possible to construct the Hamiltonian, and in turn the wavefunction, solely based on electron density, $n(r)$. Constructing the Hamiltonian in terms of density does not alleviate the Schrödinger equations centrosymmetry issue, though, as the electron-electron interaction has simply been redifned. So a further condition is required. The additional condition is to approximate our system of interest as a system of non-interacting electrons with the same overall density as the real system (this set of non-interacting electrons are the KS orbitals). KS orbitals are iteratively solved, returning lower energies until $n(r)KS=n(r)$ (Variational Theorem). Using this method the real density ($n(r)$) can been determined from one electron density functions *without approximation*. In VASP, we determine the calculation is complete when differences in $E[n(r)KS]$ are within `EDIFF`, or in other words, when $E[n(r)KS]$ is within `EDIFF` of $E[n(r)]$.

!!! note
    Approximations do eventually enter KS-DFT. Namely the correction to the kinetic energy deriving from the interacting nature of the electrons, and all non-classical corrections to the electron–electron repulsion energy. The exchange-correlation functional ($E_{XC}$) deals with these terms, which we choose with the `GGA` tag in the `INCAR`.

VASPs main task is to solve the Kohn-Sham (KS) one electron orbitals of our system according to the eigenvalue equation below:

\begin{equation}
H^{ks}\psi_n(r)=\epsilon_n \psi_n(r)
\end{equation}

Where $H^{ks}$ is the effective Hamiltonian, $\psi_n(r)$ and $\epsilon_n$ are the wavefunction (eigenfunction) and energy (eigenvalue) of KS orbital $n$. The final KS wavefunction (final solution) is a single Slater determinant made of the set of orbitals that are the lowest-energy solutions to 

Because VASP is often used for bulk-like materials,         The projector-augmented-wave (PAW) methos is used 
