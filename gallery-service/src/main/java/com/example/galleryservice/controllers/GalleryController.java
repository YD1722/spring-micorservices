package com.example.galleryservice.controllers;

import com.example.galleryservice.models.Gallery;
import com.example.galleryservice.models.Notification;
import com.example.galleryservice.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.*;

@RestController
public class GalleryController {

    @Autowired
    private Environment env;

    @Autowired
    private ImageService imageService;

    public GalleryController(ImageService imageService) {
        this.imageService = imageService;
    }

    @GetMapping("/")
    public String home_ping() {
        return "Ping from Gallery Service running at port: " + env.getProperty("local.server.port");
    }

    @GetMapping("/gallery")
    public String home() {
        return "Hello from Gallery Service running at port: " + env.getProperty("local.server.port");
    }

    @GetMapping("/gallery/{id}")
    public Gallery getGallery(@PathVariable final int id) {
        Gallery gallery = new Gallery(id);

        // TODO: Check ways of calling other services
        String images = imageService.getImages();
        gallery.setImages(images);

        return gallery;
    }

    @PostMapping("/gallery/notification")
    public void sendNotifications(Notification notification){
    }

    // -------- Admin Area --------
    // This method should only be accessed by users with role of 'admin'
    @RequestMapping("/admin")
    public String homeAdmin() {
        return "This is the admin area of Gallery service running at port: " + env.getProperty("local.server.port");
    }
}
