package com.example.galleryservice.exceptions;

public class GalleryServiceException extends Exception {

    public GalleryServiceException(String message) {
        super(message);
    }

    public GalleryServiceException(String message, Throwable cause) {
        super(message, cause);
    }

    public GalleryServiceException(Throwable cause) {
        super(cause);
    }
}
