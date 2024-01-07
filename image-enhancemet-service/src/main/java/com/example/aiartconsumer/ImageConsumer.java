package com.example.aiartconsumer;


import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;

@Component
public class ImageConsumer extends RouteBuilder {

    @Override
    public void configure() throws Exception {
        from("kafka:{{consumer.topic}}"
                + "?maxPollRecords={{consumer.maxPollRecords}}"
                + "&consumersCount={{consumer.consumersCount}}"
                + "&seekTo={{consumer.seekTo}}"
                + "&groupId={{consumer.group}}")
                .log("${body}");
    }
}
