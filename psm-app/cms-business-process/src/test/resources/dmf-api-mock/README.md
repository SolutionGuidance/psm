# Death Master File test data

This directory contains test data for mocking the [Death Master File
API](https://github.com/SolutionGuidance/cavetl/tree/master/dmf), as setting
it up is non-trivial and requires access to restricted data.

## Running the mock DMF API

To use this data in demonstrating the PSM, simply run the following command
from this directory:

```shell-session
$ python3 -m http.server 5001
```

This will start the [Python HTTP
server](https://docs.python.org/3.7/library/http.server.html) on port 5001 (the
default DMF API port the PSM expects; this can be overridden in
`cms.properties`), and will serve the files in the `dmf` subdirectory in the
same way the DMF API would respond.

## Test SSNs

The Veris Test API has three special testing social security numbers, which we match:

- `001-01-0001` will return a result with both a name and a matching DMF
  record, indicating that the person holding that SSN has died, and the PSM
  will record a **failure**
- `123-45-6789` will return a result with a name but without a matching DMF
  record, indicating that this is a recognized SSN and that the person holding
  that SSN is still alive, and the PSM will record a **success**
- `987-65-4321` will return a result without a name or a matching DMF record,
  indicating that this is not a recognized SSN and so there are no matching
  death records, and the PSM will record a **success**
- any other social security number will not return a result, and the PSM will
  record an **error**
