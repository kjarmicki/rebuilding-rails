class QuotesController < Rulers::Controller
  def a_quote
    render :a_quote, {
      noun: :winking,
      controller_name: self.class.name,
      rulers_gem_version: Rulers::VERSION
    }
  end

  def exception
    raise "It's a bad one"
  end
end
