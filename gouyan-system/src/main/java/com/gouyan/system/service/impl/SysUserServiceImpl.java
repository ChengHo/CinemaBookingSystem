package com.gouyan.system.service.impl;

import com.gouyan.common.utils.JwtUtil;
import com.gouyan.common.utils.SaltUtils;
import com.gouyan.system.domin.LoginUser;
import com.gouyan.system.domin.SysUser;
import com.gouyan.system.domin.vo.SysUserVo;
import com.gouyan.system.mapper.SysUserMapper;
import com.gouyan.system.service.SysUserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lxd
 * @create 2020-11-22 21:45
 */
@Service("sysUserService")
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private SysUserMapper sysUserMapper;

    @Override
    public List<SysUser> findAll(SysUser sysUser) {
        return sysUserMapper.findAll(sysUser);
    }

    @Override
    public SysUser findById(Long id) {
        return sysUserMapper.findById(id);
    }

    @Override
    public SysUser findByName(String userName) {
        return sysUserMapper.findByName(userName);
    }

    /**
     * 处理注册逻辑
     * @param sysUser
     * @return
     */
    @Override
    public int add(SysUser sysUser) {
        if(!isUserNameUnique(sysUser.getUserName(), -1L)){
            throw new AuthenticationException("用户名重复");
        }
        //处理密码：md5 + salt + hash散列
        String salt = SaltUtils.getSalt(8);
        Md5Hash md5Hash = new Md5Hash(sysUser.getPassword(), salt, 1024);

        sysUser.setPassword(md5Hash.toHex());
        sysUser.setSalt(salt);
        return sysUserMapper.add(sysUser);
    }

    @Override
    public int update(SysUser sysUser) {
        if(!isUserNameUnique(sysUser.getUserName(), sysUser.getUserId())){
            throw new AuthenticationException("用户名重复");
        }
        SysUser originUser = sysUserMapper.findById(sysUser.getUserId());
        if(originUser == null){
            throw new AuthenticationException("用户不存在");
        }

        if(!originUser.getPassword().equals(sysUser.getPassword())){
            //修改了密码
            //重新处理密码存储
            String salt = SaltUtils.getSalt(8);
            Md5Hash md5Hash = new Md5Hash(sysUser.getPassword(), salt, 1024);

            sysUser.setPassword(md5Hash.toHex());
            sysUser.setSalt(salt);
        }
        return sysUserMapper.update(sysUser);
    }

    @Override
    public int delete(Long[] ids) {
        int rows = 0;
        for (Long id : ids) {
            rows += sysUserMapper.delete(id);
        }
        return rows;
    }

    @Override
    public LoginUser login(SysUserVo sysUserVo) {
        //登录，先查询用户信息
        SysUser user = sysUserMapper.findByName(sysUserVo.getUserName());
        if(user == null){
            throw new AuthenticationException("用户名不存在");
        }

        //验证密码
        Md5Hash md5Hash = new Md5Hash(sysUserVo.getPassword(), user.getSalt(), 1024);
        if(!user.getPassword().equals(md5Hash.toHex())){
            throw new AuthenticationException("用户名或密码错误");
        }

        //设置登录用户对象
        LoginUser loginUser = findLoginUser(sysUserVo);

        //颁发token
        String token = JwtUtil.sign(user.getUserName(), user.getPassword());
        loginUser.setToken(token);
        return loginUser;
    }


    @Override
    public LoginUser findLoginUser(SysUserVo sysUserVo) {
        return sysUserMapper.findLoginUser(sysUserVo);
    }

    @Override
    public boolean isUserNameUnique(String userName, Long userId) {
        List<Long> userIds = sysUserMapper.findUsersByName(userName);
        for(Long id : userIds){
            if(id.equals(userId)){
                return true;
            }
        }
        return userIds.isEmpty();
    }
}
