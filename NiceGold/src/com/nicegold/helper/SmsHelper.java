package com.nicegold.helper;

import java.net.URL;
import java.net.URLEncoder;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import sun.net.www.URLConnection;

public class SmsHelper {
	public boolean sendSms(String number, String msg) {
		boolean f = false;
		try {
			msg = URLEncoder.encode(msg, "UTF-8");
			String requestUrl = "http://trans.smsfresh.co/api/sendmsg.php?user=freshtranss&pass=bulk007&sender=SMSFRE&phone=7208951535&text="
					+ msg + "&priority=ndnd&stype=normal";
			URL url = new URL(requestUrl);
			URLConnection conn = (URLConnection) url.openConnection();
			conn.setDoOutput(true);
			f = true;
		} catch (Exception e) {
		}
		return f;
	}

	public boolean getRandomNumberForRegistrationOtpAndSendSms(HttpServletRequest req, String number) {
		Random r = new Random();
		int otp = r.nextInt(899999) + 100000;
		HttpSession s = req.getSession();
		s.setAttribute("userotp", otp);
//		System.out.println("otp is : " + otp);
		String msg = "Your OTP for Nice Gold Registration is : " + otp;
		boolean f = sendSms(number, msg);
		return f;
	}
}
