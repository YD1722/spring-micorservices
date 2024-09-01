package com.example.galleryservice.aspect.audit;

import com.example.galleryservice.services.GalleryService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.stream.Collectors;

// TODO: What if we don't register this to spring container
@Aspect
@Component
public class AuditAspect {
    static final Logger logger = LoggerFactory.getLogger(GalleryService.class);

    private AuditAspect() {
    }

    @Before("@annotation(Audit)")
    protected void audit(JoinPoint joinPoint) throws IllegalAccessException {
        String operation = getOperationIdentifier(joinPoint);
        String params = getParameters(joinPoint);
        logger.info("operation: {} : params: {}", operation, params);
    }


    private String getOperationIdentifier(JoinPoint joinPoint) {
        Method method = ((MethodSignature) joinPoint.getSignature()).getMethod();
        Audit annotation = method.getAnnotation(Audit.class);
        return annotation.operation();
    }

    private String getParameters(JoinPoint joinPoint) {
        Method method = ((MethodSignature) joinPoint.getSignature()).getMethod();
        return Arrays.stream(method.getParameters()).map(x-> x.toString()).collect(Collectors.joining(","));
    }

    private static String getFieldValue(Field field) {
        String fieldValue = field.getAnnotation(Audit.class).operation();
        return fieldValue.isEmpty() ? field.getName() : fieldValue;
    }

    private static boolean isMasked(Field field) {
        return field.isAnnotationPresent(Masked.class);
    }

}
