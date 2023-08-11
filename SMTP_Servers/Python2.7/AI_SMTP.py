import smtpd
import asyncore
import os
import time

class CustomSMTPServer(smtpd.SMTPServer):

    def __init__(self, *args, **kwargs):
        smtpd.SMTPServer.__init__(self, *args, **kwargs)
        self.log_file = "smtp_logs.txt"
        if not os.path.exists(self.log_file):
            with open(self.log_file, "w") as f:
                f.write("SMTP Server Log\n")
                f.write("=" * 50 + "\n")

    def process_message(self, peer, mailfrom, rcpttos, data):
        try:
            print 'Receiving message from:', peer
            print 'Message addressed from:', mailfrom
            print 'Message addressed to  :', rcpttos
            print 'Message length        :', len(data)

            with open(self.log_file, "a") as log:
                log.write(time.strftime("%Y-%m-%d %H:%M:%S") + "\n")
                log.write("From: " + mailfrom + "\n")
                log.write("To: " + ", ".join(rcpttos) + "\n")
                log.write("-" * 50 + "\n")
                log.write(data + "\n")
                log.write("=" * 50 + "\n")
            
            print 'Message saved to', self.log_file
        except Exception as e:
            print 'Error processing message:', e
            return "500 Server error: {}".format(e)

    def authenticate(self, user, password):
        # This is just a dummy authentication. Replace with a more secure method.
        return user == "test_user" and password == "test_pass"

server = CustomSMTPServer(('127.0.0.1', 1025), None)

print("SMTP server started at localhost on port 1025")
print("Log file: smtp_logs.txt")
asyncore.loop()
