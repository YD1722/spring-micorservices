package com.example.process.service;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

@Service
public class RabbitMQConsumer {
    @RabbitListener(queues = "${rabbit.queueName}")
    public void receivedMessage(String message) {
        System.out.println("Received Message From RabbitMQ: " + message);
    }
}
