package nz.ac.autuni.qmssystem.controller;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.Serializable;

/**
 * @author Simon-the-coder
 * @date 16/10/20 1:40 pm
 */
@RestController
@RequestMapping("/api/v1/login")
public class LoginController {
    private static final Logger logger = LogManager.getLogger(LoginController.class);

    @Autowired
    private UserDao userService;

    @PostMapping(value = "/login", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Serializable> login(@RequestBody User loginUser) {

        logger.info("LoginController login AAAAA loginUser " + loginUser.toString());
        User user = userService.findUserByName(loginUser.getUserName());
        if (user == null || !user.getPassword().equals(loginUser.getPassword())) {
            logger.info("LoginController login BBBBBB 11");
            return ResponseEntity.status(HttpStatus.OK).body(new ErrorMessageObject(ErrorMessageConstant.USER_NOT_EXIST));
        } else {
            logger.info("LoginController login CCCCC 11");
            return ResponseEntity.status(HttpStatus.OK).body(user);
        }
    }
}
