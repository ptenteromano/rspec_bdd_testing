module ArticlesHelper
  # used to help in views
  def persisted_comments(comments)
      # We only want comments from the database - This accomplishes that
      comments.reject{ |comment| comment.new_record? }
  end

end
