1) Put all files in your test folder


2) put the following code in the top of "lasy.rkt":
(provide (all-defined-out))


3) put the following code in top of "q3.pl": 
:- module('q3', 
	[page_in_category/2,
	splitter_category/1,
	namespace_list/2]).


4) put the following code in top of "q6.pl": 
:- module('q6', 
	[sub/2]).


5) put the following code in top of "q6.rkt":
 (provide (all-defined-out))


6) run the typescript tests with AA-tsTests.ts


7) run the racket tests with AA-rktTests.rkt


8) run the prolog tests with AA-plTests.pl

importent 

notes:

* run the racket tests with Dr Racket 6.12, dosen't work via terminal.

* each tests will tell you if you fail, some tests will tell you how much you passed.

* prolog tests checked on lab computers

* racket tests for q6 may fail because of sorting algorithm that cannot guarantee one unique sorted order, if so check by hand the test expectations



