class BooksController < ApplicationController

	def index
		@book = Book.new
		@books = Book.all
		@user = current_user
	end

	def show
		@book_new = Book.new
		@book = Book.find(params[:id])
		@books = Book.all
		@book_comment = BookComment.new
		@book_comments = @book.book_comments
		@user = @book.user
	end
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "successfully"
			redirect_to book_path(@book)
		else
			@books = Book.all
			flash[:notice] = "error"
			render action: :index
		end
	end

	def edit
		@book =Book.find(params[:id])
		if current_user.id != @book.user_id
	 		redirect_to books_path
	 	end
	end

	def update
	 	@book = Book.find(params[:id])
	 	@book.update(book_params)
	 	if @book.save
			flash[:notice] = "successfully"
			redirect_to book_path(@book)
		else
			@book = Book.find(params[:id])
			flash[:notice] = "error"
			render action: :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
    end
    private

	def book_params
		params.require(:book).permit(:title, :body)
	end
end


