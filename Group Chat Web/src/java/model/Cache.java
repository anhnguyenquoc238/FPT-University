/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;


import java.util.Date;
import java.util.Objects;

/**
 *
 * @author Lenovo T530
 */
public class Cache {
    
    private Message message ;
    
    private Date date;
    
    public static final int EXPIRE_TIME = 60;
    
    public Cache(Message message){
        this.message = message;
        date = new Date();
        date.setSeconds(date.getSeconds()+EXPIRE_TIME);
    }

    public Cache(Message message, Date date) {
        this.message = message;
        this.date = date;
    }

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
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
        final Cache other = (Cache) obj;
        if (!Objects.equals(this.message, other.message)) {
            return false;
        }
        return true;
    }
    
    
    
    
    
}
