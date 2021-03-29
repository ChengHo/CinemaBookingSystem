package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author lxd
 * @create 2020-11-19 18:32
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
@ToString
public class SysMovieCategory implements Serializable {
    //序列号
    private static final long serialVersionUID = 1L;
    //电影分类id
    private Long movieCategoryId;
    //电影分类名称
    @NotBlank(message = "电影分类名称不能为空")
    private String movieCategoryName;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getMovieCategoryId() {
        return movieCategoryId;
    }

    public void setMovieCategoryId(Long movieCategoryId) {
        this.movieCategoryId = movieCategoryId;
    }

    public String getMovieCategoryName() {
        return movieCategoryName;
    }

    public void setMovieCategoryName(String movieCategoryName) {
        this.movieCategoryName = movieCategoryName;
    }
}
