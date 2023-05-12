package com.example.galleryservice.controllers;

import com.example.galleryservice.models.Gallery;
import com.example.galleryservice.services.GalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.*;

@RestController
public class GalleryController {

    @Autowired
    private Environment env;

    @Autowired
    private GalleryService galleryService;

    public GalleryController(GalleryService galleryService) {
        this.galleryService = galleryService;
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
        Gallery gallery = new Gallery();
        gallery.setId(1);

        // TODO: Check ways of calling other services
        String images = galleryService.getImages();
        gallery.setImages(images);

        return gallery;
    }



    // -------- Admin Area --------
    // This method should only be accessed by users with role of 'admin'
    @RequestMapping("/admin")
    public String homeAdmin() {
        return "This is the admin area of Gallery service running at port: " + env.getProperty("local.server.port");
    }
}
