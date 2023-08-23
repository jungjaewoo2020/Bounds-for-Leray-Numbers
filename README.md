# Bounds-on-Leray-Numbers

This project was initiated to support the computations in our paper "Weak Eisenbud-Goto conjecture for Stanley-Reisner ideal," a joint work with Jinha Kim, Minki Kim, and Yeongrak Kim.

If you need assistance installing the computer software system "Macaulay2," please visit the webpage http://macaulay2.com/ and follow the provided instructions.

The project includes code written in Macaulay2 that consists of functions providing upper bounds on the Leray numbers of simplicial complexes. To use the codes, download the file "LerayBounds.m2," place it in the "codes" folder within your Macaulay2 directory, and execute the command 'load "LerayBounds.m2"' in Macaulay2.

The current version of the project offers the following codes for obtaining upper bounds on the Leray numbers of simplicial complexes within the "LerayBounds.m2" file:
- "strBoundwOrder (List)" yields the value $M$ as specified in the paper, providing an upper bound on the Leray numbers of a simplicial complex based on a given linear order of facets (as a list).
- "strBound (SimplicialComplex)" yields the value $M$ as an upper bound on the Leray numbers of a simplicial complex.
- "strBoundFacets (SimplicialComplex)" produces lists of facet orderings for which the bounds on the Leray number match those of the complex.
- "connBoundwOrder (List)" yields the value $N$ as mentioned in the paper, offering an upper bound on the Leray numbers of a simplicial complex based on a given linear order of facets (as a list).
- "connBound (SimplicialComplex)" yields the value $N$ as an upper bound on the Leray numbers of a simplicial complex.
- "connBoundFacets (SimplicialComplex)" provides lists of facet orderings for which the bounds on the Leray number match those of the complex.
- "weakShellwOrder (List)" returns a Boolean value: it outputs "true" if the complex has a weak shelling and "false" if there is no weak shelling.
- "weakShelling (SimplicialComplex)" provides a weak shelling of the complex. If the complex is not weak-shellable, an empty list is displayed.
- "isWeakShellable (SimplicialComplex)" produces a Boolean value: "true" if the complex is weak shellable, and "false" if it is not.
- "weakShellFacets (SimplicialComplex)" provides a list of facet orderings that constitute a weak shelling of the complex.
- "minOrder (SimplicialComplex)" determines a facet order such that the facets are maximally intersected at each step while adding facets along the facet order.

In the "examples.m2" file, we have provided some tested examples.
