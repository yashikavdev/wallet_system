class TransactionsController < ApplicationController
  before_action :find_wallets, only: [:create]

  def create
    case transaction_params[:transaction_type]
    when 'credit'
      credit
    when 'debit'
      debit
    else
      render json: { error: 'Invalid transaction type' }, status: :unprocessable_entity and return
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity and return
  end

  private

  def find_wallets
    @wallet = Wallet.find_by(id: transaction_params[:wallet_id])
    @target_wallet = Wallet.find_by(id: transaction_params[:target_wallet_id]) if transaction_params[:target_wallet_id]

    render json: { error: 'Wallet not found' }, status: :not_found and return unless @wallet
  end

  def credit
    transaction = nil
    ActiveRecord::Base.transaction do
      transaction = @wallet.transactions.create!(amount: transaction_params[:amount], transaction_type: 'credit')
      @wallet.update!(balance: @wallet.balance + transaction_params[:amount].to_f)
    end
    render json: {
      message: 'Credit successful',
      transaction:,
      wallet: @wallet
    }, status: :created and return
  end

  def debit
    debit_transaction = nil
    credit_transaction = nil

    ActiveRecord::Base.transaction do
      if @wallet.balance >= transaction_params[:amount].to_f
        debit_transaction = @wallet.transactions.create!(amount: -transaction_params[:amount],
                                                         transaction_type: 'debit')
        @wallet.update!(balance: @wallet.balance - transaction_params[:amount].to_f)

        if @target_wallet
          credit_transaction = @target_wallet.transactions.create!(amount: transaction_params[:amount],
                                                                   transaction_type: 'credit')
          @target_wallet.update!(balance: @target_wallet.balance + transaction_params[:amount].to_f)
        end
      else
        render json: { error: 'Insufficient balance' }, status: :unprocessable_entity and return
      end
    end

    response = {
      message: 'Debit successful',
      debit_transaction:,
      wallet: @wallet
    }

    response[:credit_transaction] = credit_transaction if credit_transaction
    response[:target_wallet] = @target_wallet if @target_wallet

    render json: response, status: :created and return
  end

  def transaction_params
    params.require(:transaction).permit(:wallet_id, :target_wallet_id, :amount, :transaction_type)
  end
end
