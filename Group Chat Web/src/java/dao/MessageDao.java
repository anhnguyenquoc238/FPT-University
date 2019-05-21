/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import context.DBContext;
import exception.MyException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Message;

/**
 *
 * @author Lenovo T530
 */
public class MessageDao {

    private Connection connection;

    public MessageDao() throws MyException {
        try {
            connection = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
            throw new MyException(0, e);
        }
    }

    public int insertMessage(Message newMessage) throws MyException {

        try {
            String sql = "insert into Message(UserID,[Content]) output inserted.ID values(?,?) ";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, newMessage.getUserID());
            ps.setString(2, newMessage.getContent());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int messageID = rs.getInt("ID");
                return messageID;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new MyException(0, ex);
        }
        return -1;
    }

    public List<Message> loadRecentMessage() throws MyException {
        List<Message> messageList = new ArrayList();
        int count = 50;
        try {
            String sql = "with temp as\n"
                    + "(\n"
                    + " select Message.*, Name\n"
                    + " from Message, [User]\n"
                    + " where Message.UserID = [User].ID\n"
                    + ")\n"
                    + "select top "+count+"*\n"
                    + "from temp\n"
                    + "order by ID desc";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Message temp = new Message();
                temp.setID(rs.getInt("ID"));
                temp.setUserID(rs.getInt("UserID"));
                temp.setUserName(rs.getString("Name"));
                temp.setContent(rs.getString("Content"));
                messageList.add(0,temp);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new MyException(0, ex);
        }
        return messageList;
    }
    
    public List<Message> loadOldMessage(int firstMessID, int count) throws MyException{
        List<Message> messageList = new ArrayList();
        try{
            String sql = "with temp as\n"
                    + "(\n"
                    + " select Message.*, Name\n"
                    + " from Message, [User]\n"
                    + " where Message.UserID = [User].ID\n"
                    + " and Message.ID < ? \n" 
                    + ")\n"
                    + "select top "+count+"*\n"
                    + "from temp\n"
                    + "order by ID desc";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, firstMessID);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Message temp = new Message();
                temp.setID(rs.getInt("ID"));
                temp.setUserID(rs.getInt("UserID"));
                temp.setUserName(rs.getString("Name"));
                temp.setContent(rs.getString("Content"));
                messageList.add(temp);
            }
        } catch (SQLException ex) {
            throw new MyException(0,ex);
        }
        
        return messageList;
    }
}
