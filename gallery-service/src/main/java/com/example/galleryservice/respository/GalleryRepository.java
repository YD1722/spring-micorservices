package com.example.galleryservice.respository;

import com.example.galleryservice.models.Gallery;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GalleryRepository extends JpaRepository<Gallery, Long> {
//    List<Gallery> findByName(String lastName);
//
//    Gallery findById(long id);
}
