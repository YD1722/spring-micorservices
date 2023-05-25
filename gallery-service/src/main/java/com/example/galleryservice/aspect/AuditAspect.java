package com.example.galleryservice.aspect;

import com.example.galleryservice.services.GalleryService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

// TODO: What if we don't register this to spring container
@Aspect
@Component
public class AuditAspect {
    static final Logger logger = LoggerFactory.getLogger(GalleryService.class);

    private AuditAspect() {
    }

    @AfterReturning(pointcut = "@annotation(com.example.galleryservice.aspect.Audit)", returning = "object")
    private static void log(JoinPoint joinPoint, Object object) throws IllegalAccessException {
        String auditMessage = getMethodMessage(joinPoint);
        Class<?> objectClass = object.getClass();

        StringBuilder sb = new StringBuilder();

        sb.append("AUDIT-TRAIL: " + auditMessage);
        sb.append("OUT: {");

        for (Field field : objectClass.getDeclaredFields()) {
            field.setAccessible(true);

            if (isMasked(field)) {
                sb.append(field.getName() + "' : ***************");
            } else {
                sb.append(field.getName() + " : " + field.get(object));
            }
        }

        sb.append("}");

        logger.info(sb.toString());
    }


    private static String getMethodMessage(JoinPoint joinPoint) {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();

        Audit aspectLogger = method.getAnnotation(Audit.class);

        return aspectLogger.value();
    }

    private static boolean isMasked(Field field) {
        return field.isAnnotationPresent(Masked.class);
    }

}
