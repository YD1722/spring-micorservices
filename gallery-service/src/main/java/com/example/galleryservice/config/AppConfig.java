package com.example.galleryservice.config;

import com.example.galleryservice.utils.Constants;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;


@Configuration
@ConfigurationProperties(prefix = "external.service")
@Getter
@Setter
public class AppConfig {
    private String imageServiceUrl;

    @PostConstruct
    public void postConstruct() {
        if (System.getenv(Constants.IMAGE_SERVICE_URL.name()) != null) {
            this.imageServiceUrl = System.getenv(Constants.IMAGE_SERVICE_URL.name());
        }
    }
}
