package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;

/**
 * @author lxd
 * @create 2020-11-27 10:09
 */

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysActorMovie implements Serializable {
    private static final Long SerialVersionUID = 1L;

    private Long movieId;

    private Long actorId;

    private Long actorRoleId;

    public static Long getSerialVersionUID() {
        return SerialVersionUID;
    }

    public Long getMovieId() {
        return movieId;
    }

    public void setMovieId(Long movieId) {
        this.movieId = movieId;
    }

    public Long getActorId() {
        return actorId;
    }

    public void setActorId(Long actorId) {
        this.actorId = actorId;
    }

    public Long getActorRoleId() {
        return actorRoleId;
    }

    public void setActorRoleId(Long actorRoleId) {
        this.actorRoleId = actorRoleId;
    }
}
