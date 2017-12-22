class RelationcategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @category = Category.find(params[:relationcategorie][:followed_id])
    current_user.followcategorie!(@category)
    respond_to do |format|
      format.html { redirect_to(:back)}
      format.js
    end

  end

  def destroy
    @category = Relationcategory.find(params[:id]).followed
    current_user.unfollowcategorie!(@category)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end

  end

end