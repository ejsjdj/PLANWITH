package com.itbank.PLANWITH.component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailComponent {

	@Autowired private JavaMailSender mailSender;

	public int sendMessage(String email, String subject, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		
		MimeMessageHelper helper = new MimeMessageHelper(message, "UTF-8");
		
		try {
			helper.setFrom("ejsjdj@naver.com");	// 실제 테스트를 할때는 아이디를 올바르게 입력해야 한다
			helper.setTo(email);
			helper.setSubject(subject);
			helper.setText(content);
			mailSender.send(message);
			return 1;
		} catch (MessagingException e) {
			e.printStackTrace();
			return 0;
		}
	
	}
	
}
