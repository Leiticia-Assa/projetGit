public with sharing class INWIB2C_GenerateTransactionCode {
    public static string generate() {
		String hashString = '2000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
		Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
		String hexDigest = EncodingUtil.convertToHex(hash);
		return hexDigest;
	}
}