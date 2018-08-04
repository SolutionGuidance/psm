/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.controllers

import gov.medicaid.entities.SearchResult
import org.springframework.web.servlet.ModelAndView
import spock.lang.Specification

import static gov.medicaid.controllers.ControllerHelper.MAX_PAGE_LINKS_TO_SHOW

class ControllerHelperTest extends Specification {

    def "current page details are added to model"(
            int pageNumber,
            int pageSize,
            int itemsOnPage,
            int pageStartItem,
            int pageEndItem
    ) {
        given:
        def results = generateResults(pageNumber, pageSize)
        results.setItems([true] * itemsOnPage)
        def mv = new ModelAndView()
        def controller = new ControllerHelper()

        when:
        controller.addPaginationDetails(results, mv)

        then:
        def model = mv.getModel()
        model["pageStartItem"] == pageStartItem
        model["pageEndItem"] == pageEndItem
        model["pageSize" + pageSize] == true

        where:
        pageNumber | pageSize | itemsOnPage || pageStartItem | pageEndItem
        1          | 10       | 0           || 0             | 0
        1          | 10       | 1           || 1             | 1
        1          | 10       | 10          || 1             | 10
        2          | 10       | 1           || 11            | 11
        2          | 25       | 25          || 26            | 50
        1          | 0        | 22          || 1             | 22
    }

    def "previous and next pages are added to model"(
            int pageNumber,
            int pageSize,
            int totalItems,
            boolean thereArePages,
            List<Integer> prevPages,
            List<Integer> nextPages
    ) {
        given:
        def results = generateResults(pageNumber, pageSize)
        results.setTotal(totalItems)
        def mv = new ModelAndView()
        def controller = new ControllerHelper()

        when:
        controller.addPaginationLinks(results, mv)

        then:
        def model = mv.getModel()
        model["prevPages"] == prevPages
        model["nextPages"] == nextPages
        model["thereArePages"] == thereArePages
        model["currentPage"] == pageNumber
        model["nextPages"].size() + model["prevPages"].size() <= MAX_PAGE_LINKS_TO_SHOW

        where:
        pageNumber | pageSize | totalItems || thereArePages | prevPages    | nextPages
        1          | 10       | 0          || false         | []           | []
        1          | 10       | 1          || true          | []           | []
        1          | 10       | 10         || true          | []           | []
        1          | 10       | 11         || true          | []           | [2]
        2          | 25       | 26         || true          | [1]          | []
        2          | 10       | 30         || true          | [1]          | [3]
        1          | 0        | 15         || true          | []           | []
        5          | 10       | 50         || true          | [1, 2, 3, 4] | []
        5          | 10       | 60         || true          | [2, 3, 4]    | [6]
        4          | 10       | 60         || true          | [2, 3]       | [5, 6]
        3          | 10       | 60         || true          | [2]          | [4, 5, 6]
        3          | 10       | 70         || true          | [1, 2]       | [4, 5]
        1          | 10       | 70         || true          | []           | [2, 3, 4, 5]
        2          | 10       | 70         || true          | [1]          | [3, 4, 5]
    }

    SearchResult<?> generateResults(int pageNumber, int pageSize) {
        def results = new SearchResult<Object>()
        results.setPageNumber(pageNumber)
        results.setPageSize(pageSize)
        return results
    }
}
