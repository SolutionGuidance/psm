"""These are two quick bits of code that set up a logging environment
and then config and return a logger instance.

In your module, do:

import log
warn, info, debug, fatal = log.reporters()

And in main, do:

logger = log.logger()

"""

import logging
import logging.config
import inspect
import os
import sys

"""This is a setup string that gets executed with exec rather than
called.  It has the imports and definitions we do in every module for
logging.  It can't be a function because it needs to execute in
parent's scope and context.

"""

def loggername():
    return os.path.basename(os.path.dirname(__file__))

def reporters():
    logger = logging.getLogger(loggername())
    warn = logger.warning
    info = logger.info
    debug = logger.debug
    def fatal(m): logger.error(m); sys.exit(-1)
    return warn, info, debug, fatal

def logger():
    """Configure and return logger.  You can override this logging by
    putting logging.ini in a parent dir of caller's python file.

    """
    dirname = os.path.abspath(os.path.dirname(inspect.getfile(sys._getframe(1))))
    if os.path.exists(os.path.join(dirname, '../logging.ini')):
        logging.config.fileConfig(os.path.join(dirname,'../logging.ini'),
                                  disable_existing_loggers=False)
    else:
        logging.config.dictConfig(dict(
            version = 1,
            disable_existing_loggers = False,
            formatters = {
                'f': {'format':
                      '%(asctime)s %(name)-12s %(levelname)-8s %(message)s'}
            },
            handlers = {
                'h': {'class': 'logging.StreamHandler',
                      'formatter': 'f',
                      'level': logging.DEBUG}
            },
            root = {
                'handlers': ['h'],
                'level': logging.DEBUG,
            },
        ))
    return logging.getLogger(loggername())
