require "dry/transaction"

class CreateUserTransaction
  include Dry::Transaction

  step :create

  private

  def create(input)
    u = User.new(email: input[:email], password: input[:password], profile_attributes: { first_name: input[:profile_attributes][:first_name], last_name: input[:profile_attributes][:last_name], date_of_birth: input[:profile_attributes][:date_of_birth]})
    if u.valid?
      u.save!
      Success(email: input[:email], password: input[:password], first_name: input[:profile_attributes][:first_name], last_name: input[:profile_attributes][:last_name], dob: input[:profile_attributes][:date_of_birth])
    else
      Faillure("Wrong arguments")
    end
  end
end
