import static org.apache.commons.codec.digest.MessageDigestAlgorithms.SHA_256;
import java.util.Base64;
import java.security.*;
import java.nio.charset.StandardCharsets;

public class oeag {

	public static void main(String[] args) throws NoSuchAlgorithmException {
		String plain;

		if (args.length > 0) {
			plain = args[0];

			System.out.println(plain);

			String sha256hex = org.apache.commons.codec.digest.DigestUtils.sha256Hex(plain);

			sha256hex = sha256hex.replaceAll("[^A-Za-z0-9]", "");

			System.out.println(sha256hex);

		} else {
			System.out.println("usage: oeag <authorization phrase>");
		}

	}

	public static String encode(final String clearText) throws NoSuchAlgorithmException {
		return new String(Base64.getEncoder()
				.encode(MessageDigest.getInstance("SHA-256").digest(clearText.getBytes(StandardCharsets.UTF_8))));
	}

}
