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

package gov.medicaid.features.general.ui;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.DefaultUrl;

import static org.assertj.core.api.Assertions.assertThat;

@DefaultUrl("http://localhost:8080/cms")
public class LoginPage extends PsmPage {

    public void enterCredentials(String username, String password) {
        $("#username").sendKeys(username);
        $("#password").sendKeys(password);
    }

    public void login() {
        click($("#btnLogin"));
    }

    public void checkUserLoggedIn(String username) {
        String welcomeText = $("#header > div > div.userSection").getText();
        assertThat(welcomeText).contains("Welcome, " + username);
    }

    public void checkUserLoggedOut() {
        assertThat(getTitle()).contains("Login");
    }
}
