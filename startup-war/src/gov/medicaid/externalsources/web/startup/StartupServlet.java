/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.externalsources.web.startup;

import gov.medicaid.screening.services.SchedulerService;
import gov.medicaid.screening.services.ServiceException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServlet;

/**
 * Startup for the external sources application.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class StartupServlet extends HttpServlet {

    /**
     * Empty constructor.
     */
    public StartupServlet() {
    }
    
    /**
     * Starts the EJB timers.
     */
    public void init() {
        try {
            SchedulerService dmfScheduler;
            SchedulerService pecosScheduler;
            
            InitialContext context = new InitialContext();
            dmfScheduler = (SchedulerService) context.lookup("ejblocal:cms-external-sources/services.jar/DeathMasterSchedulerBean#gov.medicaid.screening.services.SchedulerService");
            pecosScheduler = (SchedulerService) context.lookup("ejblocal:cms-external-sources/services.jar/PECOSSchedulerBean#gov.medicaid.screening.services.SchedulerService");
            
            System.out.println("Starting EJB Timers...");
            dmfScheduler.scheduleTimer();
            pecosScheduler.scheduleTimer();
        } catch (ServiceException e) {
            throw new IllegalStateException("Cannot start timers.", e);
        } catch (NamingException e) {
            throw new IllegalStateException("Cannot start timers.", e);
        }
    }
}