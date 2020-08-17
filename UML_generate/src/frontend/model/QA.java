package frontend.model;

import frontend.constant.UserPermissionConstant;

/**
 * @author Simon-the-coder
 * @date 17/08/20 11:55 am
 */
public class QA extends User {
    @Override
    public int getPermission() {
        return UserPermissionConstant.QA;
    }
}
