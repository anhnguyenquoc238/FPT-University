/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package businesslayer;

import dao.MessageDao;
import exception.MyException;
import java.util.List;
import model.Message;

/**
 *
 * @author Lenovo T530
 */
public class MessageManagement {
    
    public static int insertMessage(Message newMessage) throws MyException{
        return new MessageDao().insertMessage(newMessage);
    }
    
    public static List<Message> loadRecentMessage() throws MyException{
        return new MessageDao().loadRecentMessage();
    }
    
    public static List<Message> loadOldMessage(int firstMessID, int count) throws MyException{
        return new MessageDao().loadOldMessage(firstMessID, count);
    }
}
