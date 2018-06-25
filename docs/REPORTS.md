# REPORTS

## Overview

Reports are defined as a set of jsps in cms-web, in the admin/reports directory,
coupled with a set of controllers in the admin/report directory.  Each
controller feeds the same data into either a jsp, or outputting a csv using
the Apache Software Foundation's
[commons-csv](https://commons.apache.org/proper/commons-csv/).
The display is done using [D3](https://d3js.org/)

The initial work done on reports was collated in feature issue
[#739](https://github.com/SolutionGuidance/psm/issues/739)

## Architecture

The reports are pulled from the database using no specialized queries, then
grouped and sorted in java.  When displaying in html, a table is built, from
which data is extracted into a javascript object.  From that, the D3 graphs
are loaded up.

### ReportControllerUtils

There are a number of common functions that a majority of reports use that
are split out into the utility class:

* Grouping reports
* Generating CSV names
* Date conversion

### Inefficient database usage

Because the reports use the hibernate entities, and because some of the
relationships between those entities are not very well defined, it is
probable some of the reports will take a substantial amount of time when
used on large data sets.  Whether the correct solution will be to create
specialized queries to solve this problem, or to modify the relationships
between the entities is left for when the PSM data model becomes clearer.

See issue [#57](https://github.com/SolutionGuidance/psm/issues/57) for more
information on general DB improvements.

### Data transmission to javascript

It was a discussion at time of design on how best to get the data from the
database to javascript.  For ease of implementation, attributed html elements
are used in conjunction with javascript code to pull that data out.  Other
considerations that may be a better fit in the future:

* Using ajax to get the data
* Building the tables from a json blob which can then be used by D3
* Having a custom json blob sit on the page adjacent to the table
