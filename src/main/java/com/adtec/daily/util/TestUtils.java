package com.adtec.daily.util;

public class TestUtils {

    public static void main(String[] args) throws Exception {
        String pulicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC9uVehDMFBx7PjWbkisyZLBnn6E8MdX9C8mQekcGQdhSUWLI2m" +
                "PiDbr+uAe1R27D4bVxCY5GuC1z4RJ8bID30/zQpTYD8ZoyqiiM5CVW1tJVMFDdvUH9agfZp4VTvcAz4jB0Hqkft7iazxU2pQ" +
                "e+ZUxFV7aC178UQRsRLoaUEKbwIDAQAB";

        byte[] bytes = RSACoder.encryptByPublicKey("admin", pulicKey);
        String encryPassword =  RSACoder.encryptBASE64(bytes);
        System.out.println(encryPassword);
    }
}
