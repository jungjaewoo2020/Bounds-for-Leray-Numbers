newPackage("LerayBounds",
         Version => "0.0.1",
         Date => "June 3, 2023",
         Headline => "A package for bounds on Leray numbers of simplicial complexes",
         Authors => {{ 
            Name => "Jaewoo Jung",
            Email => "jungjaewoo2010@gmail.com",
            HomePage => "https://sites.google.com/view/jaewoojung/home"}},
         AuxiliaryFiles => false,
         DebuggingMode => false
)
export {
    "connBoundwOrder",
    "connBound",
    "connBoundFacets",
    "strBoundwOrder",
    "strBound",
    "strBoundFacets",
    "weakShellwOrder",
    "weakShelling",
    "isWeakShellable",
    "minOrder"
}
 -* Code section *-
needsPackage "SimplicialComplexes"
connBoundwOrder = method()
connBoundwOrder List := ZZ => OrderedFacets -> (
    Conn = for i from 1 to #OrderedFacets-1 list (
        ListConn = for j from 0 to i-1 list (
            first(degree OrderedFacets#i) - first degree gcd(OrderedFacets#j,OrderedFacets#i) - 1
        );
        min ListConn
    );
    #OrderedFacets - #faces(0,simplicialComplex OrderedFacets) + first degree OrderedFacets#0 + sum Conn
)
connBound = method()
connBound SimplicialComplex := ZZ => Complex -> (
    Facets := facets Complex;
    OrdersList := permutations Facets;
    ConnBoundsLists := for k from 0 to #OrdersList - 1 list (
            SelectedOrder := OrdersList#k; 
            Conn := for i from 1 to #SelectedOrder-1 list (
                ConnList := for j from 0 to i-1 list (
                    first(degree SelectedOrder#i) - first degree gcd(SelectedOrder#j,SelectedOrder#i) - 1
                );
            min ConnList
        );
        #SelectedOrder - #faces(0,simplicialComplex SelectedOrder) + first degree SelectedOrder#0 + sum Conn    
    );
    min ConnBoundsLists
)
connBoundFacets = method()
connBoundFacets SimplicialComplex := List => Complex -> (
    Facets := facets Complex;
    OrdersList := permutations Facets;
    ConnBoundLists := for k from 0 to #OrdersList - 1 list (
            SelectedOrder := OrdersList#k;
            Conn:= for i from 1 to #OrdersList-1 list (
                ConnList := for j from 0 to i-1 list (
                    first(degree SelectedOrder#i) - first degree gcd(SelectedOrder#j,SelectedOrder#i) - 1
                );
            min ConnList
        );
        #Facets - #faces(0,simplicialComplex Facets) + first degree Facets#0 + sum Conn   
    );
    ConnBound := min ConnBoundLists;
    ConnboundList := for l from 0 to #OrdersList - 1 list (
    if ConnBoundLists#l == ConnBound then OrdersList#l
    );
    delete(null,ConnboundList)
)
strBoundwOrder = method()
strBoundwOrder List := ZZ => OrderedFacets -> (
    LerayBound := 1;
    MvalueList := for i from 1 to #OrderedFacets-1 list (
        Intersections := apply(i, j -> gcd(OrderedFacets#j,OrderedFacets#i));
        if #facets simplicialComplex Intersections == 1 then LerayBound = LerayBound else LerayBound = LerayBound + 1
    );
    last MvalueList
)
strBound = method()
strBound SimplicialComplex := ZZ => Complex -> (
    Facets := facets Complex;
    OrdersList := permutations Facets;
    Mvalues = for k from 0 to #OrdersList-1 list (
        LerayBound := 1;
        SelectedOrder = OrdersList#k;
        MvalueList = for i from 1 to #SelectedOrder-1 list (
            Intersections = apply(i, j -> gcd(SelectedOrder#j,SelectedOrder#i));
            if #facets simplicialComplex Intersections == 1 then LerayBound = LerayBound else LerayBound = LerayBound + 1
        );
        last MvalueList
    );
    min Mvalues
)
strBoundFacets = method()
strBoundFacets SimplicialComplex := List => Complex -> (
    Facets := facets Complex;
    OrdersList := permutations Facets;
    StructuralBound = for k from 0 to #OrdersList - 1 list (
        LerayBound = 1;
        SelectedOrder = OrdersList#k;
        MvalueList = for i from 1 to #SelectedOrder-1 list (
            Intersections = apply(i, j -> gcd(SelectedOrder#j,SelectedOrder#i));
            if #facets simplicialComplex Intersections == 1 then LerayBound = LerayBound else LerayBound = LerayBound + 1
        );
        last MvalueList
    );
    StructuralLerayBound := min StructuralBound
    StrBoundList = for l from 0 to #OrdersList - 1 list (
        if StructuralBound#l == StructuralLerayBound then OrdersList#l
    );
    delete(null,StrBoundList)
)
weakShellwOrder = method ()
weakShellwOrder List := (Boolean,List) => OrderedFacets -> (
    WeakShells = for i from 1 to #OrderedFacets-1 list (
        Intersections = for j from 0 to i-1 list (
            gcd (OrderedFacets#j,OrderedFacets#i)
        );
        ComInt = simplicialComplex Intersections;
        if #faces(0,ComInt) > dim ComInt + 2 then break; OrderedFacets#i
    );
    if prepend(OrderedFacets#0,WeakShells) == OrderedFacets then return (true, prepend(OrderedFacets#0,WeakShells)) else return(false, {null})
)
weakShelling = method ()
weakShelling SimplicialComplex := List => Complex -> (
    Facets := facets Complex;
    OrdersList := permutations Facets;
    for k from 0 to #OrdersList-1 do (
        SelectedOrder = OrdersList#k;
        WeakShells = for i from 1 to #SelectedOrder-1 list (
            Intersections = for j from 0 to i-1 list (
                gcd (SelectedOrder#j,SelectedOrder#i)
            );
            ComInt = simplicialComplex Intersections;
            if #faces(0,ComInt) > dim ComInt + 2 then break; SelectedOrder#i
        );
        if prepend(SelectedOrder#0,WeakShells) == SelectedOrder then break SelectedOrder else return {null}   
    )
)

isWeakShellable = method ()
isWeakShellable SimplicialComplex := Boolean => Complex -> (
    WeakShelling := weakShelling Complex;
    if #WeakShelling == #(facets Complex) then true else false
)

weakShellFacets = method ()
weakShellFacets SimplicialComplex := List => Complex -> (
    Facets := facets Complex;
    OrdersList := permutations Facets;
    weakShellList = for k from 0 to #OrdersList-1 list (
        SelectedOrder = OrdersList#k;
        WeakShells = for i from 1 to #SelectedOrder-1 list (
            Intersections = for j from 0 to i-1 list (
                gcd (SelectedOrder#j,SelectedOrder#i)
            );
            IntCom = simplicialComplex Intersections;
            if #faces(0,IntCom) > dim IntCom + 2 then break; SelectedOrder#i
        );
        if prepend(SelectedOrder#0,WeakShells) == SelectedOrder then SelectedOrder else null   
    );
    delete(null,weakShellList)
)

minOrder = method ()
minOrder SimplicialComplex := List => Complex -> (
    leftFacets := facets Complex;
    facetOrders := {last facets Complex};
    const := for i from 0 to #leftFacets - 2 list(
            leftFacets = delete(last facetOrders, leftFacets);
            int = for j from 0 to #leftFacets - 1 list(simplicialComplex for k from 0 to #facetOrders - 1 list(gcd(facetOrders#k,leftFacets#j)));
            intdeg = for l from 0 to #int - 1 list(
                if facets int#l == facets simplicialComplex{1_(ring int#l)} then continue 0
                else (fVector int#l)#1);
            facetOrders = append(facetOrders, for m from 0 to #int - 1 list(if intdeg#m == max intdeg then break leftFacets#m))
        );
    last const
)

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


-* Test section *-
TEST ///
R = QQ[x_1..x_6];
G = simplicialComplex {x_1*x_2*x_4,x_1*x_3*x_5,x_2*x_3*x_6,x_4*x_5*x_6};
L = facets G;
L = minOrder G
strBoundwOrder L
strBound G
strBoundFacets G
connBoundwOrder L
connBound G
connBoundFacets G

R = QQ[x_1..x_8];
G = simplicialComplex {x_1*x_2*x_3*x_5,x_1*x_3*x_5*x_6,x_1*x_3*x_4*x_6,x_1*x_4*x_6*x_7,x_1*x_2*x_4*x_7,x_3*x_4*x_6*x_8,x_2*x_3*x_4*x_8};
L = facets G;
MinL = minOrder G;
strBoundwOrder L
strBoundwOrder MinL
strBound G
strBoundFacets G
connBoundwOrder L
connBoundwOrder MinL
connBound G
connBoundFacets G///
end

-* Development section *-
restart
debug needsPackage "LerayBounds"
check "LerayBounds"

uninstallPackage "LerayBounds"
restart
installPackage "LerayBounds"
viewHelp "LerayBounds"

