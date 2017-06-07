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
package gov.medicaid.services;

/**
 * This defines a sequence generation interface used by the persistence implementation to maintain unique references.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface SequenceGenerator {

    /**
     * Retrieves the next value for the sequence.
     *
     * @param sequenceName the name of the sequence
     * @return the next value for the named sequence
     */
    long getNextValue(String sequenceName);
}