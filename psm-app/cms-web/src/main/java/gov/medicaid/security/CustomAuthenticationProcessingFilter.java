/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.security;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.TextEscapeUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Custom authentication filter that supports additional fields in the login form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class CustomAuthenticationProcessingFilter extends UsernamePasswordAuthenticationFilter {

    /**
     * Attempts to authenticate the user.
     *
     * @param request the current request
     * @param response the current response
     * @return the authentication result (may be null if not handled)
     */
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {
        if (!request.getMethod().equals("POST")) {
            throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
        }

        String username = obtainUsername(request);
        String password = obtainPassword(request);
        String domain = request.getParameter("domain");

        if (username == null) {
            username = "";
        }

        if (password == null) {
            password = "";
        }

        username = username.trim();

        DomainAuthenticationToken authRequest;
        if (domain == null || "MN_ITS".equalsIgnoreCase(domain)) {
            domain = "MN_ITS";
            String token = request.getParameter("token");
            String userNPI = request.getParameter("userNPI");
            String profileNPI = request.getParameter("profileNPI");
            String referrer = request.getParameter("referrer");
            authRequest = new DomainAuthenticationToken(userNPI, profileNPI, token, referrer, domain);
        } else {
            authRequest = new DomainAuthenticationToken(username, password, domain);
        }

        // Place the last username attempted into HttpSession for views
        HttpSession session = request.getSession(false);

        if (session != null || getAllowSessionCreation()) {
            request.getSession().setAttribute("LAST_USERNAME",
                TextEscapeUtils.escapeEntities(username));
        }

        // Allow subclasses to set the "details" property
        setDetails(request, authRequest);

        return this.getAuthenticationManager().authenticate(authRequest);
    }
}
