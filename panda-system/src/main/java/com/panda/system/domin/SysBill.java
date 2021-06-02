package com.panda.system.domin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

/**
 * 订单实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SysBill implements Serializable {

    private static final Long serialVersionUID = 1L;

    private Long billId;

    //订单状态，0表示未支付，1表示已完成
    private Boolean payState;

    //下订单的用户id
    @NotNull(message = "下订单用户不能为空")
    private Long userId;

    //订单所属的场次
    @NotNull(message = "订单所属场次不能为空")
    private Long sessionId;

    //订单的座位，如：1排10号、A排5号
    @NotBlank(message = "订单所选座位不能为空")
    private String seats;

    private Boolean cancelState;

    private Boolean cancelRole;

    private Date createTime;

    private Date deadline;

    private Date cancelTime;

    // 用户名作模糊查询条件
    private String queryByUserName;

    // 管理员操作识别，及备注内容。管理员操作点单，或添加或修改，必须要填写备注信息，购票子系统不需要填写，并清空
    private String remark;
    // 删除状态，1：删除，0：未删除
    private Boolean delState;

    //多表连接
    private SysSession sysSession;

    private SysUser sysUser;

}
