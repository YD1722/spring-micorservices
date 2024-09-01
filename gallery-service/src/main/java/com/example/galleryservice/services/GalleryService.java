package com.example.galleryservice.services;

import com.example.galleryservice.config.AppConfig;
import com.example.galleryservice.exceptions.GalleryServiceException;
import com.example.galleryservice.helpers.HttpRequestHelper;
import com.example.galleryservice.models.Gallery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GalleryService {
    Logger logger = LoggerFactory.getLogger(GalleryService.class);
    @Autowired
    AppConfig appConfig;

//    @Autowired
//    GalleryRepository galleryRepository;
//
    public void createGallery(Gallery gallery) {
        logger.info("gallery created");
//        galleryRepository.save(gallery);
    }

    public void updateGallery(Gallery gallery) {
//        throw new NotImplementedException();
    }

    public Gallery getGalleryById(long id) throws GalleryServiceException {
        Gallery gallery = new Gallery();
        gallery.setId(1);

        String images = this.getImages();
        gallery.setImages(images);

        return gallery;
    }

    protected String getImages() throws GalleryServiceException {
        try {
            // TODO: Check ways of calling other services ? may be camel (too heavy for a simple use case like this ?)
            String externalUrl = appConfig.getExternalServiceImageServiceUrl() + "/images";
            logger.info("Getting images from     : " + externalUrl);

            return HttpRequestHelper.get(externalUrl);
        } catch (Exception e) {
            throw new GalleryServiceException(e);
        }
    }
}
