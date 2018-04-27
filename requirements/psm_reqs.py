#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Ingest PSM requirements from CSV files and make them available in Python.
#
# Copyright (C) 2018 Open Tech Strategies, LLC
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

__doc__ = """Module for working with PSM requirements."""

import csv
import re
from warnings import warn


class PSMRequirement():
    """Class representing one requirement."""
    req_family_re = re.compile("psm-([A-Z][A-Z])-[0-9.]+")
    def __init__(self,
                 family,
                 #                     # ----------------------------
                 #                     #       CSV header name
                 #                     # ----------------------------
                 req_id,               # "Requirement ID Number"
                 category,             # "Requirement Category"
                 description,          # "Requirement Statement"
                 priority,             # "Priority"
                 rank,                 # "Rank"
                 source,               # "Source"
                 source_doc,           # "Source Document"
                 release,              # "Release"
                 design_ref,           # "Design Reference"
                 acceptance_test_ref,  # "Acceptance Test Reference"
                 comment               # "Comment"
                 ):
        """FAMILY is a two-letter string indicating the requirements
        family, for example "FR", "IA", etc.  Every other parameter
        corresponds self-explanatorily to a CSV field."""
        self.family              = family
        self.req_id              = req_id
        self.category            = category
        self.description         = description
        self.priority            = priority
        self.rank                = rank
        self.source              = source
        self.source_doc          = source_doc
        self.release             = release
        self.design_ref          = design_ref
        self.acceptance_test_ref = acceptance_test_ref
        self.comment             = comment
        # Sanity check the req family.
        m = self.req_family_re.match(self.req_id)
        if m is None:
            warn("WARNING: No requirement family found for \"%s\"" % self.req_id)
        elif m.group(1) != family:
            warn("WARNING: family \"%s\" does not match req \"%s\"" % (family, self.req_id))

    def __str__(self):
        # We don't include self.family because it's implicit in self.req_id.
        return """\
        Requirement ID Number:     "%s"
        Requirement Category:      "%s"
        Requirement Statement:     "%s"
        Priority:                  "%s"
        Rank:                      "%s"
        Source:                    "%s"
        Source Document:           "%s"
        Release:                   "%s"
        Design Reference:          "%s"
        Acceptance Test Reference: "%s"
        Comment:                   "%s"\n""" \
            % (self.req_id.replace('"', '\\"'),
               self.category.replace('"', '\\"'),
               self.description.replace('"', '\\"'),
               self.priority.replace('"', '\\"'),
               self.rank.replace('"', '\\"'),
               self.source.replace('"', '\\"'),
               self.source_doc.replace('"', '\\"'),
               self.release.replace('"', '\\"'),
               self.design_ref.replace('"', '\\"'),
               self.acceptance_test_ref.replace('"', '\\"'),
               self.comment.replace('"', '\\"'))


class PSMRequirementException(Exception):
    "Exception raised if something is wrong about a requirement."
    pass


class PSMRequirementFamilyException(Exception):
    "Exception raised if something is wrong about a requirement family."
    pass


def get_reqs(csv_files):
    """Return a dictionary of PSMRequirements based on CSV_FILES.
    CSV_FILES is an array of (string) paths to CSV files.
    Return a dict mapping PSM req IDs to PSMRequirement instances."""
    reqs = {}
    families_seen = set()
    for csv_file_name in csv_files:
        family = None # two-letter req family code, e.g, "FR", "IA", etc
        m = re.match(".*reqs-([a-z][a-z])\.csv", csv_file_name)
        if m is None:
            raise PSMRequirementFamilyException(
                "ERROR: unable to identify requirement family "
                "from \"%s\"" % csv_file_name)
        family = m.group(1).upper()
        if family in families_seen:
            raise PSMRequirementFamilyException(
                "ERROR: encountered family '%s' more than once" % family)
        else:
            families_seen.add(family)
        with open(csv_file_name) as csv_file:
            csv_reader = csv.reader(csv_file)
            next(csv_reader)  # toss one row to skip the headers
            current_category = None
            for row in csv_reader:
                if row[1] != "":    # this is a category row
                    if row[0] != "":
                        warn("WARNING: category '%s' and req '%s' in same row" % (row[1], row[0]))
                    current_category = family + " " + row[1]
                elif row[0] != "":  # this is a requirement row
                    if current_category is not None:
                        row[1] = current_category
                    else:
                        warn("WARNING: requirement '%s' has no category" % (row[0]))
                    req = PSMRequirement(family, *row)
                    if req.req_id in reqs:
                        # Can't happen, but let's be extra careful.
                        raise PSMRequirementFamilyException(
                            "ERROR: encountered req '%s' more than once" % req.req_id)
                    reqs[req.req_id] = req
                else:
                    warn("WARNING: not really sure what this row is:")
                    warn("%s" % PSMRequirement(family, *row))
    return reqs

