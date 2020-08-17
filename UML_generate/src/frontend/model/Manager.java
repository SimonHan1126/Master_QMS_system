package frontend.model;

import frontend.constant.UserPermissionConstant;

/**
 * @author Simon-the-coder
 * @date 17/08/20 11:53 am
 */
public class Manager extends User{
    @Override
    public int getPermission() {
        return UserPermissionConstant.MANAGER;
    }
}
