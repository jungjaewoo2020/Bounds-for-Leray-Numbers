-- PRESETS
loadPackage "SimplicialComplexes"

-- A function that bounds the regularity of a square-free monomial ideal
-- INPUT: a list of facets with ordering
-- OUTPUT: the value that gives a bound for the leray number of the simplicial complex with respect to the 
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

-- A function that bounds the regularity of a square-free monomial ideal
-- INPUT: a simplicial complex
-- OUTPUT: the value that gives a bound for the leray number of the simplicial complex
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

-- CODE: find the list of facets with orderings that gives the value for bounds on the Leray number.
-- INPUT: the simplicial complex
-- OUTPUT: the list of facets with orderings which gives the value for bounds on the Leray number.
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

-- The function $M$ of the simplicial complex $\Delta$ given order of facets
-- INPUT: the list of facets with ordering on facets
-- OUTPUT: the integer $\tilde M$ with respect to the ordering of facets. 
strBoundwOrder = method()
strBoundwOrder List := ZZ => OrderedFacets -> (
    LerayBound := 1;
    MvalueList := for i from 1 to #OrderedFacets-1 list (
        Intersections := apply(i, j -> gcd(OrderedFacets#j,OrderedFacets#i));
        if #facets simplicialComplex Intersections == 1 then LerayBound = LerayBound else LerayBound = LerayBound + 1
    );
    last MvalueList
)

-- The function $\tilde M$ of the simplicial complex $\Delta$
-- INPUT: the list of facets
-- OUTPUT: the integer $\tilde M$.
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

-- Find the list of facets with orderings that gives the value $\tilde{M}$.
-- INPUT: the list of facets
-- OUTPUT: the list of facets with orderings which gives the value $\tilde{M}$.
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


-- CODE: Weak shelling of a simplicial complex with ordering of facets
-- INPUT: The list of facets of a simplicial complex
-- OUTPUT: A Boolean value and an ordered facets that is a weak shelling of the complex
weakShellwOrder = method ()
weakShellwOrder List := (Boolean,List) => OrderedFacets -> (
    WeakShells = for i from 1 to #OrderedFacets-1 list (
        Intersections = for j from 0 to i-1 list (
            gcd (OrderedFacets#j,OrderedFacets#i)
        );
        ComInt = simplicialComplex Intersections;
        if #faces(0,ComInt) > dim ComInt + 2 then break; OrderedFacets#i
    );
    if prepend(OrderedFacets#0,WeakShells) == OrderedFacets then return (true, prepend(OrderedFacets#0,WeakShells)) else return(false, null)
)


-- CODE: A weak shelling of a simplicial complex
-- INPUT: A simplicial complex
-- OUTPUT: A weak shelling of a simplicial complex
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
        if prepend(SelectedOrder#0,WeakShells) == SelectedOrder then break SelectedOrder else null   
    )
)

-- CODE: Determine Weak shellable of a simplicial complex
-- INPUT: A simplicial complex
-- OUTPUT: Boolean value
isWeakShellable = method ()
isWeakShellable SimplicialComplex := Boolean => Complex -> (
    Facets := facets Complex;
    OrdersList := permutations Facets;
    Shelling = for k from 0 to #OrdersList-1 do (
        SelectedOrder := OrdersList#k;
        WeakShells = for i from 1 to #SelectedOrder-1 list (
            Intersections = for j from 0 to i-1 list (
                gcd (SelectedOrder#j,SelectedOrder#i)
            );
            IntCom = simplicialComplex Intersections;
            if #faces(0,IntCom) > dim IntCom + 2 then break; SelectedOrder#i
        );
        if prepend(SelectedOrder#0,WeakShells) == SelectedOrder then break SelectedOrder else null   
    );
    if #Shelling == #SelectedOrder then true else "notWeakShellable"
)

-- CODE: The list of ordered facets that is a weak shelling with respect the facet orders
-- INPUT: A simplicial complex
-- OUTPUT: The list of ordered facets that are weak shellings of the complex
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

-- The order that minimize the bounds of the Leray number with respect to the connectivity.
-- INPUT: A simplicial Complex
-- OUTPUT: An (ordered) list of facets
minConnOrder = method()
minConnOrder SimplicialComplex := List => G -> (
    L := facets G;
    weights := flatten for i from 0 to #L-2 list(
                for j from i+1 to #L-1 list(
                (degree gcd(L#i,L#j))_0
                )
        );
    edges := flatten for i from 0 to #L-2 list(
                for j from i+1 to #L-1 list({L#i,L#j})
        );
    maxW := max weights;
    orders := for l from 0 to maxW - 1 list(
            unique flatten for k from 0 to binomial(#L,2) - 1 list (
                            if weights#k < maxW - l  then continue
                            else edges#k)
            );
    for m from 0 to #orders - 1 list (if #L == #orders#m then break orders#m)
) 

-- The order that minimize the bounds of the Leray number.
-- INPUT: A simplicial Complex
-- OUTPUT: An (ordered) list of facets
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


TEST ///
R = QQ[x_1..x_6];
G = simplicialComplex {x_1*x_2*x_4,x_1*x_3*x_5,x_2*x_3*x_6,x_4*x_5*x_6};
L = facets G;
strBoundwOrder L
strBound G
strBoundFacets G
connBoundwOrder L
connBound G
connBoundFacets G
///
end

restart
load "LerayBounds.m2"
