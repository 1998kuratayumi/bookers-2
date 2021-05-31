class BooksController < ApplicationController

 before_action :authenticate_user!

 def index
  @book = Book.new
  @books = Book.all
  @user = current_user
 end

 def create
   @book = Book.new(book_params)
   @books = Book.all
   @book.user_id = current_user.id
   if @book.save
    flash[:notice2] = "You have created book successfully."
    redirect_to book_path(@book)
   else
   @user = current_user
    render :index
   end
 end

 def show
  @book_new = Book.new
  @book = Book.find(params[:id])
  @user = @book.user
 end

 def edit
  @book = Book.find(params[:id])
   if @book.user == current_user
    render "edit"
   else
    redirect_to books_path
   end

 end


 def update
   @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice3] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
 end

 def destroy
  book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
 end



 private
 def book_params
   params.require(:book).permit(:title, :body)
 end
end