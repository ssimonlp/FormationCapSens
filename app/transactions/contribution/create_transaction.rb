# frozen_string_literal: true

require 'dry/transaction'

class Contribution::CreateTransaction
  include Dry::Transaction

  tee :params
  tee :set_value
  step :new
  step :payin
  tee :save

  def params(input)
    @contribution = input.fetch(:params)
  end

  def set_value(_input)
    @contribution.value = @contribution.counterpart.price
  end

  def new(input)
    if @contribution.valid?
      Success(input)
    else
      Failure(input.merge(errors: @contribution.errors.full_messages.join(', ')))
    end
  end

  def payin(input)
    response = MangoPay::PayIn::Card::Web.create(payin_params(@contribution))
    if response['Id']
      Success(input.merge(redirection: response["RedirectURL"]))
    else
      Failure(input)
    end
  rescue MangoPay::ResponseError => e
    Failure(input.merge(errors: e.errors.to_a.join(': ')))
  end

  def save(_input)
    @contribution.save
  end

  protected

  def payin_params(contribution)
    {
      AuthorId: contribution.user.profile.mangopay_id,
      PaymentType: 'CARD',
      DebitedFunds: { Currency: 'EUR', Amount: contribution.counterpart.price },
      CreditedUserId: 64_347_949, # Id de l'admin pour l'instant
      Fees: { Currency: 'EUR', Amount: 0 },
      CreditedWalletId: 64_348_317,
      CardType: 'CB_VISA_MASTERCARD',
      ReturnURL: 'http://localhost:3000/projects',
      Culture: 'FR'
    }
  end
end
