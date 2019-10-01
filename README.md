# simple_fortran_argsort
A simple "argsort" algorithm in modern Fortran, using mergesort. This should work in both .f90 and .F77 files.

## Usage

call merge_argsort(r,d)

r - a double precision (i.e. `real(kind=8)`) 1D array of values to be sorted. This array is unmodified
d - an integer (i.e. `integer(kind=4)`) array of the same size. This is modified and returned as a list of sorted indices. i.e. r(d) will be a sorted list

## Motivation and Notes

This is partially just an exercise in writing a simple O(nlogn) sorting algorithm in Fortran. This is an "argsort", which means that it returns a list of indices that give the sorted order.

It's also designed as a concise & generic sorting algorithm that can be extracted and pasted (almost) anywhere in any code, whether fixed-format or free-format. Sometimes when you're working with old codebases it can be cumbersome to compile with new libraries or to try to connect in big new modules. Sometimes you just want to quickly do some tests that require sorting something in Fortran, and the lack of an intrinsic sorting function means you're scouring the internet for something to copy rather than writing one yourself.

This should run in both modern Fortran (Fortran-90+) and "classic" Fortran (i.e. FORTRAN-77), sort of. Really, this is Fortran-90+, but there aren't any FORTRAN-77 compilers around anymore - there are just Fortran-90+ compilers that permit fixed-format. And this should work in fixed-format - it did in my tests at least.

This is also a very simple subroutine without error checking, so it's relying on the compiler and the programmer to catch problems if you pass things of the wrong type, huge arrays, etc.
