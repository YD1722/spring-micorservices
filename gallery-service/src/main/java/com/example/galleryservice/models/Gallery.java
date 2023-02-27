package com.example.galleryservice.models;

import lombok.Data;

import java.util.List;

@Data
public class Gallery {
    private int id;

    // TODO: Check how to keep other domain types
    private String images;

    public Gallery(int id) {
        this.id = id;
    }

}
