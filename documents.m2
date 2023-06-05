    -* Documentation section *-
     beginDocumentation()

     doc ///
     Key
       LerayBounds
     Headline
        Bounds for Leray numbers of simplicial complexes
     Description
       Text
            {\em LerayBounds} is a package providing bounds on Leray numbers of simplicial complex.
            The codes are available in "LerayBounds.m2".
       Tree
       Example
       CannedExample
     Acknowledgement
     Contributors
     References
     Caveat
        This package will be loaded together with the package "SimplicialComplexes".
     SeeAlso
     Subnodes
     ///

     doc ///
     Key
        strBoundwOrder(List)
     Headline
        strBoundwOrder(List) -- an upper bound on Leray number of a simplicial complex with respect to given facet ordering. 
     Usage
        strBoundwOrder L
     Inputs
        L, an ordered list of facets
     Outputs
        integer that is a bound on Leray number of simplicial complex with respect to the ordering of facets.
     Consequences
       Item
     Description
       Text
        \em{strBoundwOrder} provides the value for an upper bound on Leray numbers of a simplicial complex given the linear order of facets (in the list).
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        strBound(SimplicialComplex)
     Headline
        strBound(SimplicialComplex) -- an upper bound on Leray number of a simplicial complex.
     Usage
        strBound G
     Inputs
        G, a simplicial complex
     Outputs
        an integer that is a bound on Leray number of simplicial complex.
     Consequences
       Item
     Description
       Text
        \em{strBound} provides the value for an upper bound on Leray numbers of a simplicial complex.
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
     Headline
        strBoundFacets(SimplicialComplex) -- make list of facet order that gives the upper bound on the Leray number of a simplicial complex.
     Usage
        strBoundFacets G
     Inputs
     Outputs
        the list of facets with orderings which gives the value $\tilde{M}$.
     Consequences
       Item
     Description
       Text
        \em{strBoundFacets} provides the lists of facet orderings that gives the upper bound on the Leray number of the simplicial complex.
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        connBoundwOrder(List)
     Headline
        connBoundwOrder(List) -- a bound on Leray number of simplicial complex with respect to given facet ordering.
     Usage
        connBoundwOrder L
     Inputs
        L, a list, an ordered list of facets.
     Outputs
        an integer that gives a bound on the leray number of the simplicial complex with respect to the ordered list.
     Consequences
       Item
     Description
       Text
        \em{connBoundwOrder} provides the value for an upper bound on Leray numbers of a simplicial complex given the linear order of facets in the list.  
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        connBound(SimplicialComplex)
     Headline
        connBound(SimplicialComplex) -- a bound on Leray number of simplicial complex
     Usage
        connBound G
     Inputs
        G, a simplicial complex 
     Outputs
        an integer that is a bound on the leray number of the simplicial complex.
     Consequences
       Item
     Description
       Text
        \em{connBound} provides the value for an upper bound on Leray numbers of a simplicial complex by using connectivity of the simplicial complex.
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        connBoundFacets(SimplicialComplexes)
     Headline
        connBoundFacets(SimplicialComplexes) -- make a list of orders that gives same bound on Leray number of a complex obtained from the connectivity.
     Usage
        connBoundFacets G
     Inputs
        G, a simplicial complex
     Outputs
        ordered list of facets that gives the value for bounds on the Leray number.
     Consequences
       Item
     Description
       Text
        \em{connBoundFacets} provides the lists of facet orderings that gives the upper bound on the Leray number of the simplicial complex.
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        weakShellwOrder(List)
     Headline
        weakShellwOrder(List)
     Usage
        weakShellwOrder L
     Inputs
        L, an ordered list of facets
     Outputs
        Boolean value. True if the order is an weak shelling and false if it is not a weak shelling of the complex.
     Consequences
       Item
     Description
       Text
        \em{weakShellwOrder} provides a Boolean value: the output is true if it is a weak shelling of the complex and false if it is not a weak shelling of the complex.
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        weakShelling(SimplicialComplex)
     Headline
        weakShelling(SimplicialComplex) -- make a weak shelling of a simplicial complex.
     Usage
        weakShelling G
     Inputs
        G, a simplicial complex
     Outputs
        A list that is a weak shelling of a simplicial complex
     Consequences
       Item
     Description
       Text
        \em{weakShelling} provides a weak shelling of the complex. If it is not weak shellable, it prints the empty list. 
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        isWeakShellable(SimplicialComplex)
     Headline
        isWeakShellable(SimplicialComplex) -- determine whether a simplicial complex is weak shallable.
     Usage
        isWeakShellable G
     Inputs
        G, a simplicial complex
     Outputs
        A Boolean value. True if the complex is weak shellable and False if it is not weak shellable.
     Consequences
       Item
     Description
       Text
        \em{isWeakShellable} provides a boolean value: "true" is printed if it is weak shellable and "false" is printed if it is not weak shellable. 
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        weakShellFacets(SimplicialComplex)
     Headline
        weakShellFacets(SimplicialComplex)
     Usage
        weakShellFacets G
     Inputs
        G, a simplicial complex
     Outputs
        The list of ordered facets that are weak shellings of the complex
     Consequences
       Item
     Description
       Text
        "weakShellFacets (SimplicialComplex)" provides the list of facet orderings that are weak shelling of the complex.
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///

     doc ///
     Key
        minOrder(SimplicialComplex)
     Headline
        minOrder(SimplicialComplex) -- make an order of facets that may give minimum of bounds on Leray number of a simplicial complex.
     Usage
        minOrder G
     Inputs
        G, a simplicial Complex
     Outputs
        An ordered list of facets
     Consequences
       Item
     Description
       Text
        \em{minOrder} produces an order of facets of a simplicial complex that may give minimum of bounds on Leray number of a simplicial complex. \em{minOrder} order the facets so that (1) the facet of largest size will come first and (2) we add facets such that intersections of facets in the list is as large as possible.
       Example
       CannedExample
       Code
       Pre
     ExampleFiles
     Contributors
     References
     Caveat
     SeeAlso
     ///
