# PSM Contribution Guidelines

This document contains information of use to developers looking to
improve the PSM's codebase.  See [README.md](README.md) for an
introduction to this project, and if you're thinking of contributing
you might also want to look at [DESIGN.md](DESIGN.md).

## Submitting Code

This repository has a home on
[GitHub](https://github.com/OpenTechStrategies/psm).  Please submit
[pull requests](https://help.github.com/articles/about-pull-requests/)
(PRs) there.

### Branching and Branch Names

We do all development on lightweight branches, with each branch
encapsulating one logical changeset (that is, one group of related
commits).  Please try to keep changesets small and well-bounded: a
branch should usually be short-lived, and should be turned into a PR,
reviewed, and merged to `master` as soon as possible.  Keeping
branches short-lived reduces the likelihood of conflicts when it comes
time to merge them back into master.

When a branch is associated with an issue ticket, then the branch name
should start with the issue number and then give a very brief summary,
with hyphens as the separator, e.g.:

    871-fix-provider-risk-score

Everything after the issue number is just a reminder what the branch
addresses.  Sometimes a branch may address only part of an issue, and
that's fine: different branches can start with the same issue number,
as long as the summary following the issue number indicates what part
of the issue that particular branch addresses.

If there is no issue number associated with a branch, then don't start
the branch name with a number.

While there are no strict rules on how to summarize a branch's purpose
in its name, it may help to keep in mind some common starting words:
"`fix`", "`feature`", "`refactor`", "`remove`", "`improve`", and "`test`".

### Commit Messages
Please adhere
to [these guidelines](https://chris.beams.io/posts/git-commit/) for
each commit message.  The "Seven Rules" described in that post are:

1. Separate subject from body with a blank line
2. Limit the subject line to 50 characters
3. Capitalize the subject line
4. Do not end the subject line with a period
5. Use the imperative mood in the subject line
6. Wrap the body at 72 characters
7. Use the body to explain _what_ and _why_ vs. _how_

Think of the commit message as an introduction to the change.  A
reviewer will read the commit message right before reading the diff
itself, so the commit message's purpose is to put the reader in the
right frame of mind to understand the code change.

The reason for the short initial summary line is to support commands,
such as `git show-branch`, that list changes by showing just the first
line of each one's commit message.

### Indentation and Whitespace

Please uses spaces, never tabs.  Indent Java code by 4 spaces per
level, XML by 2 spaces per level, and avoid trailing whitespaces.  The
file [.editorconfig](.editorconfig) encodes these formatting
conventions in a way that most text editors can read.

Some of the legacy code here may not already conform to these
standards.  When you find yourself about to make changes to such code,
please first make a whitespace-only commit to regularize the
indentation, and then make a separate commit with your code changes.
For example, see commit efbf5413e, which made whitespace adjustments to
[persistence.xml](psm-app/cms-business-process/src/main/resources/META-INF/persistence.xml),
and was followed immediately by a substantive change to the same file
in commit 2fd2dd21e.

### Licensing Your Contribution
The PSM is published under the terms of version 2 of the
[Apache Software License](http://www.apache.org/licenses/).  It is
important that the codebase continue to be publishable under that
license.  To make that possible, here are some guidelines on including
3rd party code in the codebase.

If you submit code that you wrote or that you have authority to submit
from your employer or institution, you give it to us under version 2
of the Apache Software License.  If the material you submit is already
licensed under a more permissive license (BSD, MIT, ISC), you can tell
us that and give it to us under that license instead.

Please make the license of the code clear in your pull request.  Tell
us who wrote it, if that isn't just you.  If the code was written for
an employer, tell us that too.  Tell us what license applies to the
code, especially if it differs from the project's Apache 2.0 license.

If you submit code that doesn't come from you or your employer, we
call that "Third-Party Code" and have a few requirements.  If the code
contains a license statement, that's great.  If not, please tell us
the license that applies to the code and provide links to whatever
resources you used to find that out. For some examples, see the
LICENSE and METADATA parts of [Google's guide to introducing
third-party
code](https://opensource.google.com/docs/thirdparty/documentation/#license).

If your submission doesn't include Third Party Code, but instead
depends on it in some other way, we might need a copy of that
software.  Your submission should tell us where and how to get it as
well as the license that applies to that code.  We will archive a copy
of that code if we accept your pull request.

## Avoiding Generatable Elements In The Repo

As a general rule, we try to keep generated elements out of the
repository.  This includes files that result from build processes.  If
we want to memorialize a compiled version of the program, the best way
to do that is with tags or to record that information and put the
saved version somewhere other than this repository.  If a file can be
generated from the materials in the repository using
commonly-available tools, please do not put it in the repository
without raising it for discussion.
