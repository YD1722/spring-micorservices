package com.example.imageservice.services;


import com.example.imageservice.models.NotificationItem;

public interface INotificationService {
    void sendNotification(NotificationItem message);
}
