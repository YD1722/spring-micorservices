package com.example.galleryservice;

import com.example.galleryservice.config.AppConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(AppConfig.class)
public class GalleryServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(GalleryServiceApplication.class, args);
    }
}
