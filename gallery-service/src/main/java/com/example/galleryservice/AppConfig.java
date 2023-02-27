package com.example.galleryservice;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "external.service")
@Getter
@Setter
public class AppConfig {
    private String imageServiceUrl;
}
