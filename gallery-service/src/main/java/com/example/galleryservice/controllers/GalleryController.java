package com.example.galleryservice.controllers;

import com.example.galleryservice.aspect.audit.Audit;
import com.example.galleryservice.aspect.log.DebugLog;
import com.example.galleryservice.exceptions.GalleryServiceException;
import com.example.galleryservice.models.Gallery;
import com.example.galleryservice.services.GalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/gallery")
public class GalleryController {

    @Autowired
    private Environment env;

    @Autowired
    private GalleryService galleryService;

    public GalleryController(GalleryService galleryService) {
        this.galleryService = galleryService;
    }

    // -------- Admin Area --------
    // This method should only be accessed by users with role of 'admin'
    @PostMapping
    public ResponseEntity<String> createGallery(@RequestBody Gallery gallery) {
        try {
            galleryService.createGallery(gallery);
            return ResponseEntity.ok("Gallery created successfully");
        } catch (Exception e) {
            throw new ResponseStatusException(
                    HttpStatus.INTERNAL_SERVER_ERROR, "Error creating new gallery", e);
        }
    }

    // -------- Admin Area --------
    // This method should only be accessed by users with role of 'admin'
    @PutMapping
    public ResponseEntity updateGallery(@RequestBody Gallery gallery) {
        try {
            galleryService.updateGallery(gallery);
            return ResponseEntity.ok("Gallery created successfully");
        } catch (Exception e) {
            // API method level exception handling --> for global handling have to use controller advice
            throw new ResponseStatusException(
                    HttpStatus.INTERNAL_SERVER_ERROR, "Error creating new gallery", e);
        }
    }

    // TODO: Why make this variable final
    @GetMapping("/image/{id}")
    public Gallery getImage(@PathVariable final long id) {
        try {
            return galleryService.getGalleryById(id);
        } catch (GalleryServiceException e) {
            // TODO: Only checking the behavior of swagger doc here. update this
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "Error creating new gallery", e);
        }
    }

    @GetMapping("/video/{id}")
    public Gallery getVideo(@PathVariable final long id) {
        try {
            return galleryService.getGalleryById(id);
        } catch (GalleryServiceException e) {
            // TODO: Only checking the behavior of swagger doc here. update this
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "Error creating new gallery", e);
        }
    }

    @GetMapping("/ping")
    @Audit(operation = "health-check")
    public String healthCheck() {
        return "Hello !!, Gallery Service running at port: " + env.getProperty("local.server.port");
    }
}
