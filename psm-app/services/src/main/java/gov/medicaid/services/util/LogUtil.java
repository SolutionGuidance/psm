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

package gov.medicaid.services.util;

import java.io.IOException;
import java.util.HashMap;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;
import com.topcoder.util.log.LogManager;
import com.topcoder.util.log.jdk14.Jdk14LogFactory;

/**
 * Utility class for logging.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public final class LogUtil {

    /**
     * Generates string representation of objects.
     */
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();
    static {
        OBJECT_MAPPER.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
    }

    /**
     * A flag indicating that the proper log factory has been initialized.
     */
    private static boolean initialized = false;

    /**
     * <p>
     * Represents the entrance message.
     * </p>
     */
    private static final String MESSAGE_ENTRANCE = "Entering method [{0}].";

    /**
     * <p>
     * Represents the exit message.
     * </p>
     */
    private static final String MESSAGE_EXIT = "Exiting method [{0}].";

    /**
     * <p>
     * Represents the error message.
     * </p>
     */
    private static final String MESSAGE_ERROR = "Error in method [{0}], details:";

    /**
     * Private constructor.
     */
    private LogUtil() {
    }

    /**
     * Creates a new logger, making sure that the manager is using Log4J.
     *
     * @param name the name of the logger
     * @return the log instance
     */
    public static Log getLog(String name) {
        if (!initialized) {
            // join the log4j context
            LogManager.setLogFactory(new Jdk14LogFactory());
            initialized = true;
        }
        return LogManager.getLog(name);
    }

    /**
     * This method performs trace logging for method entry.
     *
     * @param log the log to use
     * @param signature the method signature
     * @param paramNames the parameter names
     * @param paramValues the parameter values
     */
    public static void traceEntry(Log log, String signature, String[] paramNames, Object[] paramValues) {
        if (log != null) {
            log.log(Level.DEBUG, MESSAGE_ENTRANCE, new Object[]{signature});
            if (paramNames != null && paramNames.length > 0) {
                try {
                    HashMap<String, String> params = new HashMap<String, String>();
                    for (int i = 0; i < paramValues.length; i++) {
                        params.put(paramNames[i], OBJECT_MAPPER.writeValueAsString(paramValues[i]));
                    }
                    log.log(Level.DEBUG, "Arguments: " + OBJECT_MAPPER.writeValueAsString(params));
                } catch (JsonGenerationException e) {
                    log.log(Level.WARN, "Method arguments could not be serialized: " + e.getMessage());
                } catch (JsonMappingException e) {
                    log.log(Level.WARN, "Method arguments could not be serialized: " + e.getMessage());
                } catch (IOException e) {
                    log.log(Level.WARN, "Method arguments could not be serialized: " + e.getMessage());
                }
            }
        }
    }

    /**
     * This method performs trace logging for method exit.
     *
     * @param log the log to use
     * @param signature the method signature
     * @param output the return value values
     * @param <T> the type of the return value
     * @return the method output
     */
    public static <T extends Object> T traceExit(Log log, String signature, T output) {
        if (log != null) {
            log.log(Level.DEBUG, MESSAGE_EXIT, new Object[]{signature});

            if (output != null) {
                try {
                    log.log(Level.DEBUG, "Return Value: " + OBJECT_MAPPER.writeValueAsString(output));
                } catch (JsonGenerationException e) {
                    log.log(Level.WARN, "Method output could not be serialized: " + e.getMessage());
                } catch (JsonMappingException e) {
                    log.log(Level.WARN, "Method output could not be serialized: " + e.getMessage());
                } catch (IOException e) {
                    log.log(Level.WARN, "Method output could not be serialized: " + e.getMessage());
                }
            } else {
                log.log(Level.DEBUG, "Return Value: null");
            }
        }
        return output;
    }

    /**
     * This method performs trace logging for method error.
     *
     * @param log the log to use
     * @param signature the method signature
     * @param ex the exception encountered
     */
    public static void traceError(Log log, String signature, Throwable ex) {
        if (log != null) {
            log.log(Level.ERROR, ex, MESSAGE_ERROR, new Object[]{signature});
        }
    }
}