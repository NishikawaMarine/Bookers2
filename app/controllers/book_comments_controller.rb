class BookCommentsController < ApplicationController
  def create
  	@book_comment = BookComment.new(book_comment_params)
  	@book_comment.user_id = current_user.id
  	@book_comment.book_id = params[:book_id].to_i
  	if @book_comment.save
  		redirect_back(fallback_location: books_path)
  	else
  		redirect_back(fallback_location: book_path(params[:book_id].to_i))
  	end
  end

  def destroy
  	@book_comment = BookComment.find_by(id: params[:id],book_id: params[:book_id])
  	@book_comment.destroy
  	redirect_back(fallback_location: book_path)
  end

  private
  def book_comment_params
  	params.require(:book_comment).permit(:book_comment)
  end
end
