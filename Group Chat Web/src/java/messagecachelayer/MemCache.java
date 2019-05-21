/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package messagecachelayer;

import businesslayer.MessageManagement;
import exception.MyException;
import java.awt.BorderLayout;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Cache;
import model.Message;

/**
 *
 * @author Lenovo T530
 */
public class MemCache {

    private List<Cache> cacheList = new ArrayList();

    public MemCache() {

    }

    public void addCache(Cache c) {
        // add new cache to cache list
        if(cacheList.isEmpty()){
            cacheList.add(c);
            return;
        }
        for (int i = 0; i < cacheList.size(); i++) {
            if(cacheList.get(i).getMessage().getID() == c.getMessage().getID()){
                break;
            }
            else if(cacheList.get(i).getMessage().getID()>c.getMessage().getID()){
                cacheList.add(i,c);
                break;
            }
            else if(i == cacheList.size() - 1){
                cacheList.add(c);
                break;
            }
        }
    }

    public void getOldMessage(List<Message> oldMessList, int firstMessID) {
        
        // add last to oldMessList
        if (firstMessID <= 1) {
            return;
        }
        // search for old message in cacheList
        int position = cacheList.indexOf(new Cache(new Message(firstMessID - 1)));
        System.out.println("Position: " + position);
        if (position != -1) {
            for (int i = position; i >= 0 && oldMessList.size() < 10; i--) {
                // check the consecutive
                if (cacheList.get(i).getMessage().getID() == firstMessID - 1) {
                    // add to the end of the list
                    oldMessList.add(cacheList.get(i).getMessage());
                    // check expiration
                    System.out.println(cacheList.get(i).getDate().compareTo(new Date()));
                    if (cacheList.get(i).getDate().compareTo(new Date()) < 0) {
                        cacheList.remove(i);
                    }
                    // decrease the firstMessID;
                    firstMessID--;
                } else {
                    break;
                }
            }
        }

        // search for old message in database
        int needCount = 10 - oldMessList.size();
        if (needCount > 0) {
            List<Message> newMessList = null;
            try {
                newMessList = MessageManagement.loadOldMessage(firstMessID, needCount);
            } catch (MyException ex) {
                ex.printStackTrace();
            }
            if (newMessList != null) {
                // add to the oldMessList and cacheList
                for (Message m : newMessList) {
                    oldMessList.add(m);
                    addCache(new Cache(m));
                }
            }
        }
        
        System.out.println("Cache size: " + cacheList.size());
    }
}
