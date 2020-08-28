package com.nicegold.helper;

import javax.servlet.http.HttpServletRequest;

public class PathHelper {
    private static String path;
    public static String getpath(HttpServletRequest req){
        path=req.getRealPath("/");
        return path;
    }
}
