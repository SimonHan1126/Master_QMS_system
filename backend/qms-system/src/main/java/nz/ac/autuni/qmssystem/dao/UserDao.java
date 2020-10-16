package nz.ac.autuni.qmssystem.dao;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.model.User;

import java.util.List;

/**
 * @author Simon-the-coder
 * @date 16/10/20 1:25 pm
 */
public interface UserDao {

    List<User> getAllUser();

    User findUserByName(String name);

    void saveUser(User user);

    User findUserByUserId(String userId);

    DeleteResult removeUserById(String id);
}
