class PwdFormatter
  def encrypt(input_string)
    Base64.encode64(input_string)
  end

  def decrypt(encrypted_string)
    Base64.decode64(encrypted_string)
  end
end
