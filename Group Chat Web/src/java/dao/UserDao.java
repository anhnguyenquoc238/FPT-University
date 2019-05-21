package dao;

import context.DBContext;
import exception.MyException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDao {

    private Connection connection;

    public UserDao() throws MyException {
        try {
            connection = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
            throw new MyException(0, e);
        }
    }

    public boolean checkUserName(String username) throws MyException {
        try {
            String sql = "select Username from [User] where Username = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return false;
            }
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new MyException(0, ex);
        }
    }

    public boolean checkAccount(User u) throws MyException {
        try {
            String sql = "select Username from [User] where Username = ? and Password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return false;
            }
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new MyException(0, ex);
        }
    }

    public User getUserByUserName(String username) throws MyException {
        User u = null;
        try {
            String sql = "select * from [User] where Username = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User();
                u.setID(rs.getInt("ID"));
                u.setUsername(username);
                u.setName(rs.getString("Name"));
                return u;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new MyException(0, ex);
        }
        return u;
    }

    public void insertAccount(User u) throws MyException {
        try {
            String sql = "insert into [User](Username, Name, Email, Password) values (?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getName());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new MyException(0, ex);
        }
    }

}
