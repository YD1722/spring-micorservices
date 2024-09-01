package com.example.galleryservice.models;

import lombok.Getter;
import lombok.Setter;

//@Entity
@Setter
@Getter
public class Gallery {
//    @Id
//    @GeneratedValue
    private long id;

    private String name;

    // TODO: Check how to keep other domain types
    private String images;
}
