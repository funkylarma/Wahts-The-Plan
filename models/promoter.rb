class Promoter
  include MongoMapper::Document
  
  attr_accessor :password, :password_confirmation
  
  key :name, String, :required => true
  key :address, String, :required => true
  key :email, String
  key :url, String
  key :tel, String
  key :hashed_password, String
  key :salt, String
  
  validates_presence_of :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
 
  def self.authenticate(email, password)
    current_user = Promoter.find_by_email(email)
    return nil if current_user.nil?
    return current_user if Promoter.encrypt(password, current_user.salt) == current_user.hashed_password
    nil
  end
  
  def password=(pass)
    @password = pass
    self.salt = Promoter.random_string(10) if !self.salt
    self.hashed_password = Promoter.encrypt(@password, self.salt)
  end
  
  protected
  
  def password_required?
    self.hashed_password.blank? || !self.password.blank?
  end
  
  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end
  
  def self.random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
end