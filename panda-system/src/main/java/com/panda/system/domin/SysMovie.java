package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SysMovie implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long movieId;

    //电影名称
    @NotBlank(message = "电影名称不能为空")
    private String movieName;

    //电影时长
    private Integer movieLength;

    //电影海报
    private String moviePoster;

    private String movieArea;

    //上映日期
    private Date releaseDate;

    //电影总票房
    private Double movieBoxOffice;

    //电影简介
    private String movieIntroduction;

    //电影图集
    private String moviePictures;

    //电影的类别
    private List<SysMovieCategory> movieCategoryList;

}
