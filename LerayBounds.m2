-- PRESETS
loadPackage "SimplicialComplexes"

-- A function that bounds the regularity of a square-free monomial ideal
-- INPUT: a list of facets with ordering
-- OUTPUT: the value that gives a bound for the leray number of the simplicial complex with respect to the 
connBoundwOrder = method()
connBoundwOrder List := ZZ => L -> (
    J = for i from 1 to #L-1 list (
        K = for j from 0 to i-1 list (
           first(degree L#i) - first degree gcd(L#j,L#i) - 1
        );
        min K
    );
    #L - #faces(0,simplicialComplex L) + first degree L#0 + sum J
)

-- A function that bounds the regularity of a square-free monomial ideal
-- INPUT: a simplicial complex
-- OUTPUT: the value that gives a bound for the leray number of the simplicial complex
connBound = method()
connBound SimplicialComplex := ZZ => G -> (
    L := facets G;
    N := permutations L;
    J := for k from 0 to #N - 1 list (
            A := N#k; 
            K := for i from 1 to #L-1 list (
                M := for j from 0 to i-1 list (
                    first(degree A#i) - first degree gcd(A#j,A#i) - 1
                );
            min M
        );
        #A - #faces(0,simplicialComplex A) + first degree A#0 + sum K    
    );
    min J
)

-- CODE: find the list of facets with orderings that gives the value for bounds on the Leray number.
-- INPUT: the simplicial complex
-- OUTPUT: the list of facets with orderings which gives the value for bounds on the Leray number.
connBoundFacets = method()
connBoundFacets SimplicialComplex := ZZ => G -> (
    L := facets G;
    N := permutations L;
    J := for k from 0 to #N - 1 list (
            A := N#k;
            K := for i from 1 to #L-1 list (
                M := for j from 0 to i-1 list (
                    first(degree A#i) - first degree gcd(A#j,A#i) - 1
                );
            min M
        );
        #L - #faces(0,simplicialComplex L) + first degree L#0 + sum K    
    );
    O := for l from 0 to #J - 1 list (
    if J#l == min J then N#l
    );
    delete(null,O)
)

-- The function $\tilde M$ of the simplicial complex $\Delta$ given order of facets
-- INPUT: the list of facets with ordering on facets
-- OUTPUT: the integer $\tilde M$ with respect to the ordering of facets. 
strBoundwOrder = method()
strBoundwOrder List := ZZ => L -> (
    M := 1;
    S = for i from 1 to #L-1 list (
        T = simplicialComplex apply(i, j->gcd(L#j,L#i));
        if #facets simplicialComplex T == 1 then M = M else M = M + 1
    );
    last S
)

-- The function $\tilde M$ of the simplicial complex $\Delta$
-- INPUT: the list of facets
-- OUTPUT: the integer $\tilde M$.
strBound = method()
strBound SimplicialComplex := ZZ => G -> (
    L := facets G;
    N := permutations L;
    J = for k from 0 to #N - 1 list (
        M = 1;
        P = N#k;
        S = for i from 1 to #P-1 list (
            T = apply(i, j -> gcd(P#j,P#i));
            if #facets simplicialComplex T == 1 then M = M else M = M + 1
        );
        last S
    );
    min J
)

-- Find the list of facets with orderings that gives the value $\tilde{M}$.
-- INPUT: the list of facets
-- OUTPUT: the list of facets with orderings which gives the value $\tilde{M}$.
strBoundFacets = method()
strBoundFacets SimplicialComplex := ZZ => G -> (
    L := facets G;
    N := permutations L;
    J = for k from 0 to #N - 1 list (
        M = 1;
        P = N#k;
        S = for i from 1 to #P-1 list (
            T = apply(i, j -> gcd(P#j,P#i));
            if #facets simplicialComplex T == 1 then M = M else M = M + 1
        );
        last S
    );
    K = for l from 0 to #J - 1 list (
        if J#l == min J then N#l
    );
    delete(null,K)
)

-- CODE: Weak shelling of a simplicial complex with ordering of facets
-- INPUT: The list of facets of a simplicial complex
-- OUTPUT: A Boolean value and an ordered facets that is a weak shelling of the complex
weakShellwOrder = method ()
weakShellwOrder List := (Boolean,List) => L -> (
    K = for i from 1 to #L-1 list (
        J = for j from 0 to i-1 list (
            gcd (L#j,L#i)
        );
        T = simplicialComplex J;
        if #faces(0,T) > dim T + 2 then break; L#i
    );
    if prepend(L#0,K) == L then return (true, prepend(L#0,K)) else return(false, null)
)

-- CODE: A weak shelling of a simplicial complex
-- INPUT: A simplicial complex
-- OUTPUT: A weak shelling of a simplicial complex
weakShelling = method ()
weakShelling SimplicialComplex := List => G -> (
    M := facets G;
    N := permutations M;
    for k from 0 to #N-1 do (
        L = N#k;
        K = for i from 1 to #L-1 list (
            J = for j from 0 to i-1 list (
                gcd (L#j,L#i)
            );
            T = simplicialComplex J;
            if #faces(0,T) > dim T + 2 then break; L#i
        );
        if prepend(L#0,K) == L then break L else null   
    )
)

-- CODE: Determine Weak shellable of a simplicial complex
-- INPUT: A simplicial complex
-- OUTPUT: Boolean value
isWeakShellable = method ()
isWeakShellable SimplicialComplex := Boolean => G -> (
    M := facets G;
    N := permutations M;
    O = for k from 0 to #N-1 do (
        L = N#k;
        K = for i from 1 to #L-1 list (
            J = for j from 0 to i-1 list (
                gcd (L#j,L#i)
            );
            T = simplicialComplex J;
            if #faces(0,T) > dim T + 2 then break; L#i
        );
        if prepend(L#0,K) == L then break L else null   
    );
    if #O == #L then true else "notWeakShellable"
)

-- CODE: The list of ordered facets that is a weak shelling with respect the facet orders
-- INPUT: A simplicial complex
-- OUTPUT: The list of ordered facets that are weak shellings of the complex
weakShellFacets = method ()
weakShellFacets SimplicialComplex := List => G -> (
    M := facets G;
    N := permutations M;
    O = for k from 0 to #N-1 list (
        L = N#k;
        K = for i from 1 to #L-1 list (
            J = for j from 0 to i-1 list (
                gcd (L#j,L#i)
            );
            T = simplicialComplex J;
            if #faces(0,T) > dim T + 2 then break; L#i
        );
        if prepend(L#0,K) == L then L else null   
    );
    delete(null,O)
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
minOrder SimplicialComplex := List => G -> (
    leftFacets := facets G;
    facetOrders := {last facets G};
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
