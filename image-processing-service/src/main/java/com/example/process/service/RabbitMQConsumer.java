package com.example.process.service;

import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

// TODO: Class level listeners not working ??
//@RabbitListener(queues = "${app.queue.name}")
@Component
public class RabbitMQConsumer {

//    @RabbitHandler
//    public void receive(String message) {
//        System.out.println("Received Message From RabbitMQ: " + message);
//    }

    @RabbitListener(queues = {"${app.queue.name}"})
    public void consume(String message) {
        System.out.println("Received Message From RabbitMQ: " + message);
    }
}
