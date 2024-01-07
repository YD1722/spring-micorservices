package com.example.aiartconsumer;

import org.apache.camel.CamelContext;
import org.apache.camel.builder.component.ComponentsBuilderFactory;
import org.apache.camel.spring.boot.CamelContextConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Configs {

    @Bean
    public CamelContextConfiguration contextConfiguration() {
        return new CamelContextConfiguration() {
            @Override
            public void beforeApplicationStart(CamelContext camelContext) {
                // Use ComponentsBuilderFactory to configure Kafka component
                ComponentsBuilderFactory.kafka()
                        .brokers("{{kafka.brokers}}")
                        .register(camelContext, "kafka");
            }

            @Override
            public void afterApplicationStart(CamelContext camelContext) {

            }
        };
    }
}
