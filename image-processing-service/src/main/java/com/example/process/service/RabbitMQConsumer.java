package com.example.process.service;

import com.example.process.exceptions.InvalidImageException;
import com.rabbitmq.client.Channel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Random;

// TODO: Class level listeners not working ??
//@RabbitListener(queues = "${app.queue.name}")
@Component
@Slf4j
public class RabbitMQConsumer {
//    @RabbitHandler
//    public void receive(String message) {
//        System.out.println("Received Message From RabbitMQ: " + message);
//    }

    // TODO: How this log instance is available when annotate with slf4j
    @RabbitListener(queues = {"${app.queue.name}"}, ackMode = "MANUAL")
    public void consume(String message, Channel channel, @Header(AmqpHeaders.DELIVERY_TAG) long tag) throws IOException {
        log.info("Received Message From RabbitMQ: " + message);

        try {
            validateImage();
            processImage(message);
            // false specifies that only the current message is acknowledged, not all preceding unacknowledged messages.
            channel.basicAck(tag, false);
        } catch (InvalidImageException e) {
            log.error("Invalid image", e);
            channel.basicReject(tag, false);
        } catch (Exception e) {
            log.error("error processing message image", e);
        }

    }

    private void validateImage() throws InvalidImageException {
        try {
            simulateRandomException(5);
        } catch (Exception e) {
            throw new InvalidImageException();
        }
    }

    private void processImage(String message) throws Exception {
        log.info("Processing file: " + message);

        try {
            Thread.sleep(5000);
            simulateRandomException(30);

            log.info("Image processing completed: " + message);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    private void simulateRandomException(int exceptionFactor) throws Exception {
        // Generate a random number between 0 and 99
        int randomNumber = new Random().nextInt(100);

        // Calculate the probability based on the exceptionFactor
        int exceptionProbability = Math.min(exceptionFactor, 100);

        // Throw an exception if the generated number is within the probability range
        if (randomNumber < exceptionProbability) {
            throw new Exception("Random exception occurred");
        }
    }

}
