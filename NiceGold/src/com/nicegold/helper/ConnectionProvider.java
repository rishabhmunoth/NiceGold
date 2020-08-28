package com.nicegold.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {

    public static Connection conn;

    public static Connection getConnection() {
        try {
            if (conn == null) {

                 Class.forName("com.mysql.cj.jdbc.Driver");
                conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/NiceGold", "root",
                        "rishabh");
            }
        } catch (ClassNotFoundException | SQLException ex) {
        }
        return conn;
    }
}
