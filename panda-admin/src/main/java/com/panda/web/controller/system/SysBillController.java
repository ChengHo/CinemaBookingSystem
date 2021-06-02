package com.panda.web.controller.system;

import com.panda.common.exception.DataNotFoundException;
import com.panda.common.response.ResponseResult;
import com.panda.common.utils.ApplicationContextUtils;
import com.panda.system.domin.SysBill;
import com.panda.system.domin.SysMovie;
import com.panda.system.domin.SysSession;
import com.panda.system.domin.vo.SysBillVo;
import com.panda.system.service.impl.SysBillServiceImpl;
import com.panda.system.service.impl.SysMovieServiceImpl;
import com.panda.system.service.impl.SysSessionServiceImpl;
import com.panda.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
public class SysBillController extends BaseController {

    @Autowired
    private SysBillServiceImpl sysBillService;

    @Autowired
    private SysSessionServiceImpl sysSessionService;

    @Autowired
    private SysMovieServiceImpl sysMovieService;

    @GetMapping("/sysBill")
    public ResponseResult findAll(SysBill sysBill) {
        startPage();
        ApplicationContextUtils.getBean("cancelTimeoutBill");
        List<SysBill> data = sysBillService.findAll(sysBill);
        return getResult(data);
    }

    @GetMapping("/sysBill/{id}")
    public ResponseResult findById(@PathVariable Long id) {
        return getResult(sysBillService.findById(id));
    }

    @PostMapping("/sysBill")
    public ResponseResult add(@Validated @RequestBody SysBillVo sysBillVo) {
        System.out.println(sysBillVo);
        // 获取当前场次信息
        SysSession curSession = sysSessionService.findOne(sysBillVo.getSysBill().getSessionId());
        if (curSession == null) {
            throw new DataNotFoundException("添加订单的场次没找到");
        }
        System.out.println(curSession.getSessionSeats());
        curSession.setSessionSeats(sysBillVo.getSessionSeats());

        int addSallNums = sysBillVo.getSysBill().getSeats().split(",").length;
        curSession.setSallNums(curSession.getSallNums() + addSallNums);
        // 更新场次座位信息
        sysSessionService.update(curSession);

        Object obj = sysBillService.add(sysBillVo.getSysBill());
        if (obj instanceof Integer) {
            return getResult((Integer) obj);
        }
        return getResult(obj);
    }

    @PutMapping("/sysBill")
    public ResponseResult update(@RequestBody SysBill sysBill) {
        int rows = sysBillService.update(sysBill);
        if (rows > 0 && sysBill.getPayState()) {
            //更新场次的座位状态
            SysSession curSession = sysSessionService.findOne(sysBill.getSessionId());
            if (curSession == null) {
                throw new DataNotFoundException("支付订单的场次没找到");
            }
            //更新电影票房
            SysMovie curMovie = sysMovieService.findOne(curSession.getMovieId());
            if (curMovie == null) {
                throw new DataNotFoundException("支付订单的电影没找到");
            }
            //订单的座位数
            int seatNum = sysBill.getSeats().split(",").length;
            double price = curSession.getSessionPrice();
            curMovie.setMovieBoxOffice(curMovie.getMovieBoxOffice() + seatNum * price);
            sysMovieService.update(curMovie);
        }
        return getResult(rows);
    }

    @PutMapping("/sysBill/cancel")
    public ResponseResult cancel(@RequestBody SysBillVo sysBillVo) {
        // 订单取消，更新订单状态
        int rows = sysBillService.update(sysBillVo.getSysBill());
        if (rows > 0 && sysBillVo.getSysBill().getCancelState()) {
            // 订单取消座位不再占用，更新场次的座位状态
            SysSession curSession = sysSessionService.findOne(sysBillVo.getSysBill().getSessionId());
            // 取消的订单座位数
            int cancelSallNums = sysBillVo.getSysBill().getSeats().split(",").length;
            curSession.setSallNums(curSession.getSallNums() - cancelSallNums);
            if (curSession == null) {
                throw new DataNotFoundException("添加订单的场次没找到");
            }
            curSession.setSessionSeats(sysBillVo.getSessionSeats());
            sysSessionService.update(curSession);
        }
        return getResult(rows);
    }

    @DeleteMapping("/sysBill/{ids}")
    public ResponseResult delete(@PathVariable Long[] ids) {
        return getResult(sysBillService.delete(ids));
    }
}
