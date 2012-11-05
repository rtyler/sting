# Sting

Sting is a simple key-value store written in
[Ada](https://en.wikipedia.org/wiki/Ada_(programming_language)).

It's inspired, and contains concepts cribbed from
[Roxanne](https://github.com/rothrock/Roxanne), though may diverge in
functionality in the future.



## Getting started

In order to build/test Sting, you'll need an Ada compiler and runtime. I'm
currently using the [GNAT GPL 2012](http://libre.adacore.com/download/)
toolkit.

Once that's all downloaded/installed/whatever, you can start by running the
tests:

```
% make test
```

Assuming that all worked out swimmingly, you can then build a release binary
with:

```
% make release
```
