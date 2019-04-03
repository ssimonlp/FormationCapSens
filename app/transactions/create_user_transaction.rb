require "dry/transaction"

class CreateUserTransaction
  include Dry::transaction

  step :validate
  step :create
  step :notify
  
  private

  def create(input)
    u = User.new(email: input[:email], password: input[:password], profile_attributes: { first_name: input[:profile_attributes][:first_name], last_name: input[:profile_attributes][:last_name], dob: input[:profile_attributes][:dob]})
    if u.valid?
      u.save
      Success(email: input[:email], password: input[:password], first_name: input[:profile_attributes][:first_name], last_name: input[:profile_attributes][:last_name], dob: input[:profile_attributes][:dob])
    else
      Faillure("Wrong arguments")
  end

  def notify(input)
    
  end
end
