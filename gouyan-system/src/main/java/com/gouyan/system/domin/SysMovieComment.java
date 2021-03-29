package com.gouyan.system.domin;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

/**
 * 演员角色实体类
 * @Author: 华雨欣
 * @Create: 2020-11-19 22:41
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SysMovieComment implements Serializable {

    private static final long serialVersionUID = 1L;

    //电影id
    @NotNull(message = "评论的电影不存在")
    private Long movieId;

    //用户id
    @NotNull(message = "评论的用户不存在")
    private Long userId;

    //评论时间
    @NotNull(message = "评论时间不能为空")
    private Date commentTime;

    //评论内容
    @NotBlank(message = "评论内容不能为空")
    private String content;

    //评分
    private Double score;


    //评论用户
    SysUser sysUser;

    //评论的电影
    SysMovie sysMovie;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getMovieId() {
        return movieId;
    }

    public void setMovieId(Long movieId) {
        this.movieId = movieId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public SysUser getSysUser() {
        return sysUser;
    }

    public void setSysUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }

    public SysMovie getSysMovie() {
        return sysMovie;
    }

    public void setSysMovie(SysMovie sysMovie) {
        this.sysMovie = sysMovie;
    }
}
