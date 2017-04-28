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
package gov.medicaid.entities;

/**
 * Represents an address.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class Address extends IdentifiableEntity {

    /**
     * Attention line.
     */
    private String attentionTo;

    /**
     * Address line 1.
     */
    private String line1;

    /**
     * Address line 2.
     */
    private String line2;

    /**
     * City.
     */
    private String city;

    /**
     * State code (2 chars).
     */
    private String state;

    /**
     * Zip code.
     */
    private String zipcode;

    /**
     * County.
     */
    private String county;

    /**
     * Default empty constructor.
     */
    public Address() {
    }

    /**
     * Gets the value of the field <code>city</code>.
     *
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * Sets the value of the field <code>city</code>.
     *
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Gets the value of the field <code>state</code>.
     *
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * Sets the value of the field <code>state</code>.
     *
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * Gets the value of the field <code>zipcode</code>.
     *
     * @return the zipcode
     */
    public String getZipcode() {
        return zipcode;
    }

    /**
     * Sets the value of the field <code>zipcode</code>.
     *
     * @param zipcode the zipcode to set
     */
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    /**
     * Gets the value of the field <code>county</code>.
     *
     * @return the county
     */
    public String getCounty() {
        return county;
    }

    /**
     * Sets the value of the field <code>county</code>.
     *
     * @param county the county to set
     */
    public void setCounty(String county) {
        this.county = county;
    }

    /**
     * Gets the value of the field <code>line1</code>.
     *
     * @return the line1
     */
    public String getLine1() {
        return line1;
    }

    /**
     * Sets the value of the field <code>line1</code>.
     *
     * @param line1 the line1 to set
     */
    public void setLine1(String line1) {
        this.line1 = line1;
    }

    /**
     * Gets the value of the field <code>line2</code>.
     *
     * @return the line2
     */
    public String getLine2() {
        return line2;
    }

    /**
     * Sets the value of the field <code>line2</code>.
     *
     * @param line2 the line2 to set
     */
    public void setLine2(String line2) {
        this.line2 = line2;
    }

    /**
     * Gets the value of the field <code>attentionTo</code>.
     *
     * @return the attentionTo
     */
    public String getAttentionTo() {
        return attentionTo;
    }

    /**
     * Sets the value of the field <code>attentionTo</code>.
     *
     * @param attentionTo the attentionTo to set
     */
    public void setAttentionTo(String attentionTo) {
        this.attentionTo = attentionTo;
    }
}
