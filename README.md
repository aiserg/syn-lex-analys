#The calculator of matrix algebraic expressions
This work includes lexical and syntax analys. The program works with matrices 2x2, rowvectors and colvectors.

##Initialization
```
ROWVECTOR NAME(value1, value2)
COLVECTOR NAME(value1, value2)
MATRIX NAME((value1.1, value1.2)(value2.1, value2.2))
```
##Example
```
MATRIX A((1,2)(3,4))
ROWVECTOR R(7,8)
COLVECTOR С(3,6)
A=(R^+C)*C-A@
PRINT(A)
```
A@ is inverse matrix. R^ is vector transpose. Open console to see lex analizer (and little othen information)

##If you've forgotten
```
MATRIX * MATRIX = MATRIX
ROWVECTOR * COLVECTOR = NUMBER
COLVECTOR * ROWVECTOR = MATRIX
MATRIX +(-) ROWVECTOR or COLVECTOR or NUMBER = ERROR!
```


