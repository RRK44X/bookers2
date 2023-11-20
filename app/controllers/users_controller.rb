class UsersController < ApplicationController
  def index
    @new_book=Book.new
    @users=User.all
    @user=current_user
  end
  
  def show
    @new_book=Book.new
    @user=User.find(params[:id])
    @books=@user.books
  end

  def edit
    is_matching_login_user
    @user=User.find(params[:id])
  end
  
  def update
    is_matching_login_user
    user=User.find(params[:id])
    if user.update(user_params)
      flash[:success]="You have updated user successfully."
      redirect_to user_path
    else
      @user=user
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
    
  end
  
  def is_matching_login_user
    user=User.find(params[:id])
    unless user.id==current_user.id
      redirect_to user_path(current_user.id)
    end
    
  end
  
end
