class TransactionsController < ApplicationController
  def new
    @page_title = t('.create_new_transaction')
    @transaction = Transaction.new
  end

  def create
    @member = Member.find_by(email: params[:member][:email])
    @transaction = Transaction.new(transaction_params)

    if @member.nil?
      flash.now.alert = t('.member_not_found')
      render :new
    elsif @member.transactions << @transaction
      flash.notice = t('.transaction_was_saved')
      redirect_to root_path
    else
      flash.now.alert = @transaction.errors.full_messages
      render :new
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:description, :amount, :date)
  end
end
