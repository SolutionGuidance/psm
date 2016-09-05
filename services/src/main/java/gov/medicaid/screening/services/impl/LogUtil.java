/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import java.io.IOException;
import java.util.HashMap;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;
import com.topcoder.util.log.LogManager;
import com.topcoder.util.log.log4j.Log4jLogFactory;

/**
 * Utility class for logging.
 *
 * <strong>This defines only static methods and is thread safe.</strong>
 *
 * @author j3_guile
 * @version 1.0
 */
public final class LogUtil {

    /**
     * Generates string representation of objects.
     */
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();
    static {
        OBJECT_MAPPER.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
        LogManager.setLogFactory(new Log4jLogFactory());
    }

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