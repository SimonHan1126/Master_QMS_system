package frontend.view;

import frontend.helper.HttpHelper;
import frontend.model.FMEATable;
import frontend.model.User;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 17/08/20 12:45 pm
 */
public class FMEATablePage {

    private FMEATableRequest pack(FMEATable table, User user) {
        FMEATableRequest request = new FMEATableRequest();
        request.setTable(table);
        request.setUser(user);
        return request;
    }

    public void initFMEATable(String fmeaTableId) {
        HttpHelper.Get("getFMEATable", fmeaTableId);
    }

    public void createFMEATable(FMEATable table, User user) {
        HttpHelper.Post("createFMEATable", pack(table, user));
    }

    public void updateFMEATable(FMEATable table, User user) {
        HttpHelper.Post("updateFMEATable", pack(table, user));
    }

    public void removeFMEATable(FMEATable table, User user) {
        HttpHelper.Post("removeFMEATable", pack(table, user));
    }
}

class FMEATableRequest implements Serializable {
    private FMEATable table;
    private User user;

    public FMEATable getTable() {
        return table;
    }

    public void setTable(FMEATable table) {
        this.table = table;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
