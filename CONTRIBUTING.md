# PSM Contribution Guidelines

This document contains information of use to developers looking to
improve the PSM's codebase.  See [README.md](README.md) for an
introduction to this project, and if you're thinking of contributing
you might also want to look at [DESIGN.md](DESIGN.md).

## Submitting Code

This repository has a home on
[GitHub](https://github.com/OpenTechStrategies/psm).  Please submit
[pull requests](https://help.github.com/articles/about-pull-requests/) there.

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
