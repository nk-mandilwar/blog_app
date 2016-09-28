class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def comments_tree_structure(post_comments, comments)
    post_comments.each do |comment|
      comments.push(comment)
      if( (children = comment.children).any? )
        comments_tree_structure(children, comments)
      end
    end
    comments
  end
  
end
