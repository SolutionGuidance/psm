# Death Master File Layout

The official DMF file layout is:

```
ID | Name        | Description                                                | Type | Length
---------------------------------------------------------------------------------------------
1 | NPI            | National Provider Identifier, a unique identification    | CHAR | 10
                   |  number for health care providers                        |
2 | SSN4           | Last four digits of the individual's SSN                 | CHAR | 9
3 | PRSN_LAST_NAME | Last name of the individual                              | CHAR | 20
4 | PRSN_1ST_NAME  | First name of the individual                             | CHAR | 15
5 | DOB_RAW_TXT    | Birth date of the individual                             | CHAR | 8
6 | DOD_RAW_TXT    | Death date of the individual                             | CHAR | 8
```
