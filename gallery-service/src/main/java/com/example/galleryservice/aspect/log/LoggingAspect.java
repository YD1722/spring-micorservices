package com.example.galleryservice.aspect.log;


import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {

    @Pointcut("@annotation(DebugLog)")
    public void logPointcut(){
    }

    @Before("logPointcut()")
    public void logAllMethodCallsAdvice(JoinPoint joinPoint){
        System.out.println("method called " + joinPoint.getSignature().getName());
    }

}
