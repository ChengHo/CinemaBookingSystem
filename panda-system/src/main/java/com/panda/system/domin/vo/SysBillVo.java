package com.panda.system.domin.vo;

import com.panda.system.domin.SysBill;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 接收前端增加订单的数据
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SysBillVo implements Serializable {

    //订单信息
    private SysBill sysBill;

    //若成功更新后场次的座位信息
    private String sessionSeats;

}
