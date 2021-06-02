package com.panda.common.page;

import com.panda.common.utils.StringUtil;

/**
 * 获取分页请求参数的实体类
 */
public class Page {

    //页码
    private Integer pageNum = 1;

    //页大小
    private Integer pageSize = 1000;

    //按列排序
    private String orderByColumn;

    //升序还是降序,"asc"表示升序(默认)、"desc"表示降序
    private String isAsc = "asc";

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * 将isAsc拼接在orderby后边
     *
     * @return
     */
    public String getOrderByColumn() {
        if (!StringUtil.isNotEmpty(orderByColumn)) {
            return "";
        }
        return orderByColumn + " " + isAsc;
    }

    public void setOrderByColumn(String orderByColumn) {
        this.orderByColumn = orderByColumn;
    }

    public String getIsAsc() {
        return isAsc;
    }

    public void setIsAsc(String isAsc) {
        if (StringUtil.isNotEmpty(isAsc)) {
            this.isAsc = isAsc;
        }
    }

}
