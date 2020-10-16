package nz.ac.autuni.qmssystem.controller;

import com.mongodb.client.result.DeleteResult;
import nz.ac.autuni.qmssystem.constant.ErrorMessageConstant;
import nz.ac.autuni.qmssystem.dao.UserDao;
import nz.ac.autuni.qmssystem.errorModel.ErrorMessageObject;
import nz.ac.autuni.qmssystem.model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.Serializable;
import java.util.List;

/**
 * @author Simon-the-coder
 * @date 16/10/20 1:57 pm
 */
@RestController
@RequestMapping("/api/v1/user")
public class UserController {

    private static final Logger logger = LogManager.getLogger(RiskProcedureController.class);

    @Autowired
    private UserDao userService;

    @GetMapping("/getAllUser")
    public ResponseEntity<List<User>> getAllUser() {
        List<User> list = userService.getAllUser();
        logger.info("UserController getAllUser " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }

    @GetMapping("/findUserByName")
    public ResponseEntity<Serializable> findUserByName(String name) {
        User user = userService.findUserByName(name);
        if (user == null) {
            logger.info("UserController findUserByName 11111 ");
            return ResponseEntity.status(HttpStatus.OK).body(new ErrorMessageObject(ErrorMessageConstant.USER_NOT_EXIST));
        } else {
            logger.info("UserController findUserByName 22222 " + user.toString());
            return ResponseEntity.status(HttpStatus.OK).body(user);
        }
    }

    @PostMapping(value = "/saveUser", consumes = MediaType.APPLICATION_JSON_VALUE )
    public ResponseEntity<Serializable> saveUser(User user) {
        logger.info("UserController saveUser " + user.toString());
        userService.saveUser(user);
        return ResponseEntity.status(HttpStatus.OK).body(user);
    }

    @GetMapping("/findUserByUserId")
    public ResponseEntity<Serializable> findUserByUserId(String userId) {
        User user = userService.findUserByUserId(userId);
        if (user == null) {
            logger.info("UserController findUserByUserId ");
            return ResponseEntity.status(HttpStatus.OK).body(new ErrorMessageObject(ErrorMessageConstant.USER_NOT_EXIST));
        } else {
            logger.info("UserController findUserByUserId user " + user);
            return ResponseEntity.status(HttpStatus.OK).body(user);
        }
    }

    @GetMapping("/removeUser")
    public ResponseEntity<List<User>> removeRiskProcedure(String userId) {
        DeleteResult result =  userService.removeUserById(userId);
        logger.info("UserController removeUser result " + result.toString());
        List<User> list = userService.getAllUser();
        logger.info("UserController removeUser " + list.toString());
        return ResponseEntity.status(HttpStatus.OK).body(list);
    }
}
