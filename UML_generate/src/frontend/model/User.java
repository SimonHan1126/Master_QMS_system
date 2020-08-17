package frontend.model;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 17/08/20 11:44 am
 */
public abstract class User implements Serializable {
    private String userId;
    private String userName;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public abstract int getPermission();
}
