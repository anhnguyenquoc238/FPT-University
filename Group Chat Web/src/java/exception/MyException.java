/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package exception;

/**
 *
 * @author Lenovo T530
 */
public class MyException extends Exception{
    private int errorCode;

    public MyException(int errorCode, Throwable thrwbl) {
        super(thrwbl);
        this.errorCode = errorCode;
    }

    public int getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(int errorCode) {
        this.errorCode = errorCode;
    }
    
    
    
    
}
