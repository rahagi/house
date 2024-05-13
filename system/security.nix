{config, ...}: {
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIEYTCCAsmgAwIBAgIQMMJzGBEy0KYUqPjxBmuiojANBgkqhkiG9w0BAQsFADBJ
      MR4wHAYDVQQKExVta2NlcnQgZGV2ZWxvcG1lbnQgQ0ExDzANBgNVBAsMBnJoZ0Bw
      aTEWMBQGA1UEAwwNbWtjZXJ0IHJoZ0BwaTAeFw0yMzEyMTAwOTQwMzlaFw0zMzEy
      MTAwOTQwMzlaMEkxHjAcBgNVBAoTFW1rY2VydCBkZXZlbG9wbWVudCBDQTEPMA0G
      A1UECwwGcmhnQHBpMRYwFAYDVQQDDA1ta2NlcnQgcmhnQHBpMIIBojANBgkqhkiG
      9w0BAQEFAAOCAY8AMIIBigKCAYEArHVuoMIZSkKBcbgjQiJGeL+Mi5GqbYcmlI+j
      r7sRgsEcF1JgHHuWd3h3V+fO5P/aVbCNJag8NeJoxuACqUc/iI31Y991js9UC8IV
      sleY+IccDutPRkZP8kXilEFXCPD+TO6vxWpkekyjIRfegFOmsxfgbqpVARs7KCJe
      PgXx+iiXfsnZS7vtsUAX+gBmzLpDIov9/f7vRyOEQVJ6CQJ7xLdW+9QTS7dqRkcr
      Y6XNlblJqr8M93Jtsi1Z7GGSr2z+26c5fqAo2OABxMQ62ipHleeNnZ+MNPetIMGF
      ZOBJksg3j+iIxckfZ3BdKtXzZ0j9E6b7QoWOJjomiGUNfG5Ac0jaOdIJdjYz1Lb0
      3z1sSiCWtnQTkg14eKHX2Kph/X/+/ANDj7OSxiy7HSaMv8cvZY/Q1TCQX1sAExyW
      zaD46n+O4Xt6MIzJfpcm9Kvpajt5RRxC0azavuSX+Hzp+t7QmxEp+nrpd1QIcNUS
      UlzfqfB1Zgs+plxayxjE8OeUmponAgMBAAGjRTBDMA4GA1UdDwEB/wQEAwICBDAS
      BgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRnxKMapD876yuOdzKZzwlgxJHT
      uTANBgkqhkiG9w0BAQsFAAOCAYEAETdwcAnBg/8qWXcqS12Iw7YlXinl3Yme9wmk
      5r2bBHDHvlNOowjNlDUBeBo1ALc0QG6fNKGScMdTw69hjsjg1PRUUvXo4oXLo3fH
      5BjD2tYs5a+jIl3OI0AUXRmjWtjsRcv7hQbRwEd4Lbh3pnyE7GYdWWcdWWfupEog
      sISCOWAsRzzorZ5+ysCo1yS8WUGc11mYvs4OyfNfAL156h2PXS1FD68esPPNTcr8
      fpD+Uz/x7jOD07FCQKGQhcCpgFCDVrr64LF1LHkkRQFwR5aKodKBjtFCWB+/L8jV
      d4AUrByc/2cJ/RM98VHQBWpXjTwu4iYKHRAOWDjF5LqSHwp5JMzA1HhJdDuvDE5A
      AgJaz7qMGTKP8bJoKJSrV9Mf4eEeqI1uRbu8/MUzSxi/l2eAOClhD5A9OZAh6Qpd
      ptMk3q68iPQ4MUuvgoc7Ta6qwL54y8vCU77IWcmr64RZ5NJfpx5oFhel+r5D004P
      ++OHhfKnPEGo20WVptlULVXxHlk8
      -----END CERTIFICATE-----
    ''
  ];
}
