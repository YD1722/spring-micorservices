package com.example.galleryservice.service;

import com.example.galleryservice.config.AppConfig;
import com.example.galleryservice.models.NotificationItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Service
public class ImageService {
    @Autowired
    AppConfig appConfig;

    @Autowired
    INotificationService notificationService;

    public String getImages() {

        try {
            // TODO: How to change type of the http response

            HttpRequest httpRequest = HttpRequest.newBuilder().uri(new URI(appConfig.getImageServiceUrl() + "/images")).GET().build();
            HttpResponse<String> response = HttpClient.newHttpClient().send(httpRequest, HttpResponse.BodyHandlers.ofString());

            sendNotification(response.body());

            return response.body();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        return "";
    }

    public void sendNotification(String message) {
        notificationService.sendNotification(new NotificationItem(message));
    }
}
