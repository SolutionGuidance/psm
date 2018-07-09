# PSM code style guidelines for Java

We would like the code in the PSM to be consistent and easily readable. To that
end, here are some of the code style guidelines we've adopted for our Java
code.

## Checkstyle

As much as possible, we have encoded our style guide into the static analysis
tool [Checkstyle](http://checkstyle.sourceforge.net/). It is included in our
build system as a Gradle task named `checkstyleMain`; you can run it from
within the `psm-app` subdirectory like so:

```shell-session
$ ./gradlew checkstyleMain
```

Checkstyle is run against all pull requests, and needs to pass for us to merge
a pull request.

## Imports

Import ordering is done in the way that Intellij IDEA does.  It is, as
follows:

* First all imports, then javax, then java
* Each group should be sorted lexonagraphically
* Static imports at bottom of list

Small note that the IDEA default doesn't enforce spaces between all groups,
so neither does the checkstyle for the PSM.  However, those are acceptable
and encouraged for larger groups of imports.
