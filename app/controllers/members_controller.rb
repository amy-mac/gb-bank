class MembersController < ApplicationController
  def index
    @page_title = t('.members')
    @members = Member.all
  end

  def show
  end

  def new
    @page_title = t('.create_new_member')
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      flash.notice = t('.member_was_saved')
      redirect_to root_path
    else
      flash.now.alert = @member.errors.full_messages
      render :new
    end
  end

  def edit
    @page_title = t('.edit_member')
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update_attributes(member_params)
      flash.notice = t('.member_was_updated')
      redirect_to @member
    else
      flash.now.alert = @member.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private
  def member_params
    params.require(:member).permit(:name, :email)
  end
end
