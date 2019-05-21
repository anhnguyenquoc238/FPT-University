package messagecachelayer;

import businesslayer.MessageManagement;
import exception.MyException;
import java.util.ArrayList;
import java.util.List;
import model.Message;

/**
 *
 * @author Lenovo T530
 */
public class MessageCache {

    private List<Message> newMessageList = new ArrayList();

    private MemCache memCache = new MemCache();

    private Object lock = new Object();

    public MessageCache() {
        loadRecentMessage();
    }

    public int addMessage(Message newMessage) {
        // insert to database
        try {
            synchronized (lock) {
                int messageID = MessageManagement.insertMessage(newMessage);
                if (messageID < 0) {
                    return -1;
                }
                newMessage.setID(messageID);
                newMessageList.add(newMessage);
                while (newMessageList.size() > 50) {
                    newMessageList.remove(0);
                }
                return messageID;
            }
        } catch (MyException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public void loadRecentMessage() {
        try {
            List<Message> messageList = MessageManagement.loadRecentMessage();
            if (messageList.size() > 0) {
                newMessageList = messageList;
            }
        } catch (MyException ex) {
            ex.printStackTrace();
        }
    }

    public List<Message> getRecentMessage() {

        List<Message> recentMessageList = new ArrayList();
        for (int i = newMessageList.size() - 1; i >= 0 && recentMessageList.size() < 15; i--) {
            recentMessageList.add(0, newMessageList.get(i));
        }
        return recentMessageList;

    }

    public List<Message> getOldMessage(int firstMessID) {
        List<Message> oldMessTempList = new ArrayList();

        // get message from newMessageList;
        synchronized (lock) {
            if (newMessageList.isEmpty()) {

            } else if (newMessageList.get(0).getID() < firstMessID) {
                int position = newMessageList.indexOf(new Message(firstMessID));
                for (int i = position - 1; i >= 0 && oldMessTempList.size() < 10; i--) {
                    oldMessTempList.add(newMessageList.get(i));
                }
            }
        }

        // if not enough get from the mem cache
        if (oldMessTempList.size() < 10) {
            int newestID = oldMessTempList.isEmpty() ? firstMessID : oldMessTempList.get(oldMessTempList.size() - 1).getID();
            memCache.getOldMessage(oldMessTempList, newestID);
        }

        return oldMessTempList;
    }

    public List<Message> getNewMessage(int lastMessID) {
        
        List<Message> newMessTempList = new ArrayList();
        if (newMessageList.isEmpty()) {

        } else if (newMessageList.get(0).getID() >= lastMessID) {
            // GET FROM MemCached
        } else {
            // GET Message FROM NewMessageList
            for (Message m : newMessageList) {
                if (m.getID() > lastMessID) {
                    newMessTempList.add(m);
                }
            }
        }
        return newMessTempList;
    }

}
