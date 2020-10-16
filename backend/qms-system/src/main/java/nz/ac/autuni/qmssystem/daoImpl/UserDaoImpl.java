package nz.ac.autuni.qmssystem.daoImpl;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.dao.UserDao;
import nz.ac.autuni.qmssystem.model.RiskProcedure;
import nz.ac.autuni.qmssystem.model.User;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Simon-the-coder
 * @date 16/10/20 1:30 pm
 */
@Component
public class UserDaoImpl implements UserDao {

    @Resource
    MongoTemplate mongoTemplate;

    @Override
    public List<User> getAllUser() {
        return mongoTemplate.findAll(User.class);
    }

    @Override
    public User findUserByName(String name) {
        Query query = new Query(Criteria.where("userName").is(name));
        User user = mongoTemplate.findOne(query, User.class);
        return user;
    }

    @Override
    public void saveUser(User user) {
        mongoTemplate.save(user);
    }

    @Override
    public User findUserByUserId(String userId) {
        Query query = new Query(Criteria.where("_id").is(userId));
        User user = mongoTemplate.findOne(query, User.class);
        return user;
    }

    @Override
    public DeleteResult removeUserById(String id) {
        Query query = new Query(Criteria.where("_id").is(id));
        DeleteResult deleteResult = mongoTemplate.remove(query, User.class);
        return deleteResult;
    }
}
