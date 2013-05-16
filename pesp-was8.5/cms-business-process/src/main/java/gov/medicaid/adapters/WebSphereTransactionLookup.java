/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.adapters;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.Status;
import javax.transaction.Synchronization;
import javax.transaction.SystemException;
import javax.transaction.Transaction;
import javax.transaction.TransactionManager;
import javax.transaction.UserTransaction;
import javax.transaction.xa.XAResource;

import org.hibernate.service.jta.platform.internal.AbstractJtaPlatform;

import com.ibm.websphere.jtaextensions.ExtendedJTATransaction;
import com.ibm.websphere.uow.UOWSynchronizationRegistry;
import com.ibm.wsspi.uow.UOWManager;

/**
 * This class is responsible for looking up container managed transactions for the hibernate provider and allowing
 * synchronizations.
 * 
 * It is based on the original discussion from https://forum.hibernate.org/viewtopic.php?f=1&t=992310 for websphere 6.1
 * but is adapted for WAS 8.5
 * 
 * WAS does not allow direct access to the JTA unlike other J2EE servers.
 * 
 * Additional information can be found here:
 * http://pic.dhe.ibm.com/infocenter/wasinfo/v8r5/topic/com.ibm.websphere.express.doc/ae/cjta_extjta.html
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class WebSphereTransactionLookup extends AbstractJtaPlatform {

    /**
     * http://pic.dhe.ibm.com/infocenter/wasinfo/v8r5/topic/com.ibm.websphere.express.doc/ae/cjta_extjta.html
     * 
     * To obtain the UOWManager interface in a container-managed environment, use a JNDI lookup of
     * java:comp/websphere/UOWManager. To obtain the UOWManager interface outside a container-managed environment, use
     * the UOWManagerFactory class. This interface is available only in a server environment.
     */
    private static final String SERVER_UOW_LOCATION = "java:comp/websphere/UOWManager";

    /**
     * http://pic.dhe.ibm.com/infocenter/wasinfo/v8r5/topic/com.ibm.websphere.express.doc/ae/cjta_extjta.html
     */
    private static final String SERVER_SYNCHRONIZATION_LOCATION = "java:comp/websphere/UOWSynchronizationRegistry";

    /**
     * Default user transaction lookup.
     */
    public static final String USER_TRANSACTION_LOCATION = "java:comp/UserTransaction";

    /**
     * Locates the transaction mananager.
     */
    protected TransactionManager locateTransactionManager() {
        return new TransactionManagerAdapter();
    }

    /**
     * Locates the user transaction (if any).
     */
    protected UserTransaction locateUserTransaction() {
        return (UserTransaction) jndiService().locate(USER_TRANSACTION_LOCATION);
    }

    /**
     * This adapter allows HIBERNATE to synchronize with WAS global transactions. Use only with CMT, where there is
     * always a transaction in the context of the call.
     * 
     * @author TCSASSEMBLER
     * @version 1.0
     */
    public class TransactionManagerAdapter implements TransactionManager {

        /**
         * Private constructor.
         */
        private TransactionManagerAdapter() {
        }

        /**
         * Retrieves the WAS transaction manager.
         */
        private UOWManager getUowManager() {
            try {
                InitialContext context = new InitialContext();
                return (UOWManager) context.lookup(SERVER_UOW_LOCATION);
            } catch (NamingException e) {
                throw new IllegalStateException("There is not UOWManager in the context, "
                    + "make sure you are using this class inside a WAS container.");
            }
        }

        /**
         * Retrieves the WAS synchronization registry.
         */
        private UOWSynchronizationRegistry getUowSynchronizationRegistry() {
            try {
                InitialContext context = new InitialContext();
                return (UOWSynchronizationRegistry) context.lookup(SERVER_SYNCHRONIZATION_LOCATION);
            } catch (NamingException e) {
                throw new IllegalStateException("There is not UOWManager in the context, "
                    + "make sure you are using this class inside a WAS container.");
            }
        }

        /**
         * Cannot begin a transaction when in CMT.
         */
        public void begin() throws NotSupportedException {
            // ignore (assumes CMT started a new transaction already)
        }

        /**
         * Cannot commit a container managed transaction
         */
        public void commit() {
            // ignore (assumes CMT will close the transaction)
        }

        /**
         * Returns the current state of the global transaction.
         * 
         * @return the transaction status
         * @throws SystemException if the status could not be inspected
         */
        public int getStatus() throws SystemException {
            return getTransaction() == null ? Status.STATUS_NO_TRANSACTION : getTransaction().getStatus();
        }

        /**
         * Retrieves the current transaction.
         * 
         * @return the transaction
         * @throws SystemException if the transaction could not be retrieved
         */
        public Transaction getTransaction() throws SystemException {
            return new TransactionAdapter();
        }

        /**
         * Call is ignored. Since we assume that the transaction attribute is used to control isolation.
         * 
         * @param txn the transaction to resume
         */
        public void resume(Transaction txn) {
            // ignore
        }

        /**
         * Throws an exception since we cannot roll back the global transaction.
         * 
         * @throws IllegalStateException if called
         */
        public void rollback() {
            // ignore (assumes CMT will rollback the transaction)
        }

        /**
         * Marks the global transaction for roll back.
         */
        public void setRollbackOnly() {
            getUowManager().setRollbackOnly();
        }

        /**
         * Throws an exception when called because we cannot modify the global transaction.
         */
        public void setTransactionTimeout(int i) throws SystemException {
            throw new IllegalStateException("Cannot modify global transaction.");
        }

        /**
         * Returns the current transaction.
         * 
         * @throws SystemException if the transaction cannot be retrieved
         */
        public Transaction suspend() throws SystemException {
            return getTransaction();
        }

        /**
         * This adapter allows inspection of some attributes of the global transaction.
         * 
         * @author TCSASSEMBLER
         * @version 1.0
         */
        public class TransactionAdapter implements Transaction {

            /**
             * WAS specific transaction API.
             */
            private final ExtendedJTATransaction extendedJTATransaction;

            /**
             * Looks up the WAS transaction.
             */
            private TransactionAdapter() {
                extendedJTATransaction = (ExtendedJTATransaction) jndiService().locate(
                    "java:comp/websphere/ExtendedJTATransaction");
            }

            /**
             * Registers the given synchronization.
             * 
             * @param synchronization the object to register
             */
            public void registerSynchronization(final Synchronization synchronization) {
                UOWSynchronizationRegistry registry = getUowSynchronizationRegistry();
              	registry.registerInterposedSynchronization(synchronization);
            }

            /**
             * Returns the object hash code.
             * 
             * @return a hash code
             */
            public int hashCode() {
                return getLocalId().hashCode();
            }

            /**
             * Checks equality based on id.
             * 
             * @return true if equal
             */
            public boolean equals(Object other) {
                if (!(other instanceof TransactionAdapter))
                    return false;
                TransactionAdapter that = (TransactionAdapter) other;
                return getLocalId().equals(that.getLocalId());
            }

            /**
             * Returns the transaction id.
             * 
             * @return the transaction id.
             */
            private Object getLocalId() {
                return extendedJTATransaction.getLocalId();
            }

            /**
             * Throws unsupported operation.
             */
            public void commit() {
                throw new UnsupportedOperationException();
            }

            /**
             * Throws unsupported operation.
             */
            public boolean delistResource(XAResource resource, int i) throws IllegalStateException, SystemException {
                throw new UnsupportedOperationException();
            }

            /**
             * Throws unsupported operation.
             */
            public boolean enlistResource(XAResource resource) throws RollbackException, IllegalStateException,
                SystemException {
                throw new UnsupportedOperationException();
            }

            /**
             * Retrieves the WAS transaction status.
             */
            public int getStatus() throws SystemException {
                switch (getUowManager().getUOWStatus()) {
                case UOWSynchronizationRegistry.UOW_STATUS_ACTIVE:
                    return Status.STATUS_ACTIVE;
                case UOWSynchronizationRegistry.UOW_STATUS_NONE:
                    return Status.STATUS_NO_TRANSACTION;
                case UOWSynchronizationRegistry.UOW_STATUS_COMMITTED:
                    return Status.STATUS_COMMITTED;
                case UOWSynchronizationRegistry.UOW_STATUS_ROLLEDBACK:
                    return Status.STATUS_ROLLEDBACK;
                case UOWSynchronizationRegistry.UOW_STATUS_ROLLBACKONLY:
                    return Status.STATUS_MARKED_ROLLBACK;
                case UOWSynchronizationRegistry.UOW_STATUS_COMPLETING:
                    return Status.STATUS_COMMITTING;
                default:
                    return Status.STATUS_UNKNOWN;
                }
            }

            /**
             * Throws an exception since we cannot roll back the global transaction.
             * 
             * @throws IllegalStateException if called
             */
            public void rollback() {
                throw new IllegalStateException("Cannot rollback CMT.");
            }

            /**
             * Marks the transaction for rollback.
             */
            public void setRollbackOnly() {
                getUowManager().setRollbackOnly();
            }
        }

    }

    /**
     * Returns the transaction id.
     */
    public Object getTransactionIdentifier(Transaction transaction) {
        return new Integer(transaction.hashCode());
    }
}