/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Lenovo T530
 */
public class Message {
    
    private int ID;
    
    private int UserID;
    
    private String userName;
    
    private String content;

    public Message(){
        
    }

    public Message(int ID) {
        this.ID = ID;
    }
    
    
    public Message(int ID, int UserID, String userName, String content) {
        this.ID = ID;
        this.UserID = UserID;
        this.userName = userName;
        this.content = content;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }


    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Message other = (Message) obj;
        if (this.ID != other.ID) {
            return false;
        }
        return true;
    }
    
    
    
}
