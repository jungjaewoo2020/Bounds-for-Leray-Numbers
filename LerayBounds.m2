needsPackage "SimplicialComplexes"
connBoundwOrder = method()
connBoundwOrder List := ZZ => OrderedFacets -> (
    Conn := for i from 1 to #OrderedFacets-1 list (
        ListConn := for j from 0 to i-1 list (
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
            Conn := for i from 1 to #SelectedOrder-1 list (
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
    Mvalues := for k from 0 to #OrdersList-1 list (
        LerayBound := 1;
        SelectedOrder := OrdersList#k;
        MvalueList := for i from 1 to #SelectedOrder-1 list (
            Intersections := apply(i, j -> gcd(SelectedOrder#j,SelectedOrder#i));
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
    StructuralBound := for k from 0 to #OrdersList - 1 list (
        LerayBound := 1;
        SelectedOrder := OrdersList#k;
        MvalueList := for i from 1 to #SelectedOrder-1 list (
            Intersections := apply(i, j -> gcd(SelectedOrder#j,SelectedOrder#i));
            if #facets simplicialComplex Intersections == 1 then LerayBound = LerayBound else LerayBound = LerayBound + 1
        );
        last MvalueList
    );
    StructuralLerayBound := min StructuralBound;
    StrBoundList := for l from 0 to #OrdersList - 1 list (
        if StructuralBound#l == StructuralLerayBound then OrdersList#l
    );
    delete(null,StrBoundList)
)
weakShellwOrder = method ()
weakShellwOrder List := (Boolean,List) => OrderedFacets -> (
    WeakShells := for i from 1 to #OrderedFacets-1 list (
        Intersections = for j from 0 to i-1 list (
            gcd (OrderedFacets#j,OrderedFacets#i)
        );
        ComInt := simplicialComplex Intersections;
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
        WeakShells := for i from 1 to #SelectedOrder-1 list (
            Intersections := for j from 0 to i-1 list (
                gcd (SelectedOrder#j,SelectedOrder#i)
            );
            ComInt := simplicialComplex Intersections;
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
    weakShellList := for k from 0 to #OrdersList-1 list (
        SelectedOrder = OrdersList#k;
        WeakShells = for i from 1 to #SelectedOrder-1 list (
            Intersections = for j from 0 to i-1 list (
                gcd (SelectedOrder#j,SelectedOrder#i)
            );
            IntCom := simplicialComplex Intersections;
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
            int := for j from 0 to #leftFacets - 1 list(simplicialComplex for k from 0 to #facetOrders - 1 list(gcd(facetOrders#k,leftFacets#j)));
            intdeg := for l from 0 to #int - 1 list(
                if facets int#l == facets simplicialComplex{1_(ring int#l)} then continue 0
                else (fVector int#l)#1);
            facetOrders = append(facetOrders, for m from 0 to #int - 1 list(if intdeg#m == max intdeg then break leftFacets#m))
        );
    last const
)
