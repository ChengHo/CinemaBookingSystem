package com.gouyan.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * @author lxd
 * @create 2020-11-25 9:59
 */

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class SysHall implements Serializable {
    private final static Long serialVersionUID = 1L;

    private Long cinemaId;

    private Long hallId;

    @NotBlank(message = "影厅名称不能为空")
    private String hallName;

    @NotNull(message = "影厅分类id不能为空")
    private Long hallCategoryId;

    //排开始标号：'1' / 'A' 等
    private String rowStart;

    //影厅排数
    @Min(value = 3, message = "排数不能小于3")
    @Max(value = 50, message = "排数不能大于50")
    private Integer rowNums;

    //每排座位数
    @Min(value = 3, message = "每排座位数不能小于3")
    @Max(value = 50, message = "每排座位数不能大于50")
    private Integer seatNumsRow;

    //总可用座位数，可以通过安排座位禁用指定座位
    @Min(value = 9, message = "座位数不能小于9")
    @Max(value = 2500, message = "座位数不能大于2500")
    private Integer seatNums;

    //座位的状态，使用json存储每个座位的状态，0表示可用，2表示禁用(1表示售出，在场次表中统计)
    private String seatState;

    @NotNull(message = "影厅状态不能为空")
    private Boolean hallState;


    //影厅表的多表连接
    private SysCinema sysCinema;

    private SysHallCategory sysHallCategory;

    public static Long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(Long cinemaId) {
        this.cinemaId = cinemaId;
    }

    public Long getHallId() {
        return hallId;
    }

    public void setHallId(Long hallId) {
        this.hallId = hallId;
    }

    public String getHallName() {
        return hallName;
    }

    public void setHallName(String hallName) {
        this.hallName = hallName;
    }

    public Long getHallCategoryId() {
        return hallCategoryId;
    }

    public void setHallCategoryId(Long hallCategoryId) {
        this.hallCategoryId = hallCategoryId;
    }

    public String getRowStart() {
        return rowStart;
    }

    public void setRowStart(String rowStart) {
        this.rowStart = rowStart;
    }

    public Integer getRowNums() {
        return rowNums;
    }

    public void setRowNums(Integer rowNums) {
        this.rowNums = rowNums;
    }

    public Integer getSeatNumsRow() {
        return seatNumsRow;
    }

    public void setSeatNumsRow(Integer seatNumsRow) {
        this.seatNumsRow = seatNumsRow;
    }

    public Integer getSeatNums() {
        return seatNums;
    }

    public void setSeatNums(Integer seatNums) {
        this.seatNums = seatNums;
    }

    public String getSeatState() {
        return seatState;
    }

    public void setSeatState(String seatState) {
        this.seatState = seatState;
    }

    public Boolean getHallState() {
        return hallState;
    }

    public void setHallState(Boolean hallState) {
        this.hallState = hallState;
    }

    public SysCinema getSysCinema() {
        return sysCinema;
    }

    public void setSysCinema(SysCinema sysCinema) {
        this.sysCinema = sysCinema;
    }

    public SysHallCategory getSysHallCategory() {
        return sysHallCategory;
    }

    public void setSysHallCategory(SysHallCategory sysHallCategory) {
        this.sysHallCategory = sysHallCategory;
    }
}
