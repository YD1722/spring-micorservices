package com.example.process.service;

import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;

@RabbitListener(queues = "${rabbit.queueName}")
public class RabbitMQConsumer {

    @RabbitHandler
    public void receive(String message) {
        System.out.println("Received Message From RabbitMQ: " + message);
    }
}
