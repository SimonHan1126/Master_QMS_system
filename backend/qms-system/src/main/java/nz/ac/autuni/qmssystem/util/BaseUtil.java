package nz.ac.autuni.qmssystem.util;

import org.apache.commons.beanutils.BeanMap;
import org.springframework.data.mongodb.core.query.Update;

import java.util.Set;

/**
 * @author Simon-the-coder
 * @date 7/09/20 11:08 pm
 */
public class BaseUtil {

    private static BaseUtil instance;

    public static BaseUtil getInstance() {
        if(instance == null) {
            instance = new BaseUtil();
        }
        return instance;
    }

    public Update pushObjectToUpdate(Object modelObject) {
        Update update = new Update();
        BeanMap map = new BeanMap(modelObject);
        Set<Object> set = map.keySet();
        for (Object obj : set) {
            String key = (String)obj;
            update.set(key, map.get(key));
        }
        return update;
    }

}
