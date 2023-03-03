-- presets
loadPackage "GenericInitialIdeal"
loadPackage "SimplicialComplexes"

-- a function that bounds the regularity of a square-free monomial ideal
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
    #L-#faces(0,simplicialComplex L) + first degree L#0 + sum J
)

-- a function that bounds the regularity of a square-free monomial ideal
-- INPUT: a simplicial complex
-- OUTPUT: the value that gives a bound for the leray number of the simplicial complex
connBound = method()
connBound SimplicialComplex := ZZ => G -> (
    L = facets G;
    N = permutations L;
    J = for k from 0 to #N - 1 list (
            K = for i from 1 to #L-1 list (
                M = for j from 0 to i-1 list (
                    first(degree L#i) - first degree gcd(L#j,L#i) - 1
                );
            min M
        );
        #L-#faces(0,simplicialComplex L) + first degree L#0 + sum K    
    );
    min J
)

-- CODE: find the list of facets with orderings that gives the value for bounds on the Leray number.
-- INPUT: the simplicial complex
-- OUTPUT: the list of facets with orderings which gives the value for bounds on the Leray number.
connBoundFacets = method()
connBoundFacets SimplicialComplex := ZZ => G -> (
    L = facets G;
    N = permutations L;
    J = for k from 0 to #N - 1 list (
            K = for i from 1 to #L-1 list (
                M = for j from 0 to i-1 list (
                    first(degree L#i) - first degree gcd(L#j,L#i) - 1
                );
            min M
        );
        #L-#faces(0,simplicialComplex L) + first degree L#0 + sum K    
    );
    O = for l from 0 to #J - 1 list (
    if J#l == min J then N#l
    );
    delete(null,O)
)

-- CODE: the function $\tilde M$ of the simplicial complex $\Delta$ given order of facets
-- INPUT: the list of facets with ordering on facets
-- OUTPUT: the integer $\tilde M$ with respect to the ordering of facets. 
constructBoundwOrder = method()
constructBoundwOrder List := ZZ => L -> (
    M := 1;
    for i from 1 to #L-1 do (
        for j from 0 to i-1 do ( 
        T = simplicialComplex apply(i, j->gcd(L#j,L#i));
        );
        if facets simplicialComplex {product(faces(0,T))} == facets T then M = M;
        if facets simplicialComplex {product(faces(0,T))} =!= facets T then M = M + 1;
    );
    M
)

-- CODE: the function $\tilde M$ of the simplicial complex $\Delta$
-- INPUT: the list of facets
-- OUTPUT: the integer $\tilde M$.
constructBound = method()
constructBound SimplicialComplex := ZZ => G -> (
    L = facets G;
    N = permutations L;
    J = for k from 0 to #N - 1 list (
        M = 1;
        P = N#k;
            for i from 1 to #P-1 do (
            for j from 0 to i-1 do ( 
            T = simplicialComplex apply(i, j->gcd(P#j,P#i));
            );
            if facets simplicialComplex {product(faces(0,T))} == facets T then M = M;
            if facets simplicialComplex {product(faces(0,T))} =!= facets T then M = M + 1;
        );
        M
    );
    min J    
)

-- CODE: find the list of facets with orderings that gives the value $\tilde{M}$.
-- INPUT: the list of facets
-- OUTPUT: the list of facets with orderings which gives the value $\tilde{M}$.
constructBoundFacets = method()
constructBoundFacets SimplicialComplex := ZZ => G -> (
    L = facets G;
    N = permutations L;
    J = for k from 0 to #N - 1 list (
        M = 1;
        P = N#k;
            for i from 1 to #P-1 do (
            for j from 0 to i-1 do ( 
            T = simplicialComplex apply(i, j->gcd(P#j,P#i));
            );
            if facets simplicialComplex {product(faces(0,T))} == facets T then M = M;
            if facets simplicialComplex {product(faces(0,T))} =!= facets T then M = M + 1;
        );
        M
    );
    K = for l from 0 to #J - 1 list (
    if J#l == min J then N#l
    );
    delete(null,K)
)

TEST ///
R = QQ[x_1..x_6];
G = simplicialComplex {x_1*x_2*x_4,x_1*x_3*x_5,x_2*x_3*x_6,x_4*x_5*x_6};
L = facets G;
constructBoundwOrder L
constructBound G
constructBoundFacets G
connBoundwOrder L
connBound G
connBoundFacets G
///
end

restart
load "Bounds on Leray numbers.m2"
