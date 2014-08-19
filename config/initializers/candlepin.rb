Candlepin.load_resources("config/candlepin_resources.yml")
CANDLEPIN = Candlepin.new "http://127.0.0.1:8080/candlepin", "admin", "admin"
