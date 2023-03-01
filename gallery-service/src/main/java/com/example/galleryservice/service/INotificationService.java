package com.example.galleryservice.service;

import com.example.galleryservice.models.NotificationItem;

public interface INotificationService {
    void sendNotification(NotificationItem message);
}
