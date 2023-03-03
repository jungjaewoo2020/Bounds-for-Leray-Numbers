-- Presets
loadPackage "GenericInitialIdeal"
loadPackage "Resultants"
loadPackage "PhylogeneticTrees"
loadPackage "SimplicialComplexes"



-- An example
R = QQ[x_1..x_6]; -- set a polynomial ring so that variables are vertices of the complex
G = simplicialComplex {x_1*x_2*x_4,x_1*x_3*x_5,x_2*x_3*x_6,x_4*x_5*x_6} -- The simplicial complex consists of the facets in {}
L = facets G -- It gives the list of facets of the simplicial complex G.
strBoundwOrder L
strBound G
strBoundFacets G
connBoundwOrder L
connBound G
connBoundFacets G


-- Secant variety of rational normal curves and their generic ideals
(d,r) = (6,2);
R = QQ[x_0..x_d];
I = minors(r+1,matrix table(d-r+1,r+1,(i,j)->x_(i+j))) -- The ideal of secant variety of rational normal curve
IniI = gin I
PolarI = polarize monomialIdeal IniI
DeltaI = simplicialComplex PolarI
facets DeltaI
degree PolarI
codim PolarI

I
betti res PolarI

--- Projections of rational normal curves away from a point
(d,r) = (5,2);
R = QQ[x_0..x_d];
P1 = QQ[y_0,y_1];
phi = map(P1,R,basis(d,P1))
L1 = matrix (id_(R^(d+1))_(r-1))
L2 = randomRankPoint (d,r)
J = ker phi
I1 = ker projection(J,L1) -- The ideal of projections of rational normal curve
I2 = ker projection(J,L2)
IniI1 = gin I1
IniI2 = gin I2
IniJ = gin J
PolarI = polarize monomialIdeal IniI1
PolarJ = polarize monomialIdeal IniJ
DeltaI = simplicialComplex PolarI
DeltaJ = simplicialComplex PolarJ
degree PolarI
codim PolarI
betti res PolarI

--- Projections of rational normal curves away from a linear space
(d,r) = (6,{2,3});
R = QQ[x_0..x_d];
P1 = QQ[y_0,y_1];
phi = map(P1,R,basis(d,P1));
I = ker phi
L = matrix{apply(#r,i->sub(randomRankPoint(d,r_i),R))}
J = ker projection(I,L) -- The ideal of projections of rational normal curve
IniJ = gin J
PolarJ = polarize monomialIdeal IniJ
DeltaJ = simplicialComplex PolarJ
facets DeltaJ
degree PolarJ
codim PolarJ
betti res PolarJ
allRanks minors(3, (transpose vars R)|L)


--- Complete intersection of two quadrics
R = QQ[x_0..x_3];
I = ideal(random(2,R),random(2,R))
PolarI = polarize monomialIdeal gin I
Delta = simplicialComplex PolarI
degree PolarI
codim PolarI
betti res PolarI

--- A skew line in P^3
R = QQ[x_0..x_3]
I = ideal(x_0,x_1)*ideal(x_2,x_3)
I = polarize monomialIdeal gin I
Delta = simplicialComplex I

--- Example: Generic Initial ideals of rational normal curves
loadPackage "Resultants"
phi = veronese (1,4) --- The ring map of rational normal curve
I = ker phi -- I is the ideal of rational normal curve
J = monomialIdeal gin I -- J is the generic initial ideal
J = polarize J
betti res J
G = simplicialComplex J
L = facets G

--- Example: Initial Ideals of the Veronese surface
phi = veronese (3,3) --- The ring map of the Veronese surface (n,d), n = dim, d = degree.
I = ker phi -- I is the ideal of the Veronese surface
J = polarize monomialIdeal gin I -- J is the polarization of generic initial ideal
betti res J
G = simplicialComplex J
facets G
#facets G
degree J
codim J

--- Example: Initial Ideals of P^m*P^n
(m,n) = (2,2);
R1 = QQ[x_0..x_m];
R2 = QQ[y_0..y_n];
R = tensor(R1,R2)
phi = map(R,QQ[z_0..z_(m*n+m+n)],flatten entries (matrix(sub(transpose vars R1, R)) * sub(vars R2, R)) ) --- The ring map of P^m*P^n
I = ker phi -- I is the ideal of the Segre variety
J2 = polarize monomialIdeal gin (I, MonomialOrder => Lex)
J = polarize monomialIdeal gin I -- J is the polarized initial ideal
betti res I
betti res J
G = simplicialComplex J
G2 = simplicialComplex J2
L = facets G
#facets G
degree J
codim J


--- Example: complete intersection of two quadrics in P^3
loadPackage "Resultants"
R = QQ[x_0..x_3]
I = ideal(random(2,R),random(2,R)) 
J = polarize monomialIdeal gin I
betti res I
betti res J
G = simplicialComplex J

--- Example: rational normal scroll
loadPackage "Resultants"
(a,b) = (3,2);
R = QQ[x_0..x_(a+b+1)];
I = minors(2,matrix{{x_0..x_(a-1)},{x_1..x_a}}|matrix{{x_(a+1)..x_(a+b)},{x_(a+2)..x_(a+b+1)}})
J = polarize monomialIdeal gin I
betti res J
simplicialComplex J

--- Example: linear projection of rational normal curves 
phi = veronese (1,5)
I = ker phi
L = sub(randomRankPoint(5,3,target phi),ring I)
J = ker projection (I,L)
P = polarize monomialIdeal gin J

-- Example from the shellable non-pure complexes and poset 1
R = QQ[x_1..x_5];
G = simplicialComplex {x_1*x_2*x_3,x_3*x_4*x_5,x_1*x_5,x_2*x_5,x_1*x_4,x_2*x_4}
I = monomialIdeal G
betti res I
codim I
degree I
fVector G

-- Example: gluing of simplices
R = QQ[x_1..x_8];
G = simplicialComplex {x_1*x_2*x_3*x_5,x_1*x_3*x_5*x_6,x_1*x_3*x_4*x_6,x_1*x_4*x_6*x_7,x_1*x_2*x_4*x_7,x_3*x_4*x_6*x_8,x_2*x_3*x_4*x_8}
L = facets G
betti res monomialIdeal G
constructBoundwOrder L
constructBound G
constructBoundFacets G
connBoundwOrder L
connBound G
connBoundFacets G
