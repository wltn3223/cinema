package com.mire.cinema.domain.image;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Image {
    private long imageNo;
    private String imageUuid;
    private String imageName;
    private String imagePath;
    private Date imageDate;
}