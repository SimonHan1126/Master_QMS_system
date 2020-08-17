package frontend.model;

import frontend.constant.UserPermissionConstant;

/**
 * @author Simon-the-coder
 * @date 17/08/20 11:50 am
 */
public class TeamMember extends User {
    @Override
    public int getPermission() {
        return UserPermissionConstant.TEAM_MEMBER;
    }
}
