# Bounds-on-Leray-Numbers

This project is started to support the computations on our paper "Weak Eisenbud-Goto conjecture for Stanley-Reisner ideal" joint work with Jinha Kim, Minki Kim, and Yeongrak Kim.

If you need some assistance to install the computer software system "Macaulay2", see the webpage http://macaulay2.com/ and follow their instructions.

This project contains some codes on Macaulay2 of functions that gives a upper bounds on Leray numbers of the simplicial complex.

We currently provide the following codes for upper bounds on Leray number of the simplicial complexes in "LerayBounds.m2".
- "strBoundwOrder (List)" provides the value $\tilde{M}$ for an upper bound on Leray numbers of a simplicial complex given the linear order of facets (in the list).
- "strBound (SimplicialComplex)" provides the value $\tilde{M}$ for an upper bound on Leray numbers of a simplicial complex.
- "strBoundFacets (SimplicialComplex)" provides the lists of facet orderings that gives the upper bound on the Leray number of the simplicial complex.
- "connBoundwOrder (List)" provides the value $M$ for an upper bound on Leray numbers of a simplicial complex given the linear order of facets (in the list).
- "connBound (SimplicialComplex)" provides the value $M$ for an upper bound on Leray numbers of a simplicial complex.
- "connBoundFacets (SimplicialComplex)" provides the lists of facet orderings that gives the upper bound on the Leray number of the simplicial complex.

In "examples.m2", we provide some examples that we have tested.
