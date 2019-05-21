/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package businesslayer;

import dao.UserDao;
import exception.MyException;
import messagecachelayer.MessageCache;
import model.User;

/**
 *
 * @author Lenovo T530
 */
public class UserManagement {

    public static boolean checkUserName(String username) throws MyException{
        return new UserDao().checkUserName(username);
    }
    
    public static boolean checkAccount(User u) throws MyException{
        return new UserDao().checkAccount(u);
    }
    
    public static User getUserByUsername(String username) throws MyException{
        return new UserDao().getUserByUserName(username);
    }
    
    public static void insertAccount(User u) throws MyException {
        new UserDao().insertAccount(u);
    }
}
