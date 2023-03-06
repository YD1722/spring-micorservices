//package com.example.galleryservice.service;
//
//import com.example.galleryservice.config.RabbitMQConfig;
//import com.example.galleryservice.models.NotificationItem;
//import org.springframework.amqp.rabbit.core.RabbitTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//@Service
//public class NotificationService implements INotificationService {
//
//    private RabbitTemplate rabbitTemplate;
//    @Autowired
//    private RabbitMQConfig rabbitMQConfig;
//
//    public NotificationService(RabbitTemplate rabbitTemplate) {
//        this.rabbitTemplate = rabbitTemplate;
//    }
//
//    public void sendNotification(NotificationItem message) {
//        rabbitTemplate.convertAndSend(rabbitMQConfig.getExchange(), rabbitMQConfig.getBindingKey(), message);
//    }
//}
