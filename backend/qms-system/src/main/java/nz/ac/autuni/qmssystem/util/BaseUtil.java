package nz.ac.autuni.qmssystem.util;

import nz.ac.autuni.qmssystem.daoImpl.RiskProcedureDaoImpl;
import nz.ac.autuni.qmssystem.model.FMEATable;
import nz.ac.autuni.qmssystem.model.RiskProcedure;
import org.apache.commons.beanutils.BeanMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.mongodb.core.query.Update;

import java.io.Serializable;
import java.util.Set;

/**
 * @author Simon-the-coder
 * @date 7/09/20 11:08 pm
 */
public class BaseUtil {

    private static final Logger logger = LogManager.getLogger(BaseUtil.class);

    private static BaseUtil instance;

    public static BaseUtil getInstance() {
        if(instance == null) {
            instance = new BaseUtil();
        }
        return instance;
    }

    private Update setObjectToUpdate(Serializable object) {
        Update update = new Update();
        BeanMap map = new BeanMap(object);
        Set<Object> set = map.keySet();
        for (Object obj : set) {
            String key = (String)obj;
            update.set(key, map.get(key));
        }
        return update;
    }

    public Update setRiskProcedureToUpdate(RiskProcedure riskProcedure) {
        return setObjectToUpdate(riskProcedure);
    }

    public Update setFMEATableToUpdate(FMEATable fmeaTable) {
        return setObjectToUpdate(fmeaTable);
    }
}
