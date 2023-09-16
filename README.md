Boyer-Moore string search
===

The BM string search algorithm is used in the [JavaScriptCore](https://trac.webkit.org/wiki/JavaScriptCore) Yarr (regex engine) JIT compiler. So I thought it'd be useful to figure out how it works.

BM string search uses pre-processing to use a minimal number of alignments when comparing the pattern to the text. A shift table is generated during pre-processing which determines the number of characters to shift by to perform the next character comparisons/match.


usage
---

```sh
dune build
# for example
dune exec boyer_moore "beef" "deadbeef"
# Pattern found at position 4        
# deadbeef
#     ^^^^
dune runtest
```


resources
---

- https://www.cs.utexas.edu/users/moore/best-ideas/string-searching/
- https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_string-search_algorithm
