package com.example.galleryservice.aspect.audit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AuditService {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public void beforeInvoke() throws Throwable {
        logger.info("Before invoke");
    }

    public void afterReturn(Object returnValue) throws Throwable {
        logger.info("value return was {}", returnValue);
    }
}
