// csharp
using System;
using System.Net;
using System.Net.Mail;
using System.Net.Sockets;
using System.Text;
using System.Threading;

public class SimpleSmtpServer
{
private const int SmtpPort = 25;

public static void Main(string[] args)
{
// Start the SMTP server on a separate thread
Thread serverThread = new Thread(StartSmtpServer);
serverThread.Start();

Console.WriteLine("SMTP server started. Listening for incoming messages...");

// Keep the main thread running until user input
Console.WriteLine("Press Enter to stop the server.");
Console.ReadLine();

// Stop the SMTP server
StopSmtpServer(serverThread);
Console.WriteLine("SMTP server stopped.");
}

private static void StartSmtpServer()
{
// Create a TCP listener on port 25
TcpListener listener = new TcpListener(IPAddress.Any, SmtpPort);
listener.Start();

try
{
while (true)
{
// Accept client connections
TcpClient client = listener.AcceptTcpClient();

// Start a new thread to handle the client
Thread clientThread = new Thread(() => HandleClient(client));
clientThread.Start();
}
}
catch (Exception ex)
{
Console.WriteLine("An error occurred: " + ex.Message);
}
finally
{
// Stop listening for new connections
listener.Stop();
}
}

private static void HandleClient(TcpClient client)
{
using (client)
{
// Get the client stream for reading and writing
using (NetworkStream stream = client.GetStream())
{
// Read the incoming data
byte[] buffer = new byte[client.ReceiveBufferSize];
int bytesRead = stream.Read(buffer, 0, buffer.Length);
string request = Encoding.ASCII.GetString(buffer, 0, bytesRead);

// Process the incoming message
Console.WriteLine("Received message:\n" + request);

// Send a response
string response = "250 OK\r\n";
buffer = Encoding.ASCII.GetBytes(response);
stream.Write(buffer, 0, buffer.Length);
stream.Flush();
}
}
}

private static void StopSmtpServer(Thread serverThread)
{
// Abort the server thread to stop the SMTP server
serverThread.Abort();
serverThread.Join();
}
}

// This C# code sets up a TCP listener on port 25 and accepts incoming client connections. It reads the incoming SMTP message, processes it, and sends a simple response. Please note that this is a basic implementation and does not handle all aspects of the SMTP protocol. For a complete SMTP server implementation, you may want to consider using a library or framework like MailKit or SmtpServer.
