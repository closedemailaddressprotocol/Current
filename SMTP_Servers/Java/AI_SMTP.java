import com.sun.mail.smtp.SMTPServer;
import com.sun.mail.smtp.SMTPTransport;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SimpleSmtpServer {

public static void main(String[] args) {
// Configure the SMTP server properties
Properties props = new Properties();
props.put("mail.smtp.host", "your-smtp-host");
props.put("mail.smtp.port", "your-smtp-port");

// Create a Session object with authentication, if required
Session session = Session.getInstance(props, new Authenticator() {
protected PasswordAuthentication getPasswordAuthentication() {
return new PasswordAuthentication("your-username", "your-password");
}
});

try {
// Create a new SMTPServer
SMTPServer server = new SMTPServer(session);

// Set the message handler to process incoming messages
server.setMessageHandler(new MessageHandler() {
public void messageReceived(Message message) {
try {
// Process the received message
System.out.println("Received message: " + message.getSubject());
} catch (MessagingException e) {
e.printStackTrace();
}
}
});

// Start the server
server.start();

System.out.println("SMTP server started. Listening for incoming messages...");

// Keep the server running indefinitely
while (true) {
Thread.sleep(1000);
}
} catch (Exception e) {
e.printStackTrace();
}
}
}

//Please note that this code uses the `com.sun.mail.smtp.SMTPServer` class provided by the JavaMail API. You'll need to have the JavaMail library in your classpath to compile and run this code. You can download the JavaMail library from the Oracle website or use a build tool like Maven or Gradle to manage the dependencies.
