class BooksController < ApplicationController
  def index
    @new_book=Book.new
    @user=current_user
    @books=Book.all
    
  end
  
  def create
    book=Book.new(book_params)
    book.user_id=current_user.id
    if book.save
      flash[:success]="You have created book successfully."
      redirect_to book_path(book)
    else
      @new_book=book
      @books=Book.all
      @user=current_user
      render :index
    end
  end
  
  def show
    @new_book=Book.new
    @book=Book.find(params[:id])
    @user=@book.user
  end
  
  def edit
    @book=Book.find(params[:id])
    is_matching_login_user
  end
  
  def update
    book=Book.find(params[:id])
    if book.update(book_params)
      flash[:success]="You have updated book successfully."
      redirect_to book_path(book)
    else
      @book=book
      render :edit
    end
  end
  
  def destroy
    book=Book.find(params[:id])
    if book.destroy
      redirect_to books_path
    else
      render :show
    end
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    user=@book.user
    unless user.id==current_user.id
      redirect_to books_path
    end
    
  end
  
end
