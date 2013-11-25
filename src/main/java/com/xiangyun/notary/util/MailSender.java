package com.xiangyun.notary.util;

import java.util.Date;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class MailSender {
	private static Properties props;
	private static String mailUser;
	private static String password;
	private static String mailFromUser;

	static {
		ResourceBundle bundle = PropertyResourceBundle.getBundle("config");
		props = new Properties();
		props.put("mail.smtp.auth", bundle.getString("mailAuth"));
		props.put("mail.smtp.host", bundle.getString("mailServer"));

		// props.put("mail.smtp.starttls.enable", bundle.getString("mailSSL"));
		// props.put("mail.smtp.socketFactory.class",
		// "javax.net.ssl.SSLSocketFactory");
		// props.put("mail.smtp.socketFactory.port",
		// bundle.getString("mailPort"));
		props.put("mail.smtp.port", bundle.getString("mailPort"));
		mailUser = bundle.getString("mailUser");
		password = bundle.getString("mailPassword");
		mailFromUser = bundle.getString("mailFromUser");
	}

	public static int sendEmail(String subject, String body, String to) {
		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(mailUser, password);
					}
				});
		// session.setDebug(true);
		System.out.println("initialized");
		try {
			Transport tr = session.getTransport("smtp");
			tr.connect(session.getProperty("mail.smtp.host"),
					session.getProperty("mail.smtp.user"),
					session.getProperty("mail.smtp.password"));

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(mailFromUser));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(to));
			message.setSubject(subject);
			Multipart mainPart = new MimeMultipart();
			BodyPart html = new MimeBodyPart();
			html.setContent(body, "text/html; charset=utf-8");
			mainPart.addBodyPart(html);
			message.setContent(mainPart);
			message.setSentDate(new Date());
			message.saveChanges();

			tr.sendMessage(message, message.getAllRecipients());
			tr.close();
			System.out.println("sent");
			return 1;

		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		sendEmail("这是一封中文邮件", "中文中文中文", "35763068@qq.com");

	}

}
